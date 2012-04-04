#ifndef __USBAPI_H
#define __USBAPI_H

#include "board.h"
#include "ringbuffer.h"

#define USB_LINE_BUFFER_ORDER 13
#define USB_TX_BUFFER_ORDER 12

EXTERN_RING_BUFFER(usbLineBuffer, USB_LINE_BUFFER_ORDER, char);
EXTERN_RING_BUFFER(usbTxBuffer, USB_TX_BUFFER_ORDER, char);

void usbAPIInit();

// Callback called when a full line has been buffered by the USB CDC layer.
void usbLine(char *line, unsigned int lineSize);

// Function to send data via USB
void usbSend(char *data, unsigned int dataSize);


// Internal functions called by the USB CDC layer

// Read up to dataSize chars from the transmit buffer
int usbPopForTransmit(unsigned char *data, int dataSize);

// Write data from the USB buffer to the receive buffer
void usbPushReceived(unsigned char *data, int dataSize);

#endif
