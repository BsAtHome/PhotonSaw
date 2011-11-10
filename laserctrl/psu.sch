EESchema Schematic File Version 2  date 2011-11-10T19:54:24 CET
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:contrib
LIBS:valves
LIBS:mounting
LIBS:23k256
LIBS:tps78233
LIBS:drv8811
LIBS:mcu-nxp
LIBS:opto-transistor-4p2
LIBS:atmega328p-a
LIBS:atmel
LIBS:microsd
LIBS:jumper3
LIBS:diode2
LIBS:laserctrl-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 10 10
Title ""
Date "10 nov 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	7050 3000 4250 3000
Wire Wire Line
	6050 4750 6050 4950
Connection ~ 5550 6100
Wire Wire Line
	5800 6100 5300 6100
Connection ~ 5300 6100
Wire Wire Line
	5550 6100 5550 6250
Wire Wire Line
	5300 6000 5300 6200
Connection ~ 3950 4150
Wire Wire Line
	4150 4150 4150 4100
Wire Wire Line
	3800 4150 4150 4150
Connection ~ 3400 4650
Wire Wire Line
	3400 4650 3400 4450
Connection ~ 2950 4650
Wire Wire Line
	2950 4650 2950 4600
Connection ~ 2350 4150
Wire Wire Line
	3000 4150 2350 4150
Connection ~ 2650 4650
Wire Wire Line
	2650 4600 2650 4650
Wire Wire Line
	2350 4750 2350 4600
Connection ~ 5800 4750
Wire Wire Line
	5550 4750 6050 4750
Wire Wire Line
	4850 4750 4700 4750
Wire Wire Line
	4700 4750 4700 4950
Wire Wire Line
	7200 4400 7350 4400
Wire Wire Line
	8150 4750 8150 4600
Connection ~ 8150 4100
Wire Wire Line
	8150 3900 8150 4200
Wire Wire Line
	5800 4750 5800 4650
Connection ~ 5800 4150
Wire Wire Line
	5550 4150 6050 4150
Wire Wire Line
	4850 4150 4700 4150
Wire Wire Line
	4700 4150 4700 3950
Connection ~ 6550 2600
Wire Wire Line
	3500 7100 3500 6900
Wire Wire Line
	4300 7100 4300 6900
Wire Wire Line
	3100 6900 3100 7100
Wire Wire Line
	2300 6900 2300 7100
Wire Wire Line
	1500 6900 1500 7100
Connection ~ 5850 3000
Wire Wire Line
	5850 3000 5850 3150
Connection ~ 6050 2600
Connection ~ 6050 3000
Connection ~ 5850 2300
Connection ~ 5050 2600
Wire Wire Line
	4600 2300 5850 2300
Connection ~ 4250 2600
Wire Wire Line
	3900 2600 4350 2600
Connection ~ 3900 2750
Wire Wire Line
	3900 2850 3900 2750
Wire Wire Line
	3900 3350 3900 3450
Wire Wire Line
	2200 3300 2200 3450
Connection ~ 3050 2000
Wire Wire Line
	2900 2000 3050 2000
Connection ~ 3900 2350
Wire Wire Line
	3900 2450 3900 1750
Wire Wire Line
	3050 2050 3050 1950
Wire Wire Line
	2200 2400 2200 1750
Wire Wire Line
	2200 1750 3900 1750
Wire Wire Line
	2400 2000 2200 2000
Connection ~ 2200 2000
Wire Wire Line
	2200 2900 2200 2700
Wire Wire Line
	3050 3050 3050 3450
Wire Wire Line
	3900 2750 4100 2750
Wire Wire Line
	4100 2750 4100 2300
Connection ~ 5350 2600
Connection ~ 5050 3000
Connection ~ 5350 3000
Connection ~ 5850 2600
Wire Wire Line
	1900 6900 1900 7100
Wire Wire Line
	2700 6900 2700 7100
Wire Wire Line
	3900 6900 3900 7100
Wire Wire Line
	5850 2600 5850 2200
Connection ~ 6550 3000
Wire Wire Line
	5800 4150 5800 4250
Wire Wire Line
	7750 4100 8150 4100
Wire Wire Line
	7350 4100 7250 4100
Wire Wire Line
	7250 4100 7250 3900
Wire Wire Line
	7750 4400 7800 4400
Wire Wire Line
	7800 4400 7800 4100
Connection ~ 7800 4100
Wire Wire Line
	7300 4750 7300 4600
Wire Wire Line
	7300 4600 7200 4600
Wire Wire Line
	2350 4650 3950 4650
Wire Wire Line
	3950 4650 3950 4600
Connection ~ 2350 4650
Wire Wire Line
	2350 4100 2350 4200
Wire Wire Line
	2650 4200 2650 4150
Connection ~ 2650 4150
Wire Wire Line
	2950 4200 2950 4150
Connection ~ 2950 4150
Wire Wire Line
	3950 4150 3950 4200
Wire Wire Line
	5300 5350 5300 5500
Wire Wire Line
	5300 6700 5300 6850
Wire Wire Line
	5550 6650 5550 6750
Wire Wire Line
	5550 6750 5300 6750
Connection ~ 5300 6750
Wire Wire Line
	6050 4150 6050 3950
Wire Wire Line
	7050 2600 4950 2600
Text HLabel 5800 6100 2    50   Output ~ 0
Supply-sense
$Comp
L C C91
U 1 1 4EB6CE2C
P 5550 6450
F 0 "C91" H 5600 6550 50  0000 L CNN
F 1 "100nF" H 5600 6350 50  0000 L CNN
	1    5550 6450
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR0128
U 1 1 4EB6CE24
P 5300 5350
F 0 "#PWR0128" H 5300 5300 20  0001 C CNN
F 1 "+24V" H 5300 5450 30  0000 C CNN
	1    5300 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0129
U 1 1 4EB6CE1F
P 5300 6850
F 0 "#PWR0129" H 5300 6850 30  0001 C CNN
F 1 "GND" H 5300 6780 30  0001 C CNN
	1    5300 6850
	1    0    0    -1  
$EndComp
$Comp
L R R92
U 1 1 4EB6CE1B
P 5300 6450
F 0 "R92" V 5380 6450 50  0000 C CNN
F 1 "10k" V 5300 6450 50  0000 C CNN
	1    5300 6450
	1    0    0    -1  
$EndComp
$Comp
L R R91
U 1 1 4EB6CE16
P 5300 5750
F 0 "R91" V 5380 5750 50  0000 C CNN
F 1 "82k" V 5300 5750 50  0000 C CNN
	1    5300 5750
	1    0    0    -1  
$EndComp
Text Notes 2400 3850 0    50   ~ 0
Note: The +5V supply is only used for NTCs\nit needs to supply only a few mA of current
$Comp
L +5V #PWR0130
U 1 1 4EB54A98
P 4150 4100
F 0 "#PWR0130" H 4150 4190 20  0001 C CNN
F 1 "+5V" H 4150 4190 30  0000 C CNN
	1    4150 4100
	1    0    0    -1  
$EndComp
$Comp
L CAPAPOL C86
U 1 1 4EB54A69
P 2950 4400
F 0 "C86" H 3000 4500 50  0000 L CNN
F 1 "1.5mF/35V" H 2800 3950 50  0000 L CNN
	1    2950 4400
	1    0    0    -1  
$EndComp
$Comp
L CAPAPOL C85
U 1 1 4EB549F2
P 2650 4400
F 0 "C85" H 2700 4500 50  0000 L CNN
F 1 "1.5mF/35V" H 2500 4050 50  0000 L CNN
	1    2650 4400
	1    0    0    -1  
$EndComp
$Comp
L C C87
U 1 1 4EB5493E
P 3950 4400
F 0 "C87" H 4000 4500 50  0000 L CNN
F 1 "22uF/6.3" H 4000 4300 50  0000 L CNN
	1    3950 4400
	1    0    0    -1  
$EndComp
$Comp
L C C84
U 1 1 4EB5492E
P 2350 4400
F 0 "C84" H 2400 4500 50  0000 L CNN
F 1 "10uF/35V" H 1950 4300 50  0000 L CNN
	1    2350 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0131
U 1 1 4EB54922
P 2350 4750
F 0 "#PWR0131" H 2350 4750 30  0001 C CNN
F 1 "GND" H 2350 4680 30  0001 C CNN
	1    2350 4750
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR0132
U 1 1 4EB5491D
P 2350 4100
F 0 "#PWR0132" H 2350 4050 20  0001 C CNN
F 1 "+24V" H 2350 4200 30  0000 C CNN
	1    2350 4100
	1    0    0    -1  
$EndComp
$Comp
L 78L05 U8
U 1 1 4EB54904
P 3400 4200
F 0 "U8" H 3550 4004 60  0000 C CNN
F 1 "78L05" H 3400 4400 60  0000 C CNN
	1    3400 4200
	1    0    0    -1  
$EndComp
$Comp
L AGND #PWR0133
U 1 1 4EB4727E
P 6050 4950
F 0 "#PWR0133" H 6050 4950 40  0001 C CNN
F 1 "AGND" H 6050 4880 50  0000 C CNN
	1    6050 4950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0134
U 1 1 4EB4725D
P 4700 4950
F 0 "#PWR0134" H 4700 4950 30  0001 C CNN
F 1 "GND" H 4700 4880 30  0001 C CNN
	1    4700 4950
	1    0    0    -1  
$EndComp
$Comp
L FILTER FB2
U 1 1 4EB47252
P 5200 4750
F 0 "FB2" H 5200 4900 60  0000 C CNN
F 1 "FILTER" H 5200 4650 60  0000 C CNN
	1    5200 4750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0135
U 1 1 4EA3EFD9
P 7300 4750
F 0 "#PWR0135" H 7300 4750 30  0001 C CNN
F 1 "GND" H 7300 4680 30  0001 C CNN
	1    7300 4750
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P24
U 1 1 4EA3EFCE
P 6850 4500
F 0 "P24" V 6800 4500 40  0000 C CNN
F 1 "CONN_2" V 6900 4500 40  0000 C CNN
	1    6850 4500
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR0136
U 1 1 4EA3EF99
P 8150 4750
F 0 "#PWR0136" H 8150 4750 30  0001 C CNN
F 1 "GND" H 8150 4680 30  0001 C CNN
	1    8150 4750
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR0137
U 1 1 4EA3EF91
P 7250 3900
F 0 "#PWR0137" H 7250 3860 30  0001 C CNN
F 1 "+3.3V" H 7250 4010 30  0000 C CNN
	1    7250 3900
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR0138
U 1 1 4EA3EF72
P 8150 3900
F 0 "#PWR0138" H 8150 3850 20  0001 C CNN
F 1 "+BATT" H 8150 4000 30  0000 C CNN
	1    8150 3900
	1    0    0    -1  
$EndComp
$Comp
L C C88
U 1 1 4EA3EF4E
P 8150 4400
F 0 "C88" H 8200 4500 50  0000 L CNN
F 1 "100nF" H 8200 4300 50  0000 L CNN
	1    8150 4400
	1    0    0    -1  
$EndComp
$Comp
L DIODE D45
U 1 1 4EA3EF40
P 7550 4400
F 0 "D45" H 7550 4500 40  0000 C CNN
F 1 "LS 914B" H 7550 4300 40  0000 C CNN
	1    7550 4400
	1    0    0    -1  
$EndComp
$Comp
L DIODE D44
U 1 1 4EA3EF38
P 7550 4100
F 0 "D44" H 7550 4200 40  0000 C CNN
F 1 "LS 914B" H 7550 4000 40  0000 C CNN
	1    7550 4100
	1    0    0    -1  
$EndComp
$Comp
L +3.3VADC #PWR0139
U 1 1 4EA3E9DF
P 6050 3950
F 0 "#PWR0139" H 6050 4070 20  0001 C CNN
F 1 "+3.3VADC" H 6050 4040 30  0000 C CNN
	1    6050 3950
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR0140
U 1 1 4EA3E96D
P 4700 3950
F 0 "#PWR0140" H 4700 3910 30  0001 C CNN
F 1 "+3.3V" H 4700 4060 30  0000 C CNN
	1    4700 3950
	1    0    0    -1  
$EndComp
$Comp
L FILTER FB1
U 1 1 4EA3E94D
P 5200 4150
F 0 "FB1" H 5200 4300 60  0000 C CNN
F 1 "FILTER" H 5200 4050 60  0000 C CNN
	1    5200 4150
	-1   0    0    1   
$EndComp
$Comp
L C C89
U 1 1 4EA3E94C
P 5800 4450
F 0 "C89" H 5850 4550 50  0000 L CNN
F 1 "100nF" H 5550 4350 50  0000 L CNN
	1    5800 4450
	1    0    0    -1  
$EndComp
$Comp
L C C81
U 1 1 4EA3E68B
P 7050 2800
F 0 "C81" H 7100 2900 50  0000 L CNN
F 1 "100nF" H 7000 2550 50  0000 L CNN
	1    7050 2800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR0141
U 1 1 4EA3E60A
P 5850 2200
F 0 "#PWR0141" H 5850 2160 30  0001 C CNN
F 1 "+3.3V" H 5850 2310 30  0000 C CNN
	1    5850 2200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0142
U 1 1 4EA1CE90
P 4300 7100
F 0 "#PWR0142" H 4300 7100 30  0001 C CNN
F 1 "GND" H 4300 7030 30  0001 C CNN
	1    4300 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0143
U 1 1 4EA1CE88
P 3900 7100
F 0 "#PWR0143" H 3900 7100 30  0001 C CNN
F 1 "GND" H 3900 7030 30  0001 C CNN
	1    3900 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0144
U 1 1 4EA1CE84
P 3500 7100
F 0 "#PWR0144" H 3500 7100 30  0001 C CNN
F 1 "GND" H 3500 7030 30  0001 C CNN
	1    3500 7100
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING H8
U 1 1 4EA1CE73
P 4300 6750
F 0 "H8" H 4300 7000 60  0000 C CNN
F 1 "MOUNTING" H 4300 6900 60  0000 C CNN
	1    4300 6750
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING H7
U 1 1 4EA1CE6B
P 3900 6750
F 0 "H7" H 3900 7000 60  0000 C CNN
F 1 "MOUNTING" H 3900 6900 60  0000 C CNN
	1    3900 6750
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING H6
U 1 1 4EA1CE5F
P 3500 6750
F 0 "H6" H 3500 7000 60  0000 C CNN
F 1 "MOUNTING" H 3500 6900 60  0000 C CNN
	1    3500 6750
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR0145
U 1 1 4D879ADC
P 3100 7100
F 0 "#PWR0145" H 3100 7100 30  0001 C CNN
F 1 "GND" H 3100 7030 30  0001 C CNN
	1    3100 7100
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING H5
U 1 1 4D879AD2
P 3100 6750
F 0 "H5" H 3100 7000 60  0000 C CNN
F 1 "MOUNTING" H 3100 6900 60  0000 C CNN
	1    3100 6750
	0    -1   -1   0   
$EndComp
Text Notes 1450 6400 0    60   ~ 0
3mm mounting holes at the corners of the board and heatsink
$Comp
L GND #PWR0146
U 1 1 4D87999F
P 2700 7100
F 0 "#PWR0146" H 2700 7100 30  0001 C CNN
F 1 "GND" H 2700 7030 30  0001 C CNN
	1    2700 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0147
U 1 1 4D87999A
P 2300 7100
F 0 "#PWR0147" H 2300 7100 30  0001 C CNN
F 1 "GND" H 2300 7030 30  0001 C CNN
	1    2300 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0148
U 1 1 4D879997
P 1900 7100
F 0 "#PWR0148" H 1900 7100 30  0001 C CNN
F 1 "GND" H 1900 7030 30  0001 C CNN
	1    1900 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0149
U 1 1 4D879990
P 1500 7100
F 0 "#PWR0149" H 1500 7100 30  0001 C CNN
F 1 "GND" H 1500 7030 30  0001 C CNN
	1    1500 7100
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING H4
U 1 1 4D879985
P 2700 6750
F 0 "H4" H 2700 7000 60  0000 C CNN
F 1 "MOUNTING" H 2700 6900 60  0000 C CNN
	1    2700 6750
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING H3
U 1 1 4D87997E
P 2300 6750
F 0 "H3" H 2300 7000 60  0000 C CNN
F 1 "MOUNTING" H 2300 6900 60  0000 C CNN
	1    2300 6750
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING H2
U 1 1 4D879975
P 1900 6750
F 0 "H2" H 1900 7000 60  0000 C CNN
F 1 "MOUNTING" H 1900 6900 60  0000 C CNN
	1    1900 6750
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING H1
U 1 1 4D87996B
P 1500 6750
F 0 "H1" H 1500 7000 60  0000 C CNN
F 1 "MOUNTING" H 1500 6900 60  0000 C CNN
	1    1500 6750
	0    -1   -1   0   
$EndComp
Text Notes 6050 2500 0    60   ~ 0
Distributed decoupling caps
$Comp
L GND #PWR0150
U 1 1 4D04D42D
P 5850 3150
F 0 "#PWR0150" H 5850 3150 30  0001 C CNN
F 1 "GND" H 5850 3080 30  0001 C CNN
	1    5850 3150
	1    0    0    -1  
$EndComp
$Comp
L C C79
U 1 1 4D04D394
P 6550 2800
F 0 "C79" H 6600 2900 50  0000 L CNN
F 1 "100nF" H 6500 2550 50  0000 L CNN
	1    6550 2800
	1    0    0    -1  
$EndComp
$Comp
L C C77
U 1 1 4D04D33D
P 6050 2800
F 0 "C77" H 6100 2900 50  0000 L CNN
F 1 "100nF" H 6000 2550 50  0000 L CNN
	1    6050 2800
	1    0    0    -1  
$EndComp
$Comp
L C C76
U 1 1 4D04D22A
P 5350 2800
F 0 "C76" H 5400 2900 50  0000 L CNN
F 1 "22uF/6.3V" H 5400 2700 50  0000 L CNN
	1    5350 2800
	1    0    0    -1  
$EndComp
$Comp
L CAPAPOL C75
U 1 1 4D04D0AE
P 5050 2800
F 0 "C75" H 5100 2900 50  0000 L CNN
F 1 "1mF/10V" H 4900 2500 50  0000 L CNN
	1    5050 2800
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L1
U 1 1 4D04CFE3
P 4650 2600
F 0 "L1" V 4600 2600 40  0000 C CNN
F 1 "330uH" V 4750 2600 40  0000 C CNN
	1    4650 2600
	0    -1   -1   0   
$EndComp
$Comp
L DIODESCH D43
U 1 1 4D04CF74
P 4250 2800
F 0 "D43" H 4250 2900 40  0000 C CNN
F 1 "SK 34" H 4250 2700 40  0000 C CNN
	1    4250 2800
	0    -1   -1   0   
$EndComp
$Comp
L C C83
U 1 1 4D04CF13
P 2200 3100
F 0 "C83" H 2250 3200 50  0000 L CNN
F 1 "82pF" H 2250 3000 50  0000 L CNN
	1    2200 3100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0151
U 1 1 4D04CF0D
P 2200 3450
F 0 "#PWR0151" H 2200 3450 30  0001 C CNN
F 1 "GND" H 2200 3380 30  0001 C CNN
	1    2200 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0152
U 1 1 4D04CF06
P 3900 3450
F 0 "#PWR0152" H 3900 3450 30  0001 C CNN
F 1 "GND" H 3900 3380 30  0001 C CNN
	1    3900 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0153
U 1 1 4D04CF02
P 3050 3450
F 0 "#PWR0153" H 3050 3450 30  0001 C CNN
F 1 "GND" H 3050 3380 30  0001 C CNN
	1    3050 3450
	1    0    0    -1  
$EndComp
$Comp
L R R89
U 1 1 4D04CED4
P 4350 2300
F 0 "R89" V 4430 2300 50  0000 C CNN
F 1 "18k" V 4350 2300 50  0000 C CNN
	1    4350 2300
	0    1    1    0   
$EndComp
$Comp
L R R90
U 1 1 4D04CEB9
P 3900 3100
F 0 "R90" V 3980 3100 50  0000 C CNN
F 1 "11k" V 3900 3100 50  0000 C CNN
	1    3900 3100
	1    0    0    -1  
$EndComp
$Comp
L R R88
U 1 1 4D04CE98
P 2650 2000
F 0 "R88" V 2730 2000 50  0000 C CNN
F 1 "0.22R" V 2650 2000 50  0000 C CNN
	1    2650 2000
	0    1    1    0   
$EndComp
$Comp
L +24V #PWR0154
U 1 1 4D04CE42
P 3050 1950
F 0 "#PWR0154" H 3050 1900 20  0001 C CNN
F 1 "+24V" H 3050 2050 30  0000 C CNN
	1    3050 1950
	1    0    0    -1  
$EndComp
$Comp
L MC34063 U7
U 1 1 4D04CE01
P 3050 2550
F 0 "U7" H 3200 2900 60  0000 L CNN
F 1 "MC34063" H 3150 2200 60  0000 L CNN
	1    3050 2550
	1    0    0    -1  
$EndComp
$EndSCHEMATC
