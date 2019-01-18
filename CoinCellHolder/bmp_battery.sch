EESchema Schematic File Version 2
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
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Battery BT1
U 1 1 5BB9B732
P 4750 4350
F 0 "BT1" H 4850 4400 50  0000 L CNN
F 1 "Battery" H 4850 4300 50  0000 L CNN
F 2 "MyLib:ali_CR1632" V 4750 4390 50  0001 C CNN
F 3 "" V 4750 4390 50  0000 C CNN
	1    4750 4350
	1    0    0    -1  
$EndComp
$Comp
L Battery BT2
U 1 1 5BB9B760
P 5300 4350
F 0 "BT2" H 5400 4400 50  0000 L CNN
F 1 "Battery" H 5400 4300 50  0000 L CNN
F 2 "MyLib:ali_CR1632" V 5300 4390 50  0001 C CNN
F 3 "" V 5300 4390 50  0000 C CNN
	1    5300 4350
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky_Small D1
U 1 1 5BB9B79E
P 4750 3950
F 0 "D1" H 4700 4030 50  0000 L CNN
F 1 "D_Schottky_Small" H 4470 3870 50  0000 L CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" V 4750 3950 50  0001 C CNN
F 3 "" V 4750 3950 50  0000 C CNN
	1    4750 3950
	0    1    1    0   
$EndComp
$Comp
L D_Schottky_Small D2
U 1 1 5BB9B7D1
P 5300 3950
F 0 "D2" H 5250 4030 50  0000 L CNN
F 1 "D_Schottky_Small" H 5020 3870 50  0000 L CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" V 5300 3950 50  0001 C CNN
F 3 "" V 5300 3950 50  0000 C CNN
	1    5300 3950
	0    1    1    0   
$EndComp
$Comp
L CONN_01X01 P1
U 1 1 5BB9B7F6
P 7700 3600
F 0 "P1" H 7700 3700 50  0000 C CNN
F 1 "CONN_01X01" V 7800 3600 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 7700 3600 50  0001 C CNN
F 3 "" H 7700 3600 50  0000 C CNN
	1    7700 3600
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P2
U 1 1 5BB9B84C
P 7700 4350
F 0 "P2" H 7700 4450 50  0000 C CNN
F 1 "CONN_01X01" V 7800 4350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 7700 4350 50  0001 C CNN
F 3 "" H 7700 4350 50  0000 C CNN
	1    7700 4350
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_INV SW1
U 1 1 5BB9B896
P 6200 3700
F 0 "SW1" H 6000 3850 50  0000 C CNN
F 1 "SWITCH_INV" H 6050 3550 50  0000 C CNN
F 2 "MyLib:MK12C02" H 6200 3700 50  0001 C CNN
F 3 "" H 6200 3700 50  0000 C CNN
	1    6200 3700
	-1   0    0    -1  
$EndComp
NoConn ~ 5700 3600
$Comp
L GND #PWR01
U 1 1 5BB9C1BC
P 7200 4800
F 0 "#PWR01" H 7200 4550 50  0001 C CNN
F 1 "GND" H 7200 4650 50  0000 C CNN
F 2 "" H 7200 4800 50  0000 C CNN
F 3 "" H 7200 4800 50  0000 C CNN
	1    7200 4800
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 5BB9C3A5
P 7200 4100
F 0 "C1" H 7210 4170 50  0000 L CNN
F 1 "C_Small" H 7210 4020 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 7200 4100 50  0001 C CNN
F 3 "" H 7200 4100 50  0000 C CNN
	1    7200 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5BBABE3B
P 4750 4850
F 0 "#PWR02" H 4750 4600 50  0001 C CNN
F 1 "GND" H 4750 4700 50  0000 C CNN
F 2 "" H 4750 4850 50  0000 C CNN
F 3 "" H 4750 4850 50  0000 C CNN
	1    4750 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4650 5300 4500
Wire Wire Line
	5300 4200 5300 4050
Wire Wire Line
	4750 4200 4750 4050
Wire Wire Line
	4750 3600 5300 3600
Wire Wire Line
	7200 3600 7500 3600
Wire Wire Line
	4750 3600 4750 3850
Wire Wire Line
	5300 3600 5300 3850
Connection ~ 5300 3600
Wire Wire Line
	7200 3600 7200 4000
Connection ~ 7200 3600
Wire Wire Line
	7500 4350 7200 4350
Wire Wire Line
	7200 4200 7200 4800
Connection ~ 7200 4350
Wire Wire Line
	4750 4500 4750 4850
Wire Wire Line
	5300 4650 4750 4650
Connection ~ 4750 4650
Wire Wire Line
	6700 3700 7200 3700
Connection ~ 7200 3700
Wire Wire Line
	5700 3800 5300 3800
Connection ~ 5300 3800
$EndSCHEMATC
