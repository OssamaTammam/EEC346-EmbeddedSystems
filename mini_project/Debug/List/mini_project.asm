
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 11.059200 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _locked=R5
	.DEF _screensaver_timeout=R6
	.DEF _screensaver_timeout_msb=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  _ext_int1_isr
	JMP  _ext_int2_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x4:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x6F,0x0,0x40
__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.14 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : mini_project_finaaaal
;Version :
;Date    : 24-Apr-2024
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <io.h>
;#include <eeprom.h>
;#include <sleep.h>
;#include <interrupt.h>
;	flags -> R17

	.CSEG
;#include <delay.h>
;
;// Declare your global variables here
;#define sbi(port, bit) (port) |= (1 << (bit))
;#define cbi(port, bit) (port) &= ~(1 << (bit))
;
;#define bit_is_clear(sfr, bit) (!(sfr & (1 << bit)))
;
;
;typedef union {
;    struct {
;        signed char tens;
;        signed char units;
;    };
;    unsigned int value; // alias
;} DIAL; // virtual dial position
;
;volatile DIAL dial; // virtual dial position
;volatile DIAL combo[3]; // combination
;
;typedef enum {
;    STATUS_UNLOCKED,
;    STATUS_LOCKED
;} STATUS;
;
;STATUS locked; // locked status:  0=unlocked, 1=locked
;
;typedef enum {
;    COMBO_MATCH_0, // no numbers matched - nothing happening
;    COMBO_MATCH_1, // 1st number matched
;    COMBO_MATCH_2, // 2nd number matched
;    COMBO_MATCH_3  // 3rd number matched
;} COMBO_STATE;
;
;volatile COMBO_STATE combo_state; // combination state machine variable
;
;typedef enum {
;	PROG_0, // not programming the combination
;	PROG_1, // 1st number programmed, checking 2nd
;	PROG_2  // 2nd number programmed, checking 3rd
;} PROG_STATE;
;
;volatile PROG_STATE prog_state = PROG_0; // combination programming state machine variable
;
;#define SCREENSAVER_TIMEOUT_VALUE 10000 // display blank timeout value in 1/250 second increments (2,000 ~= 8 seconds)
;unsigned int screensaver_timeout;
;
;// EEPROM memory map
;
;EEMEM unsigned char eeprom_do_not_use; // .bad luck - do not use the first location in EEPROM
;EEMEM unsigned char eeprom_locked; // saved locked status:  0=unlocked, 1=locked
;EEMEM DIAL eeprom_dial; // saved dial position
;EEMEM DIAL eeprom_combo[3]; // programmed combination
;
;// lock functions
;
;#define lock() cbi(PORTD, PORTD6); locked = STATUS_LOCKED
;#define unlock() sbi(PORTD, PORTD6); locked = STATUS_UNLOCKED
;
;// LED_segment() - decode outputs for seven-segment LED display
;
;typedef enum {
;	SEGMENT_0,
;	SEGMENT_1,
;	SEGMENT_2,
;	SEGMENT_3,
;	SEGMENT_4,
;	SEGMENT_5,
;	SEGMENT_6,
;	SEGMENT_7,
;	SEGMENT_8,
;	SEGMENT_9,
;	SEGMENT_BLANK,
;	SEGMENT_DASH
;} SEGMENT;
;
;SEGMENT LED_segment(unsigned char value) {
; 0000 0069 SEGMENT LED_segment(unsigned char value) {
_LED_segment:
; .FSTART _LED_segment
; 0000 006A 
; 0000 006B 	const unsigned char LED_segment_lookup_table[] = {
; 0000 006C 
; 0000 006D 		0b0111111, // 0
; 0000 006E 		0b0000110, // 1
; 0000 006F 		0b1011011, // 2
; 0000 0070 		0b1001111, // 3
; 0000 0071 		0b1100110, // 4
; 0000 0072 		0b1101101, // 5
; 0000 0073 		0b1111101, // 6
; 0000 0074 		0b0000111, // 7
; 0000 0075 		0b1111111, // 8
; 0000 0076 		0b1101111, // 9
; 0000 0077 		0b0000000, // blank
; 0000 0078 		0b1000000, // dash
; 0000 0079 	};
; 0000 007A 
; 0000 007B 	return ~LED_segment_lookup_table[value];
	ST   -Y,R26
	SBIW R28,12
	LDI  R24,12
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x4*2)
	LDI  R31,HIGH(_0x4*2)
	CALL __INITLOCB
;	value -> Y+12
;	LED_segment_lookup_table -> Y+0
	LDD  R30,Y+12
	LDI  R31,0
	MOVW R26,R28
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	ADIW R28,13
	RET
; 0000 007C }
; .FEND
;
;// LED_blink() - blink LED display
;
;void LED_blink(unsigned char n) {
; 0000 0080 void LED_blink(unsigned char n) {
_LED_blink:
; .FSTART _LED_blink
; 0000 0081 
; 0000 0082 	while(n--) {
	ST   -Y,R26
;	n -> Y+0
_0x5:
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	SUBI R30,-LOW(1)
	BREQ _0x7
; 0000 0083 
; 0000 0084 		cli(); // disable interrupts (prevents display multiplexing)
	cli
; 0000 0085 		PORTA = 0b11111111; // all segments off
	LDI  R30,LOW(255)
	OUT  0x1B,R30
; 0000 0086 		delay_ms(200); // ~1 second delay, with display off
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 0087         GIFR |= (1 << INTF2); // Clear INT2 flag
	IN   R30,0x3A
	ORI  R30,0x20
	OUT  0x3A,R30
; 0000 0088 		sei(); // re-enable interrupts
	sei
; 0000 0089 		delay_ms(200); // ~1 second delay, with display on
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 008A 	}
	RJMP _0x5
_0x7:
; 0000 008B }
	ADIW R28,1
	RET
; .FEND
;
;
;typedef enum {
;	MOTION_RIGHT,
;	MOTION_LEFT
;} MOTION;
;
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0096 {
_ext_int0_isr:
; .FSTART _ext_int0_isr
	CALL SUBOPT_0x0
; 0000 0097 // Place your code here
; 0000 0098 MOTION motion; // direction of detected motion
; 0000 0099 
; 0000 009A 	screensaver_timeout = SCREENSAVER_TIMEOUT_VALUE; // reset screensaver timeout value - turns display on
	ST   -Y,R17
;	motion -> R17
	LDI  R30,LOW(10000)
	LDI  R31,HIGH(10000)
	MOVW R6,R30
; 0000 009B 
; 0000 009C 	// check encoder phase B to determine direction of motion
; 0000 009D 
; 0000 009E 	if(bit_is_clear(PIND, PORTD3)) {
	SBIC 0x10,3
	RJMP _0x8
; 0000 009F 		motion = MOTION_RIGHT;
	LDI  R17,LOW(0)
; 0000 00A0         // delay_ms(50);
; 0000 00A1 		dial.units++; // increment dial position
	__GETB1MN _dial,1
	SUBI R30,-LOW(1)
	__PUTB1MN _dial,1
	SUBI R30,LOW(1)
; 0000 00A2         // delay_ms(50);
; 0000 00A3 		if(dial.units > 9) {
	__GETB2MN _dial,1
	CPI  R26,LOW(0xA)
	BRLT _0x9
; 0000 00A4 			dial.units = 0; // reset units on overflow
	LDI  R30,LOW(0)
	__PUTB1MN _dial,1
; 0000 00A5 			dial.tens++; // increment tens digit
	LDS  R30,_dial
	SUBI R30,-LOW(1)
	STS  _dial,R30
; 0000 00A6 			if(dial.tens > 9) dial.tens = 0; // reset on overflow
	LDS  R26,_dial
	CPI  R26,LOW(0xA)
	BRLT _0xA
	LDI  R30,LOW(0)
	STS  _dial,R30
; 0000 00A7 		}
_0xA:
; 0000 00A8 	} else {
_0x9:
	RJMP _0xB
_0x8:
; 0000 00A9 		motion = MOTION_LEFT;
	LDI  R17,LOW(1)
; 0000 00AA         // delay_ms(50);
; 0000 00AB 		dial.units--; // decrement dial position
	__GETB1MN _dial,1
	SUBI R30,LOW(1)
	__PUTB1MN _dial,1
	SUBI R30,-LOW(1)
; 0000 00AC         // delay_ms(50);
; 0000 00AD 		if(dial.units < 0) {
	__GETB2MN _dial,1
	CPI  R26,0
	BRGE _0xC
; 0000 00AE 			dial.units = 9; // rollover on underflow
	LDI  R30,LOW(9)
	__PUTB1MN _dial,1
; 0000 00AF 			dial.tens--; // decrement tens digit
	LDS  R30,_dial
	SUBI R30,LOW(1)
	STS  _dial,R30
; 0000 00B0 			if(dial.tens < 0) dial.tens = 9; // rollover on underflow
	LDS  R26,_dial
	CPI  R26,0
	BRGE _0xD
	LDI  R30,LOW(9)
	STS  _dial,R30
; 0000 00B1 		}
_0xD:
; 0000 00B2 	}
_0xC:
_0xB:
; 0000 00B3 
; 0000 00B4 
; 0000 00B5 	// combination lock logic
; 0000 00B6 
; 0000 00B7 	switch(combo_state) {
	LDS  R30,_combo_state
	LDI  R31,0
; 0000 00B8 
; 0000 00B9 		case COMBO_MATCH_0:
	SBIW R30,0
	BRNE _0x11
; 0000 00BA 			// detect retrograde motion
; 0000 00BB 			if(motion == MOTION_LEFT) {
	CPI  R17,1
	BRNE _0x12
; 0000 00BC 				combo_state = COMBO_MATCH_0; // start over
	LDI  R30,LOW(0)
	RJMP _0x3F
; 0000 00BD 			} else {
_0x12:
; 0000 00BE 				// look for 1st number match
; 0000 00BF 				if(dial.value == combo[0].value) {
	LDS  R30,_combo
	LDS  R31,_combo+1
	CALL SUBOPT_0x1
	BRNE _0x14
; 0000 00C0 					// matched first number of combination
; 0000 00C1 					combo_state = COMBO_MATCH_1; // advance to next state
	LDI  R30,LOW(1)
_0x3F:
	STS  _combo_state,R30
; 0000 00C2 				}
; 0000 00C3 			}
_0x14:
; 0000 00C4 			break;
	RJMP _0x10
; 0000 00C5 
; 0000 00C6 		case COMBO_MATCH_1:
_0x11:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x15
; 0000 00C7 			// detect retrograde motion
; 0000 00C8 			if(motion == MOTION_RIGHT) {
	CPI  R17,0
	BRNE _0x16
; 0000 00C9 				combo_state = COMBO_MATCH_0; // start over
	LDI  R30,LOW(0)
	RJMP _0x40
; 0000 00CA 			} else {
_0x16:
; 0000 00CB 				// look for 2nd number match
; 0000 00CC 				if(dial.value == combo[1].value) {
	__GETW1MN _combo,2
	CALL SUBOPT_0x1
	BRNE _0x18
; 0000 00CD 					// matched second number of combination
; 0000 00CE 					combo_state = COMBO_MATCH_2; // advance to next state
	LDI  R30,LOW(2)
_0x40:
	STS  _combo_state,R30
; 0000 00CF 				}
; 0000 00D0 			}
_0x18:
; 0000 00D1 			break;
	RJMP _0x10
; 0000 00D2 
; 0000 00D3 		case COMBO_MATCH_2:
_0x15:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x19
; 0000 00D4 			// detect retrograde motion
; 0000 00D5 			if(motion == MOTION_LEFT) {
	CPI  R17,1
	BRNE _0x1A
; 0000 00D6 				combo_state = COMBO_MATCH_0; // start over
	LDI  R30,LOW(0)
	RJMP _0x41
; 0000 00D7 			} else {
_0x1A:
; 0000 00D8 				// look for 3rd number match
; 0000 00D9 				if(dial.value == combo[2].value) {
	__GETW1MN _combo,4
	CALL SUBOPT_0x1
	BRNE _0x1C
; 0000 00DA 					unlock(); // combination satisfied
	SBI  0x12,6
	CLR  R5
; 0000 00DB 					eeprom_write_byte(&eeprom_locked, locked); // save unlocked status
	CALL SUBOPT_0x2
; 0000 00DC                     LED_blink(5);
	LDI  R26,LOW(5)
	RCALL _LED_blink
; 0000 00DD 					combo_state = COMBO_MATCH_3; // advance to next state
	LDI  R30,LOW(3)
_0x41:
	STS  _combo_state,R30
; 0000 00DE 				}
; 0000 00DF 			}
_0x1C:
; 0000 00E0 			break;
	RJMP _0x10
; 0000 00E1 
; 0000 00E2 		case COMBO_MATCH_3:
_0x19:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1E
; 0000 00E3 			lock(); // any motion relocks
	CBI  0x12,6
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 00E4 			eeprom_write_byte(&eeprom_locked, locked); // save locked status
	CALL SUBOPT_0x2
; 0000 00E5 			combo_state = COMBO_MATCH_0; // start over
	LDI  R30,LOW(0)
	STS  _combo_state,R30
; 0000 00E6 			break;
; 0000 00E7 
; 0000 00E8 		default: // ??? unknown/unexpected state
_0x1E:
; 0000 00E9 			break;
; 0000 00EA 	}
_0x10:
; 0000 00EB 
; 0000 00EC }
	LD   R17,Y+
	RJMP _0x44
; .FEND
;
;// External Interrupt 1 service routine
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0000 00F0 {
_ext_int1_isr:
; .FSTART _ext_int1_isr
; 0000 00F1 // Place your code here
; 0000 00F2 
; 0000 00F3 }
	RETI
; .FEND
;
;// External Interrupt 2 service routine
;interrupt [EXT_INT2] void ext_int2_isr(void)
; 0000 00F7 {
_ext_int2_isr:
; .FSTART _ext_int2_isr
	CALL SUBOPT_0x0
; 0000 00F8 // Place your code here
; 0000 00F9 static DIAL candidate[3]; // holder for candidate combination
; 0000 00FA 
; 0000 00FB 	// combination programming logic
; 0000 00FC 
; 0000 00FD 	switch(prog_state) {
	LDS  R30,_prog_state
	LDI  R31,0
; 0000 00FE 
; 0000 00FF 		case PROG_0: // begin combination programming sequence
	SBIW R30,0
	BRNE _0x22
; 0000 0100 			candidate[0].value = dial.value; // save current dial position
	CALL SUBOPT_0x3
	STS  _candidate_S0000005000,R30
	STS  _candidate_S0000005000+1,R31
; 0000 0101 			LED_blink(1); // blink display once to acknowledge 1st number saved
	LDI  R26,LOW(1)
	RCALL _LED_blink
; 0000 0102 			prog_state = PROG_1; // advance to next state
	LDI  R30,LOW(1)
	STS  _prog_state,R30
; 0000 0103 			break;
	RJMP _0x21
; 0000 0104 
; 0000 0105 		case PROG_1: // entering 2nd number
_0x22:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x23
; 0000 0106 			// 2nd number must be different than 1st
; 0000 0107 			if(dial.value != candidate[0].value) {
	CALL SUBOPT_0x4
	CALL SUBOPT_0x1
	BREQ _0x24
; 0000 0108 				candidate[1].value = dial.value; // save current dial position
	CALL SUBOPT_0x3
	__PUTW1MN _candidate_S0000005000,2
; 0000 0109 				LED_blink(2); // blink display twice to acknowledge 2nd number saved
	LDI  R26,LOW(2)
	RCALL _LED_blink
; 0000 010A 				prog_state = PROG_2; // advance to next state
	LDI  R30,LOW(2)
	STS  _prog_state,R30
; 0000 010B 			}
; 0000 010C 			break;
_0x24:
	RJMP _0x21
; 0000 010D 
; 0000 010E 		case PROG_2:
_0x23:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x27
; 0000 010F 			// 3rd number must be different than 2nd
; 0000 0110 			if(dial.value != candidate[1].value) {
	CALL SUBOPT_0x5
	CALL SUBOPT_0x1
	BREQ _0x26
; 0000 0111 				candidate[2].value = dial.value; // save current dial position
	CALL SUBOPT_0x3
	__PUTW1MN _candidate_S0000005000,4
; 0000 0112 				eeprom_write_word(&eeprom_combo[0].value, candidate[0].value); // save 1st number
	CALL SUBOPT_0x4
	LDI  R26,LOW(_eeprom_combo)
	LDI  R27,HIGH(_eeprom_combo)
	CALL __EEPROMWRW
; 0000 0113 				eeprom_write_word(&eeprom_combo[1].value, candidate[1].value); // save 2nd number
	__POINTW2MN _eeprom_combo,2
	CALL SUBOPT_0x5
	CALL __EEPROMWRW
; 0000 0114 				eeprom_write_word(&eeprom_combo[2].value, candidate[2].value); // save 3rd number
	__POINTW2MN _eeprom_combo,4
	__GETW1MN _candidate_S0000005000,4
	CALL __EEPROMWRW
; 0000 0115 				combo[0].value = candidate[0].value; // the new combination
	CALL SUBOPT_0x4
	STS  _combo,R30
	STS  _combo+1,R31
; 0000 0116 				combo[1].value = candidate[1].value; // the new combination
	CALL SUBOPT_0x5
	__PUTW1MN _combo,2
; 0000 0117 				combo[2].value = candidate[2].value; // the new combination
	__GETW1MN _candidate_S0000005000,4
	__PUTW1MN _combo,4
; 0000 0118 				LED_blink(3); // blink display three times to acknowledge 3rd number saved
	LDI  R26,LOW(3)
	RCALL _LED_blink
; 0000 0119 				prog_state = PROG_0; // start over
	LDI  R30,LOW(0)
	STS  _prog_state,R30
; 0000 011A 			}
; 0000 011B 			break;
_0x26:
; 0000 011C 
; 0000 011D 		default: // ??? unknown/unexpected state
_0x27:
; 0000 011E 			break;
; 0000 011F 	}
_0x21:
; 0000 0120 
; 0000 0121     GIFR |= (1 << INTF2); // Clear INT2 flag
	IN   R30,0x3A
	ORI  R30,0x20
	OUT  0x3A,R30
; 0000 0122 
; 0000 0123 }
	RJMP _0x44
; .FEND
;
;typedef enum {
;	DIGIT_LEFT,
;	DIGIT_RIGHT
;} DIGIT;
;
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 012D {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	CALL SUBOPT_0x0
; 0000 012E // Reinitialize Timer 0 value
; 0000 012F TCNT0=0x4F;
	LDI  R30,LOW(79)
	OUT  0x32,R30
; 0000 0130 // Place your code here
; 0000 0131 static unsigned char digit = DIGIT_LEFT; // alternate between left & right digits
; 0000 0132 
; 0000 0133 	if(screensaver_timeout) {
	MOV  R0,R6
	OR   R0,R7
	BREQ _0x28
; 0000 0134 
; 0000 0135 		cbi(PORTB, PORTB0); // turn off left digit (tens)
	CBI  0x18,0
; 0000 0136 		cbi(PORTB, PORTB1); // turn off right digit (units)
	CBI  0x18,1
; 0000 0137 
; 0000 0138 		screensaver_timeout--; // decrement screensaver timeout value
	MOVW R30,R6
	SBIW R30,1
	MOVW R6,R30
; 0000 0139 		if(screensaver_timeout == 0) {
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x29
; 0000 013A 			// shut down display function
; 0000 013B 			eeprom_write_byte(&eeprom_locked, locked); // save locked/unlocked status
	CALL SUBOPT_0x2
; 0000 013C 			eeprom_write_word(&eeprom_dial.value, dial.value); // save current dial position
	CALL SUBOPT_0x3
	LDI  R26,LOW(_eeprom_dial)
	LDI  R27,HIGH(_eeprom_dial)
	CALL __EEPROMWRW
; 0000 013D 			if(combo_state != COMBO_MATCH_3) combo_state = COMBO_MATCH_0; // reset any combination attempts
	LDS  R26,_combo_state
	CPI  R26,LOW(0x3)
	BREQ _0x2A
	LDI  R30,LOW(0)
	STS  _combo_state,R30
; 0000 013E 			prog_state = PROG_0; // cancel any pending combination programming attempts
_0x2A:
	LDI  R30,LOW(0)
	STS  _prog_state,R30
; 0000 013F 
; 0000 0140 			return; // early exit from interrupt handler, leaving display blank; nothing left to do
	RJMP _0x44
; 0000 0141 		}
; 0000 0142 
; 0000 0143 		digit ^= 0x01; // toggle between left & right digits
_0x29:
	LDS  R26,_digit_S0000006000
	LDI  R30,LOW(1)
	EOR  R30,R26
	STS  _digit_S0000006000,R30
; 0000 0144 
; 0000 0145 		if(digit == DIGIT_LEFT) {
	CPI  R30,0
	BRNE _0x2B
; 0000 0146 			// display left digit
; 0000 0147 			PORTA = LED_segment(dial.tens);
	LDS  R26,_dial
	RCALL _LED_segment
	OUT  0x1B,R30
; 0000 0148 			sbi(PORTB, PORTB0); // turn on left digit (tens)
	SBI  0x18,0
; 0000 0149 		} else {
	RJMP _0x2C
_0x2B:
; 0000 014A 			// display right digit
; 0000 014B 			PORTA = LED_segment(dial.units);
	__GETB2MN _dial,1
	RCALL _LED_segment
	OUT  0x1B,R30
; 0000 014C 			sbi(PORTB, PORTB1); // turn on right digit (units)
	SBI  0x18,1
; 0000 014D 		}
_0x2C:
; 0000 014E 	}
; 0000 014F }
_0x28:
_0x44:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0154 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	ST   -Y,R30
; 0000 0155 // Reinitialize Timer1 value
; 0000 0156 TCNT1H=0x5333 >> 8;
	LDI  R30,LOW(83)
	OUT  0x2D,R30
; 0000 0157 TCNT1L=0x5333 & 0xff;
	LDI  R30,LOW(51)
	OUT  0x2C,R30
; 0000 0158 // Place your code here
; 0000 0159 
; 0000 015A 
; 0000 015B }
	LD   R30,Y+
	RETI
; .FEND
;
;
;void main(void)
; 0000 015F {
_main:
; .FSTART _main
; 0000 0160 // Declare your local variables here
; 0000 0161 
; 0000 0162 // Input/Output Ports initialization
; 0000 0163 // Port A initialization
; 0000 0164 // Function: Bit7=In Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0165 DDRA=(0<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(127)
	OUT  0x1A,R30
; 0000 0166 // State: Bit7=T Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 0167 PORTA=(0<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (1<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);
	OUT  0x1B,R30
; 0000 0168 
; 0000 0169 // Port B initialization
; 0000 016A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=Out Bit0=Out
; 0000 016B DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(3)
	OUT  0x17,R30
; 0000 016C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=P Bit1=0 Bit0=0
; 0000 016D PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (1<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(4)
	OUT  0x18,R30
; 0000 016E 
; 0000 016F // Port C initialization
; 0000 0170 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0171 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(0)
	OUT  0x14,R30
; 0000 0172 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0173 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0174 
; 0000 0175 // Port D initialization
; 0000 0176 // Function: Bit7=In Bit6=Out Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0177 DDRD=(0<<DDD7) | (1<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(64)
	OUT  0x11,R30
; 0000 0178 // State: Bit7=T Bit6=1 Bit5=T Bit4=T Bit3=P Bit2=P Bit1=T Bit0=T
; 0000 0179 PORTD=(0<<PORTD7) | (1<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(76)
	OUT  0x12,R30
; 0000 017A 
; 0000 017B 
; 0000 017C // Timer/Counter 0 initialization
; 0000 017D // Clock source: System Clock
; 0000 017E // Clock value: 172.800 kHz
; 0000 017F // Mode: Normal top=0xFF
; 0000 0180 // OC0 output: Disconnected
; 0000 0181 // Timer Period: 1.0243 ms
; 0000 0182 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 0183 TCNT0=0x4F;
	LDI  R30,LOW(79)
	OUT  0x32,R30
; 0000 0184 OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
; 0000 0185 
; 0000 0186 // Timer/Counter 1 initialization
; 0000 0187 // Clock source: System Clock
; 0000 0188 // Clock value: 10.800 kHz
; 0000 0189 // Mode: Normal top=0xFFFF
; 0000 018A // OC1A output: Disconnected
; 0000 018B // OC1B output: Disconnected
; 0000 018C // Noise Canceler: Off
; 0000 018D // Input Capture on Falling Edge
; 0000 018E // Timer Period: 4.096 s
; 0000 018F // Timer1 Overflow Interrupt: On
; 0000 0190 // Input Capture Interrupt: Off
; 0000 0191 // Compare A Match Interrupt: Off
; 0000 0192 // Compare B Match Interrupt: Off
; 0000 0193 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0194 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (1<<CS12) | (0<<CS11) | (1<<CS10);
	LDI  R30,LOW(5)
	OUT  0x2E,R30
; 0000 0195 TCNT1H=0x53;
	LDI  R30,LOW(83)
	OUT  0x2D,R30
; 0000 0196 TCNT1L=0x33;
	LDI  R30,LOW(51)
	OUT  0x2C,R30
; 0000 0197 ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 0198 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0199 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 019A OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 019B OCR1BH=0x00;
	OUT  0x29,R30
; 0000 019C OCR1BL=0x00;
	OUT  0x28,R30
; 0000 019D 
; 0000 019E // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 019F TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(5)
	OUT  0x39,R30
; 0000 01A0 
; 0000 01A1 // External Interrupt(s) initialization
; 0000 01A2 // INT0: On
; 0000 01A3 // INT0 Mode: Falling Edge
; 0000 01A4 // INT1: Off
; 0000 01A5 // INT2: On
; 0000 01A6 // INT2 Mode: Falling Edge
; 0000 01A7 GICR|=(0<<INT1) | (1<<INT0) | (1<<INT2);
	IN   R30,0x3B
	ORI  R30,LOW(0x60)
	OUT  0x3B,R30
; 0000 01A8 MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 01A9 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 01AA GIFR=(0<<INTF1) | (1<<INTF0) | (1<<INTF2);
	LDI  R30,LOW(96)
	OUT  0x3A,R30
; 0000 01AB 
; 0000 01AC // Global enable interrupts
; 0000 01AD #asm("sei")
	sei
; 0000 01AE 
; 0000 01AF 	locked = eeprom_read_byte(&eeprom_locked); // saved locked status
	LDI  R26,LOW(_eeprom_locked)
	LDI  R27,HIGH(_eeprom_locked)
	CALL __EEPROMRDB
	MOV  R5,R30
; 0000 01B0 	if(locked == STATUS_UNLOCKED) {
	TST  R5
	BRNE _0x2D
; 0000 01B1 		unlock(); // unlocked
	SBI  0x12,6
	CLR  R5
; 0000 01B2 	} else if(locked == STATUS_LOCKED) {
	RJMP _0x2E
_0x2D:
; 0000 01B3 		lock(); // locked
; 0000 01B4 	} else {
; 0000 01B5 		lock(); // unknown/unexpected state:  default is locked
_0x42:
	CBI  0x12,6
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 01B6 	}
_0x2E:
; 0000 01B7 
; 0000 01B8 	if(locked == STATUS_LOCKED) {
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0x31
; 0000 01B9 		screensaver_timeout = SCREENSAVER_TIMEOUT_VALUE; // reset screensaver timeout value
	LDI  R30,LOW(10000)
	LDI  R31,HIGH(10000)
	MOVW R6,R30
; 0000 01BA 		combo_state = COMBO_MATCH_0; // nothing happening
	LDI  R30,LOW(0)
	RJMP _0x43
; 0000 01BB 	} else {
_0x31:
; 0000 01BC 		screensaver_timeout = 0; // if unlocked, current dial position is 3rd number of combination:  DO NOT REVEAL
	CLR  R6
	CLR  R7
; 0000 01BD 		combo_state = COMBO_MATCH_3; // unlocked, waiting for motion to relock
	LDI  R30,LOW(3)
_0x43:
	STS  _combo_state,R30
; 0000 01BE 	}
; 0000 01BF 
; 0000 01C0 	dial.value = eeprom_read_word(&eeprom_dial.value); // saved dial position
	LDI  R26,LOW(_eeprom_dial)
	LDI  R27,HIGH(_eeprom_dial)
	CALL __EEPROMRDW
	STS  _dial,R30
	STS  _dial+1,R31
; 0000 01C1 	if((dial.units >= 0) && (dial.units <= 9) && (dial.tens >= 0) && (dial.tens <= 9)) {
	__GETB2MN _dial,1
	CPI  R26,0
	BRLT _0x34
	__GETB2MN _dial,1
	CPI  R26,LOW(0xA)
	BRGE _0x34
	LDS  R26,_dial
	CPI  R26,0
	BRLT _0x34
	LDS  R26,_dial
	CPI  R26,LOW(0xA)
	BRLT _0x35
_0x34:
	RJMP _0x33
_0x35:
; 0000 01C2 		// saved dial position was valid; continue
; 0000 01C3 	} else {
	RJMP _0x36
_0x33:
; 0000 01C4 		dial.units = 0; // reset dial position
	LDI  R30,LOW(0)
	__PUTB1MN _dial,1
; 0000 01C5 		dial.tens = 0;
	STS  _dial,R30
; 0000 01C6 	}
_0x36:
; 0000 01C7 
; 0000 01C8 	combo[0].value = eeprom_read_word(&eeprom_combo[0].value); // saved combination 1/3
	LDI  R26,LOW(_eeprom_combo)
	LDI  R27,HIGH(_eeprom_combo)
	CALL __EEPROMRDW
	STS  _combo,R30
	STS  _combo+1,R31
; 0000 01C9 	combo[1].value = eeprom_read_word(&eeprom_combo[1].value); // saved combination 2/3
	__POINTW2MN _eeprom_combo,2
	CALL __EEPROMRDW
	__PUTW1MN _combo,2
; 0000 01CA 	combo[2].value = eeprom_read_word(&eeprom_combo[2].value); // saved combination 3/3
	__POINTW2MN _eeprom_combo,4
	CALL __EEPROMRDW
	__PUTW1MN _combo,4
; 0000 01CB 
; 0000 01CC 	if((combo[0].units >= 0) && (combo[0].units <= 9) && (combo[0].tens >= 0) && (combo[0].tens <= 9)
; 0000 01CD 		&& (combo[1].units >= 0) && (combo[1].units <= 9) && (combo[1].tens >= 0) && (combo[1].tens <= 9)
; 0000 01CE 		&& (combo[2].units >= 0) && (combo[2].units <= 9) && (combo[2].tens >= 0) && (combo[2].tens <= 9)) {
	__GETB2MN _combo,1
	CPI  R26,0
	BRLT _0x38
	__GETB2MN _combo,1
	CPI  R26,LOW(0xA)
	BRGE _0x38
	LDS  R26,_combo
	CPI  R26,0
	BRLT _0x38
	LDS  R26,_combo
	CPI  R26,LOW(0xA)
	BRGE _0x38
	__GETB2MN _combo,3
	CPI  R26,0
	BRLT _0x38
	__GETB2MN _combo,3
	CPI  R26,LOW(0xA)
	BRGE _0x38
	__GETB2MN _combo,2
	CPI  R26,0
	BRLT _0x38
	__GETB2MN _combo,2
	CPI  R26,LOW(0xA)
	BRGE _0x38
	__GETB2MN _combo,5
	CPI  R26,0
	BRLT _0x38
	__GETB2MN _combo,5
	CPI  R26,LOW(0xA)
	BRGE _0x38
	__GETB2MN _combo,4
	CPI  R26,0
	BRLT _0x38
	__GETB2MN _combo,4
	CPI  R26,LOW(0xA)
	BRLT _0x39
_0x38:
	RJMP _0x37
_0x39:
; 0000 01CF 		// saved combination was valid; continue
; 0000 01D0 	} else {
	RJMP _0x3A
_0x37:
; 0000 01D1 		combo[0].units = 3; // default combination 1/3
	LDI  R30,LOW(3)
	__PUTB1MN _combo,1
; 0000 01D2 		combo[0].tens = 0;
	LDI  R30,LOW(0)
	STS  _combo,R30
; 0000 01D3 		combo[1].units = 1; // default combination 2/3
	LDI  R30,LOW(1)
	__PUTB1MN _combo,3
; 0000 01D4 		combo[1].tens = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _combo,2
; 0000 01D5 		combo[2].units = 4; // default combination 3/3
	LDI  R30,LOW(4)
	__PUTB1MN _combo,5
; 0000 01D6 		combo[2].tens = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _combo,4
; 0000 01D7 	}
_0x3A:
; 0000 01D8 
; 0000 01D9 
; 0000 01DA 	sei(); // enable global interrupts
	sei
; 0000 01DB 
; 0000 01DC 
; 0000 01DD 
; 0000 01DE 
; 0000 01DF     sleep_enable();
	RCALL _sleep_enable
; 0000 01E0 
; 0000 01E1 while (1)
_0x3B:
; 0000 01E2       {
; 0000 01E3       // Place your code here
; 0000 01E4        sleep_enter();
	sleep
; 0000 01E5       // LED_blink(1);
; 0000 01E6 
; 0000 01E7       }
	RJMP _0x3B
; 0000 01E8 }
_0x3E:
	RJMP _0x3E
; .FEND

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_sleep_enable:
; .FSTART _sleep_enable
   in   r30,power_ctrl_reg
   sbr  r30,__se_bit
   out  power_ctrl_reg,r30
	RET
; .FEND

	.DSEG
_dial:
	.BYTE 0x2
_combo:
	.BYTE 0x6
_combo_state:
	.BYTE 0x1
_prog_state:
	.BYTE 0x1

	.ESEG
_eeprom_locked:
	.BYTE 0x1
_eeprom_dial:
	.BYTE 0x2
_eeprom_combo:
	.BYTE 0x6

	.DSEG
_candidate_S0000005000:
	.BYTE 0x6
_digit_S0000006000:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x0:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	LDS  R26,_dial
	LDS  R27,_dial+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	MOV  R30,R5
	LDI  R26,LOW(_eeprom_locked)
	LDI  R27,HIGH(_eeprom_locked)
	CALL __EEPROMWRB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDS  R30,_dial
	LDS  R31,_dial+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDS  R30,_candidate_S0000005000
	LDS  R31,_candidate_S0000005000+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	__GETW1MN _candidate_S0000005000,2
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xACD
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
