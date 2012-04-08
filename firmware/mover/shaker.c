#include "shaker.h"
#include "api.h"
#include "ringbuffer.h"
#include "laser.h"
#include "move.h"
#include "lpc17xx_timer.h"
#include "alarm.h"

// Notice: NO stdio or other slow routines in this file!

unsigned int stepperIRQMax;
unsigned int stepperIRQAvg;

Axis axes[4];


#define MOVE_BUFFER_ORDER 12
RING_BUFFER(moves, MOVE_BUFFER_ORDER, unsigned int) IN_IRAM1;

inline char bufferIsFull() {
  return rbIsFullHidden(&moves);
}

inline void bufferMoveCode(unsigned int code) {
  movesArray[rbWriteHidden(&moves)] = code;
}

inline void bufferCommit() {
  rbShowHidden(&moves);
}

inline int bufferAvailable() {
  return (1<<MOVE_BUFFER_ORDER)-rbLengthHidden(&moves)-1;
}

inline int bufferInUse() {
  return rbLength(&moves);
}

inline char bufferIsEmpty() {
  return rbIsEmpty(&moves);
}

void codeError(char *msg) {
  // TODO: Add the error to an error stack along with the code value and the offset
  // from the last move start with id.
}


inline unsigned int bufferPop() {
  if (bufferIsEmpty()) {
    codeError("Truncated code");
    return 0;
  }
  return RB_READ(moves);
}


/*
  This huge heap of global variables make up the state needed for one move,
  be happy the bulk of the data is stored away in the axes array.
*/

// Are we currently in the middle of making a move?
int cuActive;

// The ID of the current move
unsigned int cuID; 

unsigned int getCurrentMove() {
  return cuID;
}

// Number of ticks left for this move.
unsigned int cuDuration;

// The Laser state:
int cuLaserPWM;
int cuLaserPWMA;
int cuLaserOn;

// The pixel state
int cuHasPixels;
int cuPS; // Pixel speed
int cuPE; // Pixel error (same semantics as cuXE and friends.
unsigned int cuPP; // current pixel position (0..31, pop another code when it overruns)
unsigned int cuPixelWord; // currently active wordful of pixels.
unsigned int cuPixelWords; // Number of pixel words left before next move.
unsigned int cuPV;

inline void bufferPopPixels() {
  if (!cuPixelWords) {
    codeError("Truncated pixels");
    return;
  }
  cuPixelWords--;
  cuPixelWord = bufferPop();
  cuPP = 0; // Start with first pixel of this word
}

inline void nextPixel() {
  if (cuPP > 31) {
    bufferPopPixels();
  }
  cuPV = cuPixelWord & 1<<cuPP++;
}

inline void startNewMove() {
  if (bufferIsEmpty()) {    
    
    /*
     TODO: If at least one axis is moving so fast it's impossible to stop it immediatly,
     produce a move to bring the machine to a graceful stop and set an alarm for the host to deal with.
    */

    return; // Well, never mind then.
  }

  unsigned int head = bufferPop();
  if (!IS_MOVE_START_CODE(head)) {
    codeError("Not a start code");
    return;
  }

  cuDuration = bufferPop();
  if (MOVE_HAS_ID(head)) {
    cuID = bufferPop();
  } else {
    cuID++;
  }

  axisNewMove(&axes[AXIS_X]);
  axisNewMove(&axes[AXIS_Y]);
  axisNewMove(&axes[AXIS_Z]);
  axisNewMove(&axes[AXIS_A]);
  
  // Load the speeds needed
  if (MOVE_HAS_XS(head)) axisSetSpeed(&axes[AXIS_X], bufferPop());
  if (MOVE_HAS_YS(head)) axisSetSpeed(&axes[AXIS_Y], bufferPop());
  if (MOVE_HAS_ZS(head)) axisSetSpeed(&axes[AXIS_Z], bufferPop());
  if (MOVE_HAS_AS(head)) axisSetSpeed(&axes[AXIS_A], bufferPop());

  // Load the accelerations needed
  if (MOVE_HAS_XA(head)) axisSetAccel(&axes[AXIS_X], bufferPop());
  if (MOVE_HAS_YA(head)) axisSetAccel(&axes[AXIS_Y], bufferPop());
  if (MOVE_HAS_ZA(head)) axisSetAccel(&axes[AXIS_Z], bufferPop());
  if (MOVE_HAS_AA(head)) axisSetAccel(&axes[AXIS_A], bufferPop());

  // See if we should be running the laser and at what power:
  if (MOVE_HAS_LASER(head)) {
    unsigned int lc = bufferPop();
    if (!IS_LASER_CODE(lc)) {
      codeError("Not a laser code");
      return;
    }
    
    cuLaserPWM = LASER_PWM(lc) << 16;
    cuLaserOn = 1;
  } else {
    cuLaserOn = 0;
  }  

  if (MOVE_HAS_LASER_A(head)) {
    cuLaserPWMA = bufferPop();

  } else {
    cuLaserPWMA = 0;
  }


  if (MOVE_HAS_PIXELS(head)) {
    cuHasPixels = 1;
    cuPS = bufferPop();
    cuPixelWords = bufferPop();
    cuPP = 42; nextPixel(); // Pops off a pixel word and readies the first pixel cuPV
  } else {
    cuHasPixels = 0;
  }

  cuActive = 1;
}

inline void continueCurrentMove() {

  // First handle the LASER
  if (cuLaserOn) {

    if (cuLaserPWMA) {
      cuLaserPWM += cuLaserPWMA;
    }

    setLaserPWM(cuLaserPWM >> 16);

    if (cuHasPixels) {
      cuPE += cuPS;
      if (cuPE > ONE_STEP) {
	cuPE -= ONE_STEP;
	nextPixel();
      }
      setLaserFire(cuPV);
    } else {
      setLaserFire(1);
    }

  } else {
    setLaserFire(0);
  }

  // Then move the motors
  axisTick(&axes[AXIS_X]);
  axisTick(&axes[AXIS_Y]);
  axisTick(&axes[AXIS_Z]);
  axisTick(&axes[AXIS_A]);

  // Check limit switches and emergency stop if any if them is triggered.
  unsigned int alarms = checkAlarmInputs();

  // TODO: Call water flow input poller.
  
  /*
    We deliver the end of the pulses in one heap here so we don't need to stick
    delays in each tick function and the pulses can be as long as possible.
  */
  axisTock(&axes[AXIS_X]);
  axisTock(&axes[AXIS_Y]);
  axisTock(&axes[AXIS_Z]);
  axisTock(&axes[AXIS_A]);

  if (!--cuDuration || alarms) {
    // TODO: Add check against left over pixel words.

    cuActive = 0; // Done with this move, let startNewMove pop another one.
  }
}

// This routine gets called at 20 kHz, don't fiddle about!
void TIMER2_IRQHandler(void) {
  TIM_ClearIntPending(LPC_TIM2, TIM_MR0_INT); // Must be done first thing
#ifdef IO_STEPPER_ACTIVE
  GPIO_SET(IO_STEPPER_ACTIVE); // Allow easy timing on oscilioscope
#endif
  /*
    Done with the initial setup, let's get down to business.
   */

  if (alarmCount()) {
    cuActive = 0;

  } else {

    /*
      If there is a currently active move continue doing it.
    */
    if (cuActive) {
      continueCurrentMove();
    }

    /*
      Note: We start the new move just after we're done with the previous one to
      minimize the jitter, because this way all the variable work happens after
      the stepping, so timing will not be off for the first step.
    */
    if (!cuActive) { 
      if (!alarmCount()) {
	startNewMove();
      }
    }
  }

  /*
    Here we keep some simple statistics on the number of micro seconds
    it takes to service the interrupt
  */
  unsigned int tc = LPC_TIM2->TC;
  if (tc > stepperIRQMax) {
    stepperIRQMax = tc;
  }
  stepperIRQAvg += ((tc<<16)-stepperIRQAvg) >> 8;
#ifdef IO_STEPPER_ACTIVE
  GPIO_CLEAR(IO_STEPPER_ACTIVE);
#endif
}


void shakerInit() {

  /*
    First set up the data structures
   */
  rbInit(&moves, MOVE_BUFFER_ORDER);
  stepperIRQMax = 0;
  stepperIRQAvg = 0;

  AXIS_INIT(&axes[AXIS_X], X);
  AXIS_INIT(&axes[AXIS_Y], Y);
  AXIS_INIT(&axes[AXIS_Z], Z);
  AXIS_INIT(&axes[AXIS_A], A);

  
  /*
    Finally fire up the timer which will call the IRQ handler
    at the fixed stepping frequency.
   */  
  TIM_TIMERCFG_Type timerCfg;
  timerCfg.PrescaleOption = TIM_PRESCALE_USVAL;
  timerCfg.PrescaleValue  = 1; // 1 us interval
  TIM_Init(LPC_TIM2, TIM_TIMER_MODE, &timerCfg);

  TIM_MATCHCFG_Type timerMatch;
  timerMatch.MatchChannel = 0;
  timerMatch.IntOnMatch   = TRUE;
  timerMatch.ResetOnMatch = TRUE;
  timerMatch.StopOnMatch  = FALSE;
  timerMatch.ExtMatchOutputType = TIM_EXTMATCH_NOTHING;
  timerMatch.MatchValue   = STEPPER_TIMER_INTERVAL_US-1;
  TIM_ConfigMatch(LPC_TIM2,&timerMatch);

  NVIC_EnableIRQ(TIMER2_IRQn);
  TIM_Cmd(LPC_TIM2,ENABLE);
}