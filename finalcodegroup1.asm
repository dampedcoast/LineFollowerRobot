
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;finalcodegroup1.c,7 :: 		void interrupt(){
;finalcodegroup1.c,8 :: 		if(INTCON & 0B00000010){
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;finalcodegroup1.c,9 :: 		start_flag = 1;
	MOVLW      1
	MOVWF      _start_flag+0
;finalcodegroup1.c,10 :: 		INTCON = INTCON & 0B11110101;   // clear INTF
	MOVLW      245
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,11 :: 		}
L_interrupt0:
;finalcodegroup1.c,13 :: 		if((INTCON & 0B00000100) && (start_flag == 1)){
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt3
	MOVF       _start_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt157:
;finalcodegroup1.c,14 :: 		TMR0 = 248;
	MOVLW      248
	MOVWF      TMR0+0
;finalcodegroup1.c,15 :: 		ms_counter++;
	INCF       _ms_counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ms_counter+1, 1
;finalcodegroup1.c,16 :: 		INTCON = INTCON & 0B11111011;   // clear T0IF
	MOVLW      251
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,17 :: 		}
L_interrupt3:
;finalcodegroup1.c,18 :: 		}
L_end_interrupt:
L__interrupt177:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_CCPPWM_init:

;finalcodegroup1.c,21 :: 		void CCPPWM_init(void){
;finalcodegroup1.c,22 :: 		T2CON   = 0x07;
	MOVLW      7
	MOVWF      T2CON+0
;finalcodegroup1.c,23 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;finalcodegroup1.c,24 :: 		CCP2CON = 0x0C;
	MOVLW      12
	MOVWF      CCP2CON+0
;finalcodegroup1.c,25 :: 		PR2     = 250;
	MOVLW      250
	MOVWF      PR2+0
;finalcodegroup1.c,26 :: 		}
L_end_CCPPWM_init:
	RETURN
; end of _CCPPWM_init

_Move:

;finalcodegroup1.c,29 :: 		void Move(unsigned char a, unsigned char b){
;finalcodegroup1.c,30 :: 		PORTB = PORTB & 0B11110101;
	MOVLW      245
	ANDWF      PORTB+0, 1
;finalcodegroup1.c,31 :: 		PORTB = PORTB | 0B00010100;
	MOVLW      20
	IORWF      PORTB+0, 1
;finalcodegroup1.c,32 :: 		CCPR2L = b;
	MOVF       FARG_Move_b+0, 0
	MOVWF      CCPR2L+0
;finalcodegroup1.c,33 :: 		CCPR1L = a;
	MOVF       FARG_Move_a+0, 0
	MOVWF      CCPR1L+0
;finalcodegroup1.c,34 :: 		}
L_end_Move:
	RETURN
; end of _Move

_Pivot_Left:

;finalcodegroup1.c,37 :: 		void Pivot_Left(unsigned char speed){
;finalcodegroup1.c,38 :: 		PORTB = (PORTB & 0B11000001) | 0B00010010;
	MOVLW      193
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      18
	IORWF      R0+0, 0
	MOVWF      PORTB+0
;finalcodegroup1.c,39 :: 		CCPR1L = speed;
	MOVF       FARG_Pivot_Left_speed+0, 0
	MOVWF      CCPR1L+0
;finalcodegroup1.c,40 :: 		CCPR2L = speed;
	MOVF       FARG_Pivot_Left_speed+0, 0
	MOVWF      CCPR2L+0
;finalcodegroup1.c,41 :: 		}
L_end_Pivot_Left:
	RETURN
; end of _Pivot_Left

_my_delay_us:

;finalcodegroup1.c,44 :: 		void my_delay_us(unsigned int us){
;finalcodegroup1.c,46 :: 		for(i = 0; i < us; i++){
	CLRF       R1+0
	CLRF       R1+1
L_my_delay_us4:
	MOVF       FARG_my_delay_us_us+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__my_delay_us182
	MOVF       FARG_my_delay_us_us+0, 0
	SUBWF      R1+0, 0
L__my_delay_us182:
	BTFSC      STATUS+0, 0
	GOTO       L_my_delay_us5
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;finalcodegroup1.c,47 :: 		}
	GOTO       L_my_delay_us4
L_my_delay_us5:
;finalcodegroup1.c,48 :: 		}
L_end_my_delay_us:
	RETURN
; end of _my_delay_us

_my_delay_ms:

;finalcodegroup1.c,50 :: 		void my_delay_ms(unsigned int ms){
;finalcodegroup1.c,52 :: 		for(i = 0; i < ms; i++)
	CLRF       R1+0
	CLRF       R1+1
L_my_delay_ms7:
	MOVF       FARG_my_delay_ms_ms+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__my_delay_ms184
	MOVF       FARG_my_delay_ms_ms+0, 0
	SUBWF      R1+0, 0
L__my_delay_ms184:
	BTFSC      STATUS+0, 0
	GOTO       L_my_delay_ms8
;finalcodegroup1.c,53 :: 		for(j = 0; j < 300; j++);
	CLRF       R3+0
	CLRF       R3+1
L_my_delay_ms10:
	MOVLW      1
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__my_delay_ms185
	MOVLW      44
	SUBWF      R3+0, 0
L__my_delay_ms185:
	BTFSC      STATUS+0, 0
	GOTO       L_my_delay_ms11
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
	GOTO       L_my_delay_ms10
L_my_delay_ms11:
;finalcodegroup1.c,52 :: 		for(i = 0; i < ms; i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;finalcodegroup1.c,53 :: 		for(j = 0; j < 300; j++);
	GOTO       L_my_delay_ms7
L_my_delay_ms8:
;finalcodegroup1.c,54 :: 		}
L_end_my_delay_ms:
	RETURN
; end of _my_delay_ms

_Pivot_Right:

;finalcodegroup1.c,57 :: 		void Pivot_Right(unsigned char speed){
;finalcodegroup1.c,58 :: 		PORTB = (PORTB & 0B11000001) | 0B00001100;
	MOVLW      193
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      12
	IORWF      R0+0, 0
	MOVWF      PORTB+0
;finalcodegroup1.c,59 :: 		CCPR1L = speed;
	MOVF       FARG_Pivot_Right_speed+0, 0
	MOVWF      CCPR1L+0
;finalcodegroup1.c,60 :: 		CCPR2L = speed;
	MOVF       FARG_Pivot_Right_speed+0, 0
	MOVWF      CCPR2L+0
;finalcodegroup1.c,61 :: 		}
L_end_Pivot_Right:
	RETURN
; end of _Pivot_Right

_servo_write:

;finalcodegroup1.c,64 :: 		void servo_write(unsigned char pulse_ms){
;finalcodegroup1.c,68 :: 		if(pulse_ms < 1) pulse_ms = 1;
	MOVLW      1
	SUBWF      FARG_servo_write_pulse_ms+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_servo_write13
	MOVLW      1
	MOVWF      FARG_servo_write_pulse_ms+0
L_servo_write13:
;finalcodegroup1.c,69 :: 		if(pulse_ms > 2) pulse_ms = 2;
	MOVF       FARG_servo_write_pulse_ms+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_servo_write14
	MOVLW      2
	MOVWF      FARG_servo_write_pulse_ms+0
L_servo_write14:
;finalcodegroup1.c,71 :: 		low_ms = 20 - pulse_ms;
	MOVF       FARG_servo_write_pulse_ms+0, 0
	SUBLW      20
	MOVWF      servo_write_low_ms_L0+0
;finalcodegroup1.c,73 :: 		for(i = 0; i < 25; i++){
	CLRF       servo_write_i_L0+0
L_servo_write15:
	MOVLW      25
	SUBWF      servo_write_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_servo_write16
;finalcodegroup1.c,74 :: 		PORTB = PORTB | 0B00100000;
	BSF        PORTB+0, 5
;finalcodegroup1.c,75 :: 		my_delay_ms(pulse_ms);
	MOVF       FARG_servo_write_pulse_ms+0, 0
	MOVWF      FARG_my_delay_ms_ms+0
	CLRF       FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,76 :: 		PORTB = PORTB & 0B11011111;
	MOVLW      223
	ANDWF      PORTB+0, 1
;finalcodegroup1.c,77 :: 		my_delay_ms(low_ms);
	MOVF       servo_write_low_ms_L0+0, 0
	MOVWF      FARG_my_delay_ms_ms+0
	CLRF       FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,73 :: 		for(i = 0; i < 25; i++){
	INCF       servo_write_i_L0+0, 1
;finalcodegroup1.c,78 :: 		}
	GOTO       L_servo_write15
L_servo_write16:
;finalcodegroup1.c,79 :: 		}
L_end_servo_write:
	RETURN
; end of _servo_write

_flag_down:

;finalcodegroup1.c,81 :: 		void flag_down(void){ servo_write(2); }
	MOVLW      2
	MOVWF      FARG_servo_write_pulse_ms+0
	CALL       _servo_write+0
L_end_flag_down:
	RETURN
; end of _flag_down

_flag_up:

;finalcodegroup1.c,82 :: 		void flag_up(void)  { servo_write(1); }
	MOVLW      1
	MOVWF      FARG_servo_write_pulse_ms+0
	CALL       _servo_write+0
L_end_flag_up:
	RETURN
; end of _flag_up

_read_LDR:

;finalcodegroup1.c,85 :: 		unsigned int read_LDR(void){
;finalcodegroup1.c,87 :: 		ADCON0 = 0B00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;finalcodegroup1.c,88 :: 		my_delay_us(20);
	MOVLW      20
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,89 :: 		ADCON0 = ADCON0 | 0B00000100;
	BSF        ADCON0+0, 2
;finalcodegroup1.c,90 :: 		while(ADCON0 & 0B00000100);
L_read_LDR18:
	BTFSS      ADCON0+0, 2
	GOTO       L_read_LDR19
	GOTO       L_read_LDR18
L_read_LDR19:
;finalcodegroup1.c,91 :: 		adc_val = (ADRESH * 256) + ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;finalcodegroup1.c,92 :: 		return adc_val;
;finalcodegroup1.c,93 :: 		}
L_end_read_LDR:
	RETURN
; end of _read_LDR

_read_sonar_front_raw:

;finalcodegroup1.c,98 :: 		unsigned int read_sonar_front_raw(void){       // trig RD0, echo RC3
;finalcodegroup1.c,100 :: 		PORTD = PORTD & 0B11111110;
	MOVLW      254
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,101 :: 		my_delay_us(5);
	MOVLW      5
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,102 :: 		PORTD = PORTD | 0B00000001;
	BSF        PORTD+0, 0
;finalcodegroup1.c,103 :: 		my_delay_us(20);
	MOVLW      20
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,104 :: 		PORTD = PORTD & 0B11111110;
	MOVLW      254
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,105 :: 		my_delay_us(10);
	MOVLW      10
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,107 :: 		timeout = 1500;
	MOVLW      220
	MOVWF      read_sonar_front_raw_timeout_L0+0
	MOVLW      5
	MOVWF      read_sonar_front_raw_timeout_L0+1
;finalcodegroup1.c,108 :: 		while(((PORTC & 0B00001000) == 0) && timeout) timeout--;
L_read_sonar_front_raw20:
	MOVLW      8
	ANDWF      PORTC+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_front_raw21
	MOVF       read_sonar_front_raw_timeout_L0+0, 0
	IORWF      read_sonar_front_raw_timeout_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_read_sonar_front_raw21
L__read_sonar_front_raw159:
	MOVLW      1
	SUBWF      read_sonar_front_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_front_raw_timeout_L0+1, 1
	GOTO       L_read_sonar_front_raw20
L_read_sonar_front_raw21:
;finalcodegroup1.c,109 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_front_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_front_raw192
	MOVLW      0
	XORWF      read_sonar_front_raw_timeout_L0+0, 0
L__read_sonar_front_raw192:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_front_raw24
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_front_raw
L_read_sonar_front_raw24:
;finalcodegroup1.c,111 :: 		TMR1H = 0; TMR1L = 0;
	CLRF       TMR1H+0
	CLRF       TMR1L+0
;finalcodegroup1.c,112 :: 		T1CON = T1CON | 0B00000001;
	BSF        T1CON+0, 0
;finalcodegroup1.c,114 :: 		timeout = 2500;
	MOVLW      196
	MOVWF      read_sonar_front_raw_timeout_L0+0
	MOVLW      9
	MOVWF      read_sonar_front_raw_timeout_L0+1
;finalcodegroup1.c,115 :: 		while(((PORTC & 0B00001000) != 0) && timeout) timeout--;
L_read_sonar_front_raw25:
	MOVLW      8
	ANDWF      PORTC+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_read_sonar_front_raw26
	MOVF       read_sonar_front_raw_timeout_L0+0, 0
	IORWF      read_sonar_front_raw_timeout_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_read_sonar_front_raw26
L__read_sonar_front_raw158:
	MOVLW      1
	SUBWF      read_sonar_front_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_front_raw_timeout_L0+1, 1
	GOTO       L_read_sonar_front_raw25
L_read_sonar_front_raw26:
;finalcodegroup1.c,116 :: 		T1CON = T1CON & 0B11111110;
	MOVLW      254
	ANDWF      T1CON+0, 1
;finalcodegroup1.c,117 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_front_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_front_raw193
	MOVLW      0
	XORWF      read_sonar_front_raw_timeout_L0+0, 0
L__read_sonar_front_raw193:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_front_raw29
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_front_raw
L_read_sonar_front_raw29:
;finalcodegroup1.c,119 :: 		ticks = TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      read_sonar_front_raw_ticks_L0+0
	CLRF       read_sonar_front_raw_ticks_L0+1
;finalcodegroup1.c,120 :: 		ticks = (ticks * 256) + TMR1L;
	MOVF       read_sonar_front_raw_ticks_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      read_sonar_front_raw_ticks_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_front_raw_ticks_L0+1
;finalcodegroup1.c,121 :: 		return (ticks / 58);
	MOVLW      58
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
;finalcodegroup1.c,122 :: 		}
L_end_read_sonar_front_raw:
	RETURN
; end of _read_sonar_front_raw

_read_sonar_mid_raw:

;finalcodegroup1.c,124 :: 		unsigned int read_sonar_mid_raw(void){         // trig RD1, echo RD6
;finalcodegroup1.c,127 :: 		PORTD = PORTD & 0B11111101;
	MOVLW      253
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,128 :: 		my_delay_us(5);
	MOVLW      5
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,129 :: 		PORTD = PORTD | 0B00000010;
	BSF        PORTD+0, 1
;finalcodegroup1.c,130 :: 		my_delay_us(20);
	MOVLW      20
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,131 :: 		PORTD = PORTD & 0B11111101;
	MOVLW      253
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,132 :: 		my_delay_us(10);
	MOVLW      10
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,134 :: 		timeout = 1500;
	MOVLW      220
	MOVWF      read_sonar_mid_raw_timeout_L0+0
	MOVLW      5
	MOVWF      read_sonar_mid_raw_timeout_L0+1
;finalcodegroup1.c,135 :: 		do { snap = PORTD; if(snap & 0B01000000) break; timeout--; } while(timeout > 0);
L_read_sonar_mid_raw30:
	MOVF       PORTD+0, 0
	MOVWF      read_sonar_mid_raw_snap_L0+0
	BTFSS      read_sonar_mid_raw_snap_L0+0, 6
	GOTO       L_read_sonar_mid_raw33
	GOTO       L_read_sonar_mid_raw31
L_read_sonar_mid_raw33:
	MOVLW      1
	SUBWF      read_sonar_mid_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_mid_raw_timeout_L0+1, 1
	MOVF       read_sonar_mid_raw_timeout_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_mid_raw195
	MOVF       read_sonar_mid_raw_timeout_L0+0, 0
	SUBLW      0
L__read_sonar_mid_raw195:
	BTFSS      STATUS+0, 0
	GOTO       L_read_sonar_mid_raw30
L_read_sonar_mid_raw31:
;finalcodegroup1.c,136 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_mid_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_mid_raw196
	MOVLW      0
	XORWF      read_sonar_mid_raw_timeout_L0+0, 0
L__read_sonar_mid_raw196:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_mid_raw34
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_mid_raw
L_read_sonar_mid_raw34:
;finalcodegroup1.c,138 :: 		TMR1H = 0; TMR1L = 0;
	CLRF       TMR1H+0
	CLRF       TMR1L+0
;finalcodegroup1.c,139 :: 		T1CON = T1CON | 0B00000001;
	BSF        T1CON+0, 0
;finalcodegroup1.c,141 :: 		timeout = 2500;
	MOVLW      196
	MOVWF      read_sonar_mid_raw_timeout_L0+0
	MOVLW      9
	MOVWF      read_sonar_mid_raw_timeout_L0+1
;finalcodegroup1.c,142 :: 		do { snap = PORTD; if(!(snap & 0B01000000)) break; timeout--; } while(timeout > 0);
L_read_sonar_mid_raw35:
	MOVF       PORTD+0, 0
	MOVWF      read_sonar_mid_raw_snap_L0+0
	BTFSC      read_sonar_mid_raw_snap_L0+0, 6
	GOTO       L_read_sonar_mid_raw38
	GOTO       L_read_sonar_mid_raw36
L_read_sonar_mid_raw38:
	MOVLW      1
	SUBWF      read_sonar_mid_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_mid_raw_timeout_L0+1, 1
	MOVF       read_sonar_mid_raw_timeout_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_mid_raw197
	MOVF       read_sonar_mid_raw_timeout_L0+0, 0
	SUBLW      0
L__read_sonar_mid_raw197:
	BTFSS      STATUS+0, 0
	GOTO       L_read_sonar_mid_raw35
L_read_sonar_mid_raw36:
;finalcodegroup1.c,143 :: 		T1CON = T1CON & 0B11111110;
	MOVLW      254
	ANDWF      T1CON+0, 1
;finalcodegroup1.c,144 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_mid_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_mid_raw198
	MOVLW      0
	XORWF      read_sonar_mid_raw_timeout_L0+0, 0
L__read_sonar_mid_raw198:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_mid_raw39
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_mid_raw
L_read_sonar_mid_raw39:
;finalcodegroup1.c,146 :: 		ticks = TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      read_sonar_mid_raw_ticks_L0+0
	CLRF       read_sonar_mid_raw_ticks_L0+1
;finalcodegroup1.c,147 :: 		ticks = (ticks * 256) + TMR1L;
	MOVF       read_sonar_mid_raw_ticks_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      read_sonar_mid_raw_ticks_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_mid_raw_ticks_L0+1
;finalcodegroup1.c,148 :: 		return (ticks / 58);
	MOVLW      58
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
;finalcodegroup1.c,149 :: 		}
L_end_read_sonar_mid_raw:
	RETURN
; end of _read_sonar_mid_raw

_read_sonar_left_raw:

;finalcodegroup1.c,151 :: 		unsigned int read_sonar_left_raw(void){        // trig RD2, echo RD7
;finalcodegroup1.c,154 :: 		PORTD = PORTD & 0B11111011;
	MOVLW      251
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,155 :: 		my_delay_us(5);
	MOVLW      5
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,156 :: 		PORTD = PORTD | 0B00000100;
	BSF        PORTD+0, 2
;finalcodegroup1.c,157 :: 		my_delay_us(20);
	MOVLW      20
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,158 :: 		PORTD = PORTD & 0B11111011;
	MOVLW      251
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,159 :: 		my_delay_us(10);
	MOVLW      10
	MOVWF      FARG_my_delay_us_us+0
	MOVLW      0
	MOVWF      FARG_my_delay_us_us+1
	CALL       _my_delay_us+0
;finalcodegroup1.c,161 :: 		timeout = 1500;
	MOVLW      220
	MOVWF      read_sonar_left_raw_timeout_L0+0
	MOVLW      5
	MOVWF      read_sonar_left_raw_timeout_L0+1
;finalcodegroup1.c,162 :: 		do { snap = PORTD; if(snap & 0B10000000) break; timeout--; } while(timeout > 0);
L_read_sonar_left_raw40:
	MOVF       PORTD+0, 0
	MOVWF      read_sonar_left_raw_snap_L0+0
	BTFSS      read_sonar_left_raw_snap_L0+0, 7
	GOTO       L_read_sonar_left_raw43
	GOTO       L_read_sonar_left_raw41
L_read_sonar_left_raw43:
	MOVLW      1
	SUBWF      read_sonar_left_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_left_raw_timeout_L0+1, 1
	MOVF       read_sonar_left_raw_timeout_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_left_raw200
	MOVF       read_sonar_left_raw_timeout_L0+0, 0
	SUBLW      0
L__read_sonar_left_raw200:
	BTFSS      STATUS+0, 0
	GOTO       L_read_sonar_left_raw40
L_read_sonar_left_raw41:
;finalcodegroup1.c,163 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_left_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_left_raw201
	MOVLW      0
	XORWF      read_sonar_left_raw_timeout_L0+0, 0
L__read_sonar_left_raw201:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_left_raw44
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_left_raw
L_read_sonar_left_raw44:
;finalcodegroup1.c,165 :: 		TMR1H = 0; TMR1L = 0;
	CLRF       TMR1H+0
	CLRF       TMR1L+0
;finalcodegroup1.c,166 :: 		T1CON = T1CON | 0B00000001;
	BSF        T1CON+0, 0
;finalcodegroup1.c,168 :: 		timeout = 2500;
	MOVLW      196
	MOVWF      read_sonar_left_raw_timeout_L0+0
	MOVLW      9
	MOVWF      read_sonar_left_raw_timeout_L0+1
;finalcodegroup1.c,169 :: 		do { snap = PORTD; if(!(snap & 0B10000000)) break; timeout--; } while(timeout > 0);
L_read_sonar_left_raw45:
	MOVF       PORTD+0, 0
	MOVWF      read_sonar_left_raw_snap_L0+0
	BTFSC      read_sonar_left_raw_snap_L0+0, 7
	GOTO       L_read_sonar_left_raw48
	GOTO       L_read_sonar_left_raw46
L_read_sonar_left_raw48:
	MOVLW      1
	SUBWF      read_sonar_left_raw_timeout_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_sonar_left_raw_timeout_L0+1, 1
	MOVF       read_sonar_left_raw_timeout_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_left_raw202
	MOVF       read_sonar_left_raw_timeout_L0+0, 0
	SUBLW      0
L__read_sonar_left_raw202:
	BTFSS      STATUS+0, 0
	GOTO       L_read_sonar_left_raw45
L_read_sonar_left_raw46:
;finalcodegroup1.c,170 :: 		T1CON = T1CON & 0B11111110;
	MOVLW      254
	ANDWF      T1CON+0, 1
;finalcodegroup1.c,171 :: 		if(timeout == 0) return 999;
	MOVLW      0
	XORWF      read_sonar_left_raw_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar_left_raw203
	MOVLW      0
	XORWF      read_sonar_left_raw_timeout_L0+0, 0
L__read_sonar_left_raw203:
	BTFSS      STATUS+0, 2
	GOTO       L_read_sonar_left_raw49
	MOVLW      231
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	GOTO       L_end_read_sonar_left_raw
L_read_sonar_left_raw49:
;finalcodegroup1.c,173 :: 		ticks = TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      read_sonar_left_raw_ticks_L0+0
	CLRF       read_sonar_left_raw_ticks_L0+1
;finalcodegroup1.c,174 :: 		ticks = (ticks * 256) + TMR1L;
	MOVF       read_sonar_left_raw_ticks_L0+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      read_sonar_left_raw_ticks_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_left_raw_ticks_L0+1
;finalcodegroup1.c,175 :: 		return (ticks / 58);
	MOVLW      58
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
;finalcodegroup1.c,176 :: 		}
L_end_read_sonar_left_raw:
	RETURN
; end of _read_sonar_left_raw

_filter_three:

;finalcodegroup1.c,179 :: 		unsigned int filter_three(unsigned int r1, unsigned int r2, unsigned int r3){
;finalcodegroup1.c,182 :: 		if(r1 < 2) r1 = 999;
	MOVLW      0
	SUBWF      FARG_filter_three_r1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three205
	MOVLW      2
	SUBWF      FARG_filter_three_r1+0, 0
L__filter_three205:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three50
	MOVLW      231
	MOVWF      FARG_filter_three_r1+0
	MOVLW      3
	MOVWF      FARG_filter_three_r1+1
L_filter_three50:
;finalcodegroup1.c,183 :: 		if(r2 < 2) r2 = 999;
	MOVLW      0
	SUBWF      FARG_filter_three_r2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three206
	MOVLW      2
	SUBWF      FARG_filter_three_r2+0, 0
L__filter_three206:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three51
	MOVLW      231
	MOVWF      FARG_filter_three_r2+0
	MOVLW      3
	MOVWF      FARG_filter_three_r2+1
L_filter_three51:
;finalcodegroup1.c,184 :: 		if(r3 < 2) r3 = 999;
	MOVLW      0
	SUBWF      FARG_filter_three_r3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three207
	MOVLW      2
	SUBWF      FARG_filter_three_r3+0, 0
L__filter_three207:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three52
	MOVLW      231
	MOVWF      FARG_filter_three_r3+0
	MOVLW      3
	MOVWF      FARG_filter_three_r3+1
L_filter_three52:
;finalcodegroup1.c,186 :: 		if(r1 > r2){ temp = r1; r1 = r2; r2 = temp; }
	MOVF       FARG_filter_three_r1+1, 0
	SUBWF      FARG_filter_three_r2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three208
	MOVF       FARG_filter_three_r1+0, 0
	SUBWF      FARG_filter_three_r2+0, 0
L__filter_three208:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three53
	MOVF       FARG_filter_three_r1+0, 0
	MOVWF      R2+0
	MOVF       FARG_filter_three_r1+1, 0
	MOVWF      R2+1
	MOVF       FARG_filter_three_r2+0, 0
	MOVWF      FARG_filter_three_r1+0
	MOVF       FARG_filter_three_r2+1, 0
	MOVWF      FARG_filter_three_r1+1
	MOVF       R2+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       R2+1, 0
	MOVWF      FARG_filter_three_r2+1
L_filter_three53:
;finalcodegroup1.c,187 :: 		if(r2 > r3){ temp = r2; r2 = r3; r3 = temp; }
	MOVF       FARG_filter_three_r2+1, 0
	SUBWF      FARG_filter_three_r3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three209
	MOVF       FARG_filter_three_r2+0, 0
	SUBWF      FARG_filter_three_r3+0, 0
L__filter_three209:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three54
	MOVF       FARG_filter_three_r2+0, 0
	MOVWF      R2+0
	MOVF       FARG_filter_three_r2+1, 0
	MOVWF      R2+1
	MOVF       FARG_filter_three_r3+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       FARG_filter_three_r3+1, 0
	MOVWF      FARG_filter_three_r2+1
	MOVF       R2+0, 0
	MOVWF      FARG_filter_three_r3+0
	MOVF       R2+1, 0
	MOVWF      FARG_filter_three_r3+1
L_filter_three54:
;finalcodegroup1.c,188 :: 		if(r1 > r2){ temp = r1; r1 = r2; r2 = temp; }
	MOVF       FARG_filter_three_r1+1, 0
	SUBWF      FARG_filter_three_r2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filter_three210
	MOVF       FARG_filter_three_r1+0, 0
	SUBWF      FARG_filter_three_r2+0, 0
L__filter_three210:
	BTFSC      STATUS+0, 0
	GOTO       L_filter_three55
	MOVF       FARG_filter_three_r1+0, 0
	MOVWF      R2+0
	MOVF       FARG_filter_three_r1+1, 0
	MOVWF      R2+1
	MOVF       FARG_filter_three_r2+0, 0
	MOVWF      FARG_filter_three_r1+0
	MOVF       FARG_filter_three_r2+1, 0
	MOVWF      FARG_filter_three_r1+1
	MOVF       R2+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       R2+1, 0
	MOVWF      FARG_filter_three_r2+1
L_filter_three55:
;finalcodegroup1.c,190 :: 		return r2;
	MOVF       FARG_filter_three_r2+0, 0
	MOVWF      R0+0
	MOVF       FARG_filter_three_r2+1, 0
	MOVWF      R0+1
;finalcodegroup1.c,191 :: 		}
L_end_filter_three:
	RETURN
; end of _filter_three

_read_sonar_front:

;finalcodegroup1.c,194 :: 		unsigned int read_sonar_front(void){
;finalcodegroup1.c,196 :: 		r1 = read_sonar_front_raw();
	CALL       _read_sonar_front_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_front_r1_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_front_r1_L0+1
;finalcodegroup1.c,197 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,198 :: 		r2 = read_sonar_front_raw();
	CALL       _read_sonar_front_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_front_r2_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_front_r2_L0+1
;finalcodegroup1.c,199 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,200 :: 		r3 = read_sonar_front_raw();
	CALL       _read_sonar_front_raw+0
;finalcodegroup1.c,201 :: 		return filter_three(r1, r2, r3);
	MOVF       read_sonar_front_r1_L0+0, 0
	MOVWF      FARG_filter_three_r1+0
	MOVF       read_sonar_front_r1_L0+1, 0
	MOVWF      FARG_filter_three_r1+1
	MOVF       read_sonar_front_r2_L0+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       read_sonar_front_r2_L0+1, 0
	MOVWF      FARG_filter_three_r2+1
	MOVF       R0+0, 0
	MOVWF      FARG_filter_three_r3+0
	MOVF       R0+1, 0
	MOVWF      FARG_filter_three_r3+1
	CALL       _filter_three+0
;finalcodegroup1.c,202 :: 		}
L_end_read_sonar_front:
	RETURN
; end of _read_sonar_front

_read_sonar_mid:

;finalcodegroup1.c,204 :: 		unsigned int read_sonar_mid(void){
;finalcodegroup1.c,206 :: 		r1 = read_sonar_mid_raw();
	CALL       _read_sonar_mid_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_mid_r1_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_mid_r1_L0+1
;finalcodegroup1.c,207 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,208 :: 		r2 = read_sonar_mid_raw();
	CALL       _read_sonar_mid_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_mid_r2_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_mid_r2_L0+1
;finalcodegroup1.c,209 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,210 :: 		r3 = read_sonar_mid_raw();
	CALL       _read_sonar_mid_raw+0
;finalcodegroup1.c,211 :: 		return filter_three(r1, r2, r3);
	MOVF       read_sonar_mid_r1_L0+0, 0
	MOVWF      FARG_filter_three_r1+0
	MOVF       read_sonar_mid_r1_L0+1, 0
	MOVWF      FARG_filter_three_r1+1
	MOVF       read_sonar_mid_r2_L0+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       read_sonar_mid_r2_L0+1, 0
	MOVWF      FARG_filter_three_r2+1
	MOVF       R0+0, 0
	MOVWF      FARG_filter_three_r3+0
	MOVF       R0+1, 0
	MOVWF      FARG_filter_three_r3+1
	CALL       _filter_three+0
;finalcodegroup1.c,212 :: 		}
L_end_read_sonar_mid:
	RETURN
; end of _read_sonar_mid

_read_sonar_left:

;finalcodegroup1.c,214 :: 		unsigned int read_sonar_left(void){
;finalcodegroup1.c,216 :: 		r1 = read_sonar_left_raw();
	CALL       _read_sonar_left_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_left_r1_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_left_r1_L0+1
;finalcodegroup1.c,217 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,218 :: 		r2 = read_sonar_left_raw();
	CALL       _read_sonar_left_raw+0
	MOVF       R0+0, 0
	MOVWF      read_sonar_left_r2_L0+0
	MOVF       R0+1, 0
	MOVWF      read_sonar_left_r2_L0+1
;finalcodegroup1.c,219 :: 		my_delay_ms(4);
	MOVLW      4
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,220 :: 		r3 = read_sonar_left_raw();
	CALL       _read_sonar_left_raw+0
;finalcodegroup1.c,221 :: 		return filter_three(r1, r2, r3);
	MOVF       read_sonar_left_r1_L0+0, 0
	MOVWF      FARG_filter_three_r1+0
	MOVF       read_sonar_left_r1_L0+1, 0
	MOVWF      FARG_filter_three_r1+1
	MOVF       read_sonar_left_r2_L0+0, 0
	MOVWF      FARG_filter_three_r2+0
	MOVF       read_sonar_left_r2_L0+1, 0
	MOVWF      FARG_filter_three_r2+1
	MOVF       R0+0, 0
	MOVWF      FARG_filter_three_r3+0
	MOVF       R0+1, 0
	MOVWF      FARG_filter_three_r3+1
	CALL       _filter_three+0
;finalcodegroup1.c,222 :: 		}
L_end_read_sonar_left:
	RETURN
; end of _read_sonar_left

_main:

;finalcodegroup1.c,226 :: 		void main(void){
;finalcodegroup1.c,230 :: 		unsigned char zone = 1;
	MOVLW      1
	MOVWF      main_zone_L0+0
	MOVLW      88
	MOVWF      main_DARKNESS_THRESHOLD_L0+0
	MOVLW      2
	MOVWF      main_DARKNESS_THRESHOLD_L0+1
	CLRF       main_light_counter_L0+0
	CLRF       main_finish_counter_L0+0
	MOVLW      4
	MOVWF      main_kp_L0+0
	MOVLW      75
	MOVWF      main_base_speed_L0+0
	MOVLW      3
	MOVWF      main_DEADBAND_L0+0
	MOVLW      20
	MOVWF      main_MAX_CORRECTION_L0+0
	MOVLW      0
	MOVWF      main_MAX_CORRECTION_L0+1
;finalcodegroup1.c,250 :: 		ADCON1 = 0B10001110;
	MOVLW      142
	MOVWF      ADCON1+0
;finalcodegroup1.c,251 :: 		TRISA  = 0B00000111;
	MOVLW      7
	MOVWF      TRISA+0
;finalcodegroup1.c,252 :: 		TRISB  = 0B11000001;
	MOVLW      193
	MOVWF      TRISB+0
;finalcodegroup1.c,253 :: 		TRISC  = 0B00001000;
	MOVLW      8
	MOVWF      TRISC+0
;finalcodegroup1.c,254 :: 		TRISD  = 0B11110000;
	MOVLW      240
	MOVWF      TRISD+0
;finalcodegroup1.c,256 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;finalcodegroup1.c,257 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;finalcodegroup1.c,258 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;finalcodegroup1.c,259 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;finalcodegroup1.c,261 :: 		T1CON = 0B00010000;
	MOVLW      16
	MOVWF      T1CON+0
;finalcodegroup1.c,262 :: 		CCPPWM_init();
	CALL       _CCPPWM_init+0
;finalcodegroup1.c,263 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,264 :: 		flag_down();
	CALL       _flag_down+0
;finalcodegroup1.c,267 :: 		OPTION_REG = OPTION_REG | 0B01000000;
	BSF        OPTION_REG+0, 6
;finalcodegroup1.c,268 :: 		INTCON     = 0B10010000;
	MOVLW      144
	MOVWF      INTCON+0
;finalcodegroup1.c,270 :: 		while(start_flag == 0){
L_main56:
	MOVF       _start_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main57
;finalcodegroup1.c,271 :: 		}
	GOTO       L_main56
L_main57:
;finalcodegroup1.c,273 :: 		INTCON = INTCON & 0B11101101;       // disable INT0
	MOVLW      237
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,275 :: 		OPTION_REG = 0B11000111;            // TMR0: Fosc/4, 1:256 prescaler
	MOVLW      199
	MOVWF      OPTION_REG+0
;finalcodegroup1.c,276 :: 		TMR0       = 248;
	MOVLW      248
	MOVWF      TMR0+0
;finalcodegroup1.c,277 :: 		ms_counter = 0;
	CLRF       _ms_counter+0
	CLRF       _ms_counter+1
;finalcodegroup1.c,278 :: 		INTCON     = INTCON & 0B11111011;
	MOVLW      251
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,279 :: 		INTCON     = INTCON | 0B00100000;   // enable TMR0 overflow interrupt
	BSF        INTCON+0, 5
;finalcodegroup1.c,281 :: 		while(ms_counter < 3000){           // 3-second countdown
L_main58:
	MOVLW      11
	SUBWF      _ms_counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main215
	MOVLW      184
	SUBWF      _ms_counter+0, 0
L__main215:
	BTFSC      STATUS+0, 0
	GOTO       L_main59
;finalcodegroup1.c,282 :: 		}
	GOTO       L_main58
L_main59:
;finalcodegroup1.c,284 :: 		INTCON = INTCON & 0B11011111;       // disable TMR0 interrupt
	MOVLW      223
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,285 :: 		INTCON = INTCON & 0B11111011;       // clear T0IF
	MOVLW      251
	ANDWF      INTCON+0, 1
;finalcodegroup1.c,290 :: 		while(1){
L_main60:
;finalcodegroup1.c,291 :: 		unsigned int i = 0;
	CLRF       main_i_L1+0
	CLRF       main_i_L1+1
;finalcodegroup1.c,294 :: 		if(zone == 4){
	MOVF       main_zone_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main62
;finalcodegroup1.c,295 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,296 :: 		for(i; i < 1500; i++){
L_main63:
	MOVLW      5
	SUBWF      main_i_L1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main216
	MOVLW      220
	SUBWF      main_i_L1+0, 0
L__main216:
	BTFSC      STATUS+0, 0
	GOTO       L_main64
;finalcodegroup1.c,297 :: 		asm nop;
	NOP
;finalcodegroup1.c,296 :: 		for(i; i < 1500; i++){
	INCF       main_i_L1+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L1+1, 1
;finalcodegroup1.c,298 :: 		}
	GOTO       L_main63
L_main64:
;finalcodegroup1.c,299 :: 		flag_up();
	CALL       _flag_up+0
;finalcodegroup1.c,300 :: 		while(1){
L_main66:
;finalcodegroup1.c,301 :: 		PORTB = PORTB | 0B00100000;
	BSF        PORTB+0, 5
;finalcodegroup1.c,302 :: 		my_delay_ms(2);
	MOVLW      2
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,303 :: 		PORTB = PORTB & 0B11011111;
	MOVLW      223
	ANDWF      PORTB+0, 1
;finalcodegroup1.c,304 :: 		my_delay_ms(18);
	MOVLW      18
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,305 :: 		}
	GOTO       L_main66
;finalcodegroup1.c,306 :: 		}
L_main62:
;finalcodegroup1.c,309 :: 		if(zone == 1 || zone == 2){
	MOVF       main_zone_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__main175
	MOVF       main_zone_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L__main175
	GOTO       L_main70
L__main175:
;finalcodegroup1.c,310 :: 		light_level = read_LDR();
	CALL       _read_LDR+0
	MOVF       R0+0, 0
	MOVWF      main_light_level_L0+0
	MOVF       R0+1, 0
	MOVWF      main_light_level_L0+1
;finalcodegroup1.c,312 :: 		if(zone == 1 && light_level > DARKNESS_THRESHOLD){
	MOVF       main_zone_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main73
	MOVF       main_light_level_L0+1, 0
	SUBWF      main_DARKNESS_THRESHOLD_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main217
	MOVF       main_light_level_L0+0, 0
	SUBWF      main_DARKNESS_THRESHOLD_L0+0, 0
L__main217:
	BTFSC      STATUS+0, 0
	GOTO       L_main73
L__main174:
;finalcodegroup1.c,313 :: 		zone = 2;
	MOVLW      2
	MOVWF      main_zone_L0+0
;finalcodegroup1.c,314 :: 		PORTD = PORTD | 0B00001000;     // buzzer ON
	BSF        PORTD+0, 3
;finalcodegroup1.c,315 :: 		light_counter = 0;
	CLRF       main_light_counter_L0+0
;finalcodegroup1.c,316 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,317 :: 		}
	GOTO       L_main74
L_main73:
;finalcodegroup1.c,318 :: 		else if(zone == 2){
	MOVF       main_zone_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main75
;finalcodegroup1.c,319 :: 		if(light_level < DARKNESS_THRESHOLD){
	MOVF       main_DARKNESS_THRESHOLD_L0+1, 0
	SUBWF      main_light_level_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main218
	MOVF       main_DARKNESS_THRESHOLD_L0+0, 0
	SUBWF      main_light_level_L0+0, 0
L__main218:
	BTFSC      STATUS+0, 0
	GOTO       L_main76
;finalcodegroup1.c,320 :: 		light_counter++;
	INCF       main_light_counter_L0+0, 1
;finalcodegroup1.c,321 :: 		if(light_counter >= 5){         // 5 consecutive light readings
	MOVLW      5
	SUBWF      main_light_counter_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main77
;finalcodegroup1.c,322 :: 		zone = 3;
	MOVLW      3
	MOVWF      main_zone_L0+0
;finalcodegroup1.c,323 :: 		PORTD = PORTD & 0B11110111; // buzzer OFF
	MOVLW      247
	ANDWF      PORTD+0, 1
;finalcodegroup1.c,324 :: 		light_counter = 0;
	CLRF       main_light_counter_L0+0
;finalcodegroup1.c,325 :: 		Move(60, 60);
	MOVLW      60
	MOVWF      FARG_Move_a+0
	MOVLW      60
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,326 :: 		my_delay_ms(350);           // forward push to exit tunnel
	MOVLW      94
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      1
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,327 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,328 :: 		my_delay_ms(60);
	MOVLW      60
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,329 :: 		}
L_main77:
;finalcodegroup1.c,330 :: 		}
	GOTO       L_main78
L_main76:
;finalcodegroup1.c,332 :: 		light_counter = 0;              // reset if light returns
	CLRF       main_light_counter_L0+0
;finalcodegroup1.c,333 :: 		}
L_main78:
;finalcodegroup1.c,334 :: 		}
L_main75:
L_main74:
;finalcodegroup1.c,335 :: 		}
L_main70:
;finalcodegroup1.c,338 :: 		if(zone == 1){
	MOVF       main_zone_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main79
;finalcodegroup1.c,339 :: 		right_sensor = (PORTD & 0B00010000);
	MOVLW      16
	ANDWF      PORTD+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_right_sensor_L0+0
;finalcodegroup1.c,340 :: 		left_sensor  = (PORTD & 0B00100000);
	MOVLW      32
	ANDWF      PORTD+0, 0
	MOVWF      main_left_sensor_L0+0
;finalcodegroup1.c,342 :: 		if(right_sensor && left_sensor){
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main82
	MOVF       main_left_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main82
L__main173:
;finalcodegroup1.c,344 :: 		Move(50, 50);
	MOVLW      50
	MOVWF      FARG_Move_a+0
	MOVLW      50
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,345 :: 		my_delay_ms(15);
	MOVLW      15
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,346 :: 		right_sensor = (PORTD & 0B00010000);
	MOVLW      16
	ANDWF      PORTD+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_right_sensor_L0+0
;finalcodegroup1.c,347 :: 		left_sensor  = (PORTD & 0B00100000);
	MOVLW      32
	ANDWF      PORTD+0, 0
	MOVWF      main_left_sensor_L0+0
;finalcodegroup1.c,349 :: 		if(right_sensor && left_sensor){
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main85
	MOVF       main_left_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main85
L__main172:
;finalcodegroup1.c,350 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,351 :: 		my_delay_ms(40);
	MOVLW      40
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,353 :: 		Pivot_Left(50);
	MOVLW      50
	MOVWF      FARG_Pivot_Left_speed+0
	CALL       _Pivot_Left+0
;finalcodegroup1.c,356 :: 		pivot_timeout = 0;
	CLRF       main_pivot_timeout_L0+0
	CLRF       main_pivot_timeout_L0+1
;finalcodegroup1.c,357 :: 		while( PORTD & 0B00010000 ){
L_main86:
	BTFSS      PORTD+0, 4
	GOTO       L_main87
;finalcodegroup1.c,358 :: 		pivot_timeout++;
	INCF       main_pivot_timeout_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_pivot_timeout_L0+1, 1
;finalcodegroup1.c,359 :: 		if(pivot_timeout > 100000) break;
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main219
	MOVLW      0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main219
	MOVF       main_pivot_timeout_L0+1, 0
	SUBLW      134
	BTFSS      STATUS+0, 2
	GOTO       L__main219
	MOVF       main_pivot_timeout_L0+0, 0
	SUBLW      160
L__main219:
	BTFSC      STATUS+0, 0
	GOTO       L_main88
	GOTO       L_main87
L_main88:
;finalcodegroup1.c,360 :: 		}
	GOTO       L_main86
L_main87:
;finalcodegroup1.c,363 :: 		pivot_timeout = 0;
	CLRF       main_pivot_timeout_L0+0
	CLRF       main_pivot_timeout_L0+1
;finalcodegroup1.c,364 :: 		while( !(PORTD & 0B00010000) ){
L_main89:
	BTFSC      PORTD+0, 4
	GOTO       L_main90
;finalcodegroup1.c,365 :: 		pivot_timeout++;
	INCF       main_pivot_timeout_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_pivot_timeout_L0+1, 1
;finalcodegroup1.c,366 :: 		if(pivot_timeout > 200000) break;
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main220
	MOVLW      0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main220
	MOVF       main_pivot_timeout_L0+1, 0
	SUBLW      13
	BTFSS      STATUS+0, 2
	GOTO       L__main220
	MOVF       main_pivot_timeout_L0+0, 0
	SUBLW      64
L__main220:
	BTFSC      STATUS+0, 0
	GOTO       L_main91
	GOTO       L_main90
L_main91:
;finalcodegroup1.c,367 :: 		}
	GOTO       L_main89
L_main90:
;finalcodegroup1.c,369 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,370 :: 		my_delay_ms(40);
	MOVLW      40
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,372 :: 		Move(60, 60);
	MOVLW      60
	MOVWF      FARG_Move_a+0
	MOVLW      60
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,373 :: 		my_delay_ms(90);            // forward commit to centre on new arm
	MOVLW      90
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,374 :: 		}
L_main85:
;finalcodegroup1.c,375 :: 		}
	GOTO       L_main92
L_main82:
;finalcodegroup1.c,376 :: 		else if(right_sensor && !left_sensor){
	MOVF       main_right_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main95
	MOVF       main_left_sensor_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main95
L__main171:
;finalcodegroup1.c,377 :: 		Move(80, 0);                    // drift left: steer right
	MOVLW      80
	MOVWF      FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,378 :: 		}
	GOTO       L_main96
L_main95:
;finalcodegroup1.c,379 :: 		else if(left_sensor && !right_sensor){
	MOVF       main_left_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main99
	MOVF       main_right_sensor_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main99
L__main170:
;finalcodegroup1.c,380 :: 		Move(0, 80);                    // drift right: steer left
	CLRF       FARG_Move_a+0
	MOVLW      80
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,381 :: 		}
	GOTO       L_main100
L_main99:
;finalcodegroup1.c,383 :: 		Move(60, 60);                   // both off: advance to reacquire
	MOVLW      60
	MOVWF      FARG_Move_a+0
	MOVLW      60
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,384 :: 		}
L_main100:
L_main96:
L_main92:
;finalcodegroup1.c,385 :: 		}
	GOTO       L_main101
L_main79:
;finalcodegroup1.c,388 :: 		else if(zone == 2){
	MOVF       main_zone_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main102
;finalcodegroup1.c,389 :: 		right_sensor = (PORTD & 0B00010000);
	MOVLW      16
	ANDWF      PORTD+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_right_sensor_L0+0
;finalcodegroup1.c,390 :: 		left_sensor  = (PORTD & 0B00100000);
	MOVLW      32
	ANDWF      PORTD+0, 0
	MOVWF      main_left_sensor_L0+0
;finalcodegroup1.c,392 :: 		if(right_sensor && !left_sensor){
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main105
	MOVF       main_left_sensor_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main105
L__main169:
;finalcodegroup1.c,393 :: 		Move(70, 20);
	MOVLW      70
	MOVWF      FARG_Move_a+0
	MOVLW      20
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,394 :: 		}
	GOTO       L_main106
L_main105:
;finalcodegroup1.c,395 :: 		else if(left_sensor && !right_sensor){
	MOVF       main_left_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main109
	MOVF       main_right_sensor_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main109
L__main168:
;finalcodegroup1.c,396 :: 		Move(20, 70);
	MOVLW      20
	MOVWF      FARG_Move_a+0
	MOVLW      70
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,397 :: 		}
	GOTO       L_main110
L_main109:
;finalcodegroup1.c,399 :: 		Move(70, 70);
	MOVLW      70
	MOVWF      FARG_Move_a+0
	MOVLW      70
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,400 :: 		}
L_main110:
L_main106:
;finalcodegroup1.c,401 :: 		}
	GOTO       L_main111
L_main102:
;finalcodegroup1.c,404 :: 		else if(zone == 3){
	MOVF       main_zone_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main112
;finalcodegroup1.c,407 :: 		right_sensor = (PORTD & 0B00010000);
	MOVLW      16
	ANDWF      PORTD+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_right_sensor_L0+0
;finalcodegroup1.c,408 :: 		left_sensor  = (PORTD & 0B00100000);
	MOVLW      32
	ANDWF      PORTD+0, 0
	MOVWF      main_left_sensor_L0+0
;finalcodegroup1.c,410 :: 		if(right_sensor && left_sensor){
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main115
	MOVF       main_left_sensor_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main115
L__main167:
;finalcodegroup1.c,411 :: 		finish_counter++;
	INCF       main_finish_counter_L0+0, 1
;finalcodegroup1.c,412 :: 		if(finish_counter >= 5){
	MOVLW      5
	SUBWF      main_finish_counter_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main116
;finalcodegroup1.c,413 :: 		zone = 4;
	MOVLW      4
	MOVWF      main_zone_L0+0
;finalcodegroup1.c,414 :: 		continue;
	GOTO       L_main60
;finalcodegroup1.c,415 :: 		}
L_main116:
;finalcodegroup1.c,416 :: 		}
	GOTO       L_main117
L_main115:
;finalcodegroup1.c,418 :: 		finish_counter = 0;
	CLRF       main_finish_counter_L0+0
;finalcodegroup1.c,419 :: 		}
L_main117:
;finalcodegroup1.c,422 :: 		dist_front = read_sonar_front_raw();
	CALL       _read_sonar_front_raw+0
	MOVF       R0+0, 0
	MOVWF      main_dist_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_front_L0+1
;finalcodegroup1.c,423 :: 		if(dist_front != 999 && dist_front < 17){
	MOVF       R0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main221
	MOVLW      231
	XORWF      R0+0, 0
L__main221:
	BTFSC      STATUS+0, 2
	GOTO       L_main120
	MOVLW      0
	SUBWF      main_dist_front_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main222
	MOVLW      17
	SUBWF      main_dist_front_L0+0, 0
L__main222:
	BTFSC      STATUS+0, 0
	GOTO       L_main120
L__main166:
;finalcodegroup1.c,424 :: 		dist_front = read_sonar_front();
	CALL       _read_sonar_front+0
	MOVF       R0+0, 0
	MOVWF      main_dist_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_front_L0+1
;finalcodegroup1.c,425 :: 		}
L_main120:
;finalcodegroup1.c,428 :: 		if(dist_front != 999 && dist_front < 22){
	MOVF       main_dist_front_L0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main223
	MOVLW      231
	XORWF      main_dist_front_L0+0, 0
L__main223:
	BTFSC      STATUS+0, 2
	GOTO       L_main123
	MOVLW      0
	SUBWF      main_dist_front_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main224
	MOVLW      22
	SUBWF      main_dist_front_L0+0, 0
L__main224:
	BTFSC      STATUS+0, 0
	GOTO       L_main123
L__main165:
;finalcodegroup1.c,429 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,430 :: 		my_delay_ms(180);
	MOVLW      180
	MOVWF      FARG_my_delay_ms_ms+0
	CLRF       FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,433 :: 		dist_mid  = read_sonar_mid();
	CALL       _read_sonar_mid+0
	MOVF       R0+0, 0
	MOVWF      main_dist_mid_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_mid_L0+1
;finalcodegroup1.c,434 :: 		dist_left = read_sonar_left();
	CALL       _read_sonar_left+0
	MOVF       R0+0, 0
	MOVWF      main_dist_left_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_left_L0+1
;finalcodegroup1.c,437 :: 		if(dist_left > dist_mid){
	MOVF       R0+1, 0
	SUBWF      main_dist_mid_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main225
	MOVF       R0+0, 0
	SUBWF      main_dist_mid_L0+0, 0
L__main225:
	BTFSC      STATUS+0, 0
	GOTO       L_main124
;finalcodegroup1.c,438 :: 		Pivot_Left(120);
	MOVLW      120
	MOVWF      FARG_Pivot_Left_speed+0
	CALL       _Pivot_Left+0
;finalcodegroup1.c,439 :: 		}
	GOTO       L_main125
L_main124:
;finalcodegroup1.c,441 :: 		Pivot_Right(120);
	MOVLW      120
	MOVWF      FARG_Pivot_Right_speed+0
	CALL       _Pivot_Right+0
;finalcodegroup1.c,442 :: 		}
L_main125:
;finalcodegroup1.c,446 :: 		pivot_timeout = 0;
	CLRF       main_pivot_timeout_L0+0
	CLRF       main_pivot_timeout_L0+1
;finalcodegroup1.c,447 :: 		while(pivot_timeout < 30){
L_main126:
	MOVLW      0
	SUBWF      main_pivot_timeout_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main226
	MOVLW      30
	SUBWF      main_pivot_timeout_L0+0, 0
L__main226:
	BTFSC      STATUS+0, 0
	GOTO       L_main127
;finalcodegroup1.c,448 :: 		dist_front = read_sonar_front_raw();
	CALL       _read_sonar_front_raw+0
	MOVF       R0+0, 0
	MOVWF      main_dist_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_front_L0+1
;finalcodegroup1.c,450 :: 		if(dist_front == 999 || dist_front > 30){
	MOVF       R0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main227
	MOVLW      231
	XORWF      R0+0, 0
L__main227:
	BTFSC      STATUS+0, 2
	GOTO       L__main164
	MOVF       main_dist_front_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main228
	MOVF       main_dist_front_L0+0, 0
	SUBLW      30
L__main228:
	BTFSS      STATUS+0, 0
	GOTO       L__main164
	GOTO       L_main130
L__main164:
;finalcodegroup1.c,451 :: 		break;
	GOTO       L_main127
;finalcodegroup1.c,452 :: 		}
L_main130:
;finalcodegroup1.c,454 :: 		my_delay_ms(25);
	MOVLW      25
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,455 :: 		pivot_timeout++;
	INCF       main_pivot_timeout_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_pivot_timeout_L0+1, 1
;finalcodegroup1.c,456 :: 		}
	GOTO       L_main126
L_main127:
;finalcodegroup1.c,458 :: 		Move(0, 0);
	CLRF       FARG_Move_a+0
	CLRF       FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,459 :: 		my_delay_ms(50);
	MOVLW      50
	MOVWF      FARG_my_delay_ms_ms+0
	MOVLW      0
	MOVWF      FARG_my_delay_ms_ms+1
	CALL       _my_delay_ms+0
;finalcodegroup1.c,460 :: 		}
	GOTO       L_main131
L_main123:
;finalcodegroup1.c,465 :: 		dist_front = read_sonar_front();
	CALL       _read_sonar_front+0
	MOVF       R0+0, 0
	MOVWF      main_dist_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_front_L0+1
;finalcodegroup1.c,467 :: 		if(dist_front == 999 || dist_front > 50){
	MOVF       R0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main229
	MOVLW      231
	XORWF      R0+0, 0
L__main229:
	BTFSC      STATUS+0, 2
	GOTO       L__main163
	MOVF       main_dist_front_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main230
	MOVF       main_dist_front_L0+0, 0
	SUBLW      50
L__main230:
	BTFSS      STATUS+0, 0
	GOTO       L__main163
	GOTO       L_main134
L__main163:
;finalcodegroup1.c,468 :: 		base_speed = 75;        // open corridor: full speed
	MOVLW      75
	MOVWF      main_base_speed_L0+0
;finalcodegroup1.c,469 :: 		}
	GOTO       L_main135
L_main134:
;finalcodegroup1.c,470 :: 		else if(dist_front > 30){
	MOVF       main_dist_front_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main231
	MOVF       main_dist_front_L0+0, 0
	SUBLW      30
L__main231:
	BTFSC      STATUS+0, 0
	GOTO       L_main136
;finalcodegroup1.c,471 :: 		base_speed = 55;        // approaching: moderate speed
	MOVLW      55
	MOVWF      main_base_speed_L0+0
;finalcodegroup1.c,472 :: 		}
	GOTO       L_main137
L_main136:
;finalcodegroup1.c,473 :: 		else if(dist_front >= 22){
	MOVLW      0
	SUBWF      main_dist_front_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main232
	MOVLW      22
	SUBWF      main_dist_front_L0+0, 0
L__main232:
	BTFSS      STATUS+0, 0
	GOTO       L_main138
;finalcodegroup1.c,474 :: 		base_speed = 40;        // near threshold: slow down
	MOVLW      40
	MOVWF      main_base_speed_L0+0
;finalcodegroup1.c,475 :: 		}
	GOTO       L_main139
L_main138:
;finalcodegroup1.c,477 :: 		continue;               // below 22 cm: trigger avoidance next iteration
	GOTO       L_main60
;finalcodegroup1.c,478 :: 		}
L_main139:
L_main137:
L_main135:
;finalcodegroup1.c,481 :: 		dist_mid  = read_sonar_mid();
	CALL       _read_sonar_mid+0
	MOVF       R0+0, 0
	MOVWF      main_dist_mid_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_mid_L0+1
;finalcodegroup1.c,482 :: 		dist_left = read_sonar_left();
	CALL       _read_sonar_left+0
	MOVF       R0+0, 0
	MOVWF      main_dist_left_L0+0
	MOVF       R0+1, 0
	MOVWF      main_dist_left_L0+1
;finalcodegroup1.c,484 :: 		if(dist_left == 999 || dist_left > 40) dist_left = 40;
	MOVF       R0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main233
	MOVLW      231
	XORWF      R0+0, 0
L__main233:
	BTFSC      STATUS+0, 2
	GOTO       L__main162
	MOVF       main_dist_left_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main234
	MOVF       main_dist_left_L0+0, 0
	SUBLW      40
L__main234:
	BTFSS      STATUS+0, 0
	GOTO       L__main162
	GOTO       L_main142
L__main162:
	MOVLW      40
	MOVWF      main_dist_left_L0+0
	MOVLW      0
	MOVWF      main_dist_left_L0+1
L_main142:
;finalcodegroup1.c,485 :: 		if(dist_mid  == 999 || dist_mid  > 40) dist_mid  = 40;
	MOVF       main_dist_mid_L0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main235
	MOVLW      231
	XORWF      main_dist_mid_L0+0, 0
L__main235:
	BTFSC      STATUS+0, 2
	GOTO       L__main161
	MOVF       main_dist_mid_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main236
	MOVF       main_dist_mid_L0+0, 0
	SUBLW      40
L__main236:
	BTFSS      STATUS+0, 0
	GOTO       L__main161
	GOTO       L_main145
L__main161:
	MOVLW      40
	MOVWF      main_dist_mid_L0+0
	MOVLW      0
	MOVWF      main_dist_mid_L0+1
L_main145:
;finalcodegroup1.c,487 :: 		p_error = (int)dist_left - (int)dist_mid;
	MOVF       main_dist_mid_L0+0, 0
	SUBWF      main_dist_left_L0+0, 0
	MOVWF      R3+0
	MOVF       main_dist_mid_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      main_dist_left_L0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      main_p_error_L0+0
	MOVF       R3+1, 0
	MOVWF      main_p_error_L0+1
;finalcodegroup1.c,490 :: 		if(p_error < (int)DEADBAND && p_error > -(int)DEADBAND){
	MOVF       main_DEADBAND_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main237
	MOVF       R1+0, 0
	SUBWF      R3+0, 0
L__main237:
	BTFSC      STATUS+0, 0
	GOTO       L_main148
	MOVF       main_DEADBAND_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	SUBLW      0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R2+1
	SUBWF      R2+1, 1
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_p_error_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main238
	MOVF       main_p_error_L0+0, 0
	SUBWF      R2+0, 0
L__main238:
	BTFSC      STATUS+0, 0
	GOTO       L_main148
L__main160:
;finalcodegroup1.c,491 :: 		p_error = 0;
	CLRF       main_p_error_L0+0
	CLRF       main_p_error_L0+1
;finalcodegroup1.c,492 :: 		}
	GOTO       L_main149
L_main148:
;finalcodegroup1.c,494 :: 		if(base_speed >= 30) {
	MOVLW      30
	SUBWF      main_base_speed_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main150
;finalcodegroup1.c,495 :: 		base_speed = base_speed - 10;   // reduce speed during correction
	MOVLW      10
	SUBWF      main_base_speed_L0+0, 1
;finalcodegroup1.c,496 :: 		}
L_main150:
;finalcodegroup1.c,497 :: 		}
L_main149:
;finalcodegroup1.c,500 :: 		p_correction = (int)kp * p_error;
	MOVF       main_kp_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       main_p_error_L0+0, 0
	MOVWF      R4+0
	MOVF       main_p_error_L0+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      main_p_correction_L0+0
	MOVF       R0+1, 0
	MOVWF      main_p_correction_L0+1
;finalcodegroup1.c,502 :: 		if(p_correction >  MAX_CORRECTION) p_correction =  MAX_CORRECTION;
	MOVLW      128
	XORWF      main_MAX_CORRECTION_L0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main239
	MOVF       R0+0, 0
	SUBWF      main_MAX_CORRECTION_L0+0, 0
L__main239:
	BTFSC      STATUS+0, 0
	GOTO       L_main151
	MOVF       main_MAX_CORRECTION_L0+0, 0
	MOVWF      main_p_correction_L0+0
	MOVF       main_MAX_CORRECTION_L0+1, 0
	MOVWF      main_p_correction_L0+1
L_main151:
;finalcodegroup1.c,503 :: 		if(p_correction < -MAX_CORRECTION) p_correction = -MAX_CORRECTION;
	MOVF       main_MAX_CORRECTION_L0+0, 0
	SUBLW      0
	MOVWF      R1+0
	MOVF       main_MAX_CORRECTION_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R1+1
	SUBWF      R1+1, 1
	MOVLW      128
	XORWF      main_p_correction_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main240
	MOVF       R1+0, 0
	SUBWF      main_p_correction_L0+0, 0
L__main240:
	BTFSC      STATUS+0, 0
	GOTO       L_main152
	MOVF       main_MAX_CORRECTION_L0+0, 0
	SUBLW      0
	MOVWF      main_p_correction_L0+0
	MOVF       main_MAX_CORRECTION_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       main_p_correction_L0+1
	SUBWF      main_p_correction_L0+1, 1
L_main152:
;finalcodegroup1.c,505 :: 		p_left_speed  = (int)base_speed - p_correction;
	MOVF       main_base_speed_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       main_p_correction_L0+0, 0
	SUBWF      R0+0, 0
	MOVWF      R2+0
	MOVF       main_p_correction_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      main_p_left_speed_L0+0
	MOVF       R2+1, 0
	MOVWF      main_p_left_speed_L0+1
;finalcodegroup1.c,506 :: 		p_right_speed = (int)base_speed + p_correction;
	MOVF       main_base_speed_L0+0, 0
	MOVWF      main_p_right_speed_L0+0
	CLRF       main_p_right_speed_L0+1
	MOVF       main_p_correction_L0+0, 0
	ADDWF      main_p_right_speed_L0+0, 1
	MOVF       main_p_correction_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_p_right_speed_L0+1, 1
;finalcodegroup1.c,509 :: 		if(p_left_speed  > 90) p_left_speed  = 90;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main241
	MOVF       R2+0, 0
	SUBLW      90
L__main241:
	BTFSC      STATUS+0, 0
	GOTO       L_main153
	MOVLW      90
	MOVWF      main_p_left_speed_L0+0
	MOVLW      0
	MOVWF      main_p_left_speed_L0+1
L_main153:
;finalcodegroup1.c,510 :: 		if(p_left_speed  < 25)  p_left_speed  = 25;
	MOVLW      128
	XORWF      main_p_left_speed_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main242
	MOVLW      25
	SUBWF      main_p_left_speed_L0+0, 0
L__main242:
	BTFSC      STATUS+0, 0
	GOTO       L_main154
	MOVLW      25
	MOVWF      main_p_left_speed_L0+0
	MOVLW      0
	MOVWF      main_p_left_speed_L0+1
L_main154:
;finalcodegroup1.c,511 :: 		if(p_right_speed > 90) p_right_speed = 90;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_p_right_speed_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main243
	MOVF       main_p_right_speed_L0+0, 0
	SUBLW      90
L__main243:
	BTFSC      STATUS+0, 0
	GOTO       L_main155
	MOVLW      90
	MOVWF      main_p_right_speed_L0+0
	MOVLW      0
	MOVWF      main_p_right_speed_L0+1
L_main155:
;finalcodegroup1.c,512 :: 		if(p_right_speed < 25)  p_right_speed = 25;
	MOVLW      128
	XORWF      main_p_right_speed_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main244
	MOVLW      25
	SUBWF      main_p_right_speed_L0+0, 0
L__main244:
	BTFSC      STATUS+0, 0
	GOTO       L_main156
	MOVLW      25
	MOVWF      main_p_right_speed_L0+0
	MOVLW      0
	MOVWF      main_p_right_speed_L0+1
L_main156:
;finalcodegroup1.c,514 :: 		Move((unsigned char)p_left_speed, (unsigned char)p_right_speed);
	MOVF       main_p_left_speed_L0+0, 0
	MOVWF      FARG_Move_a+0
	MOVF       main_p_right_speed_L0+0, 0
	MOVWF      FARG_Move_b+0
	CALL       _Move+0
;finalcodegroup1.c,515 :: 		}
L_main131:
;finalcodegroup1.c,516 :: 		}
L_main112:
L_main111:
L_main101:
;finalcodegroup1.c,517 :: 		}
	GOTO       L_main60
;finalcodegroup1.c,518 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
