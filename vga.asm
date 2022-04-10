;***********************************************************************************
;       Project:        VGA test picture generator
;
;***********************************************************************************
;       Assembler:      MPASM 11/07/95
;                       MPASMWIN 2.61 (MPLAB 5.20)
;
;       Processor:      PIC16F84 @ 4MHz
;***********************************************************************************
;       File:           
;       Description:    standard VGA test picture generator
;                       640x480    31.2 kHz / 59,5 Hz NN
;                       eight vertikal color bars from white to black
;                       are displayed on the screen
;
;                       This program should run on every PIC16xxx
;                       Requirements:   4MHz XTAL
;                                       416 Bytes ROM
;                                       5 output ports
;                                       no RAM, no timers, no interrupts
;
;
;       Date            Version     Changes
;       2002/08/08      1.0         first version
;
;***********************************************************************************

        include P16F84.INC              ; load header file

        list    P=16F84                 ; define processor 

       __FUSES _CP_OFF & _WDT_OFF & _XT_OSC 

; in one v period, 525 h pulses must be generated (480 lines + blank part of the picture)



; port assignment

VGAPORT             equ     PORTA
VGATRIS             equ     TRISA

;pinout of this port:
;0   blue
;1   red
;2   green
;3   h sync
;4   v sync         RA4 must have a pullup resistor !


H_SYNC_ON macro 
        bcf VGAPORT, 3
        endm
H_SYNC_OFF macro 
        bsf VGAPORT, 3
        endm
V_SYNC_ON macro 
        bcf VGAPORT, 4
        endm
V_SYNC_OFF macro 
        bsf VGAPORT, 4
        endm



;***********************************************************************************
        org     0000h                   ; program start
        goto    start

        ; define text shown in hex memory dump
        ;        2345678123456781234567812345678123456781234567812345678
        dt      "  VGA    test  picture   gen.    by      exrom         "

;***********************************************************************************
start


        banksel VGATRIS

; the following 3 lines are only needed for PIC16C71 (switch off the A/D analog input)
;        bsf         STATUS, RP0         ; Select Register Page 1
        MOVLW       B'00000111'         ; all RA pins are digital I/O. '11x' in ADCON1 won't work !!!!
        MOVWF       8                   ; write to ADCON1

        movlw B'11100000'       ; Port A Bit 0-4 Output
        movwf   VGATRIS

        banksel VGAPORT


;***********************************************************************************
; in this main loop one line of the picture is generated
line_start

         H_SYNC_ON
         call     blank_out       ;0

; ******* start of V sync - length must be 2 h sync pulses
         nop
         V_SYNC_ON
         H_SYNC_ON
         call     blank_out      ;1
 
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;2

         nop
         V_SYNC_OFF
         H_SYNC_ON
         call     blank_out      ;3
; ******* end of V sync

         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;4
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;5
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;6
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;7
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;8
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;9
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;10
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;11
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;12
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;13
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;14
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;15
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;16
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;17
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;18
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;19
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;20
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;21
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;22
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;23
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;24
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;25
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;26
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;27
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;28
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;29
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;30
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;31
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;32
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;33
         goto     $ + 1
         H_SYNC_ON
         call     blank_out      ;34

         goto     $ + 1
         H_SYNC_ON
         call     line_out       ;36
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       ;40
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       
         goto     $ + 1
         H_SYNC_ON
         call     line_out       

         goto     $ + 1
         H_SYNC_ON
         call     line_out       ;46
         call     _21_lines_out  ;47-67

         H_SYNC_ON
         call     line_out       ;68
         call     _21_lines_out  ;69-89

         H_SYNC_ON
         call     line_out       ;90
         call     _21_lines_out  ;91-111

         H_SYNC_ON
         call     line_out       ;112
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;134
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;156
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;178
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;200
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;222
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;244
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;266
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;288
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;310
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;332
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;354
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;376
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;398
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;420
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;442
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;464
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;486
         call     _21_lines_out  ;

         H_SYNC_ON
         call     line_out       ;508

         goto         $ + 1
         H_SYNC_ON
         call     line_out       ;509

         goto         $ + 1
         H_SYNC_ON
         call     line_out       ;510

         goto         $ + 1
         H_SYNC_ON
         call     line_out

         goto         $ + 1
         H_SYNC_ON
         call     line_out

         goto         $ + 1
         H_SYNC_ON
         call     line_out

         goto         $ + 1
         H_SYNC_ON
         call     line_out

         goto         $ + 1
         H_SYNC_ON
         call     line_out       ;515

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;516

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;517

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;518

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;519

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;520

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;521

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;522

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;523

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;524

         goto        $ + 1
         H_SYNC_ON
         call     blank_out      ;525

         goto     line_start



    
_21_lines_out
         H_SYNC_ON
         call     line_out    
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         goto         $ + 1
         H_SYNC_ON
         call     line_out
         
         return


line_out
        ; generate h sync each line (4us)
        H_SYNC_OFF

        movf    VGAPORT,w           ; set only bit 0 to 3 
        iorlw   B'00000111'

        ; generate color stair
        movwf   VGAPORT
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
        goto         $ + 1
        decf    VGAPORT,f
      
      return

blank_out
        ; generate h sync each line (4us)
        H_SYNC_OFF

        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
        goto         $ + 1
      
        return



        end

