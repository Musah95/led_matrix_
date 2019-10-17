
_send_data:

;ScrollLED.c,13 :: 		void send_data(unsigned int temp){
;ScrollLED.c,14 :: 		unsigned int Mask = 0x01, t, Flag;
	MOVLW       1
	MOVWF       send_data_Mask_L0+0 
	MOVLW       0
	MOVWF       send_data_Mask_L0+1 
;ScrollLED.c,15 :: 		for (t=0; t<16; t++){
	CLRF        R3 
	CLRF        R4 
L_send_data0:
	MOVLW       0
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__send_data29
	MOVLW       16
	SUBWF       R3, 0 
L__send_data29:
	BTFSC       STATUS+0, 0 
	GOTO        L_send_data1
;ScrollLED.c,16 :: 		Flag = temp & Mask;
	MOVF        send_data_Mask_L0+0, 0 
	ANDWF       FARG_send_data_temp+0, 0 
	MOVWF       R1 
	MOVF        FARG_send_data_temp+1, 0 
	ANDWF       send_data_Mask_L0+1, 0 
	MOVWF       R2 
;ScrollLED.c,17 :: 		if(Flag==0) Serial_Data = 0;
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__send_data30
	MOVLW       0
	XORWF       R1, 0 
L__send_data30:
	BTFSS       STATUS+0, 2 
	GOTO        L_send_data3
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
	GOTO        L_send_data4
L_send_data3:
;ScrollLED.c,18 :: 		else Serial_Data = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
L_send_data4:
;ScrollLED.c,19 :: 		SH_Clk = 1;
	BSF         RC6_bit+0, BitPos(RC6_bit+0) 
;ScrollLED.c,20 :: 		SH_Clk = 0;
	BCF         RC6_bit+0, BitPos(RC6_bit+0) 
;ScrollLED.c,21 :: 		Mask = Mask << 1;
	RLCF        send_data_Mask_L0+0, 1 
	BCF         send_data_Mask_L0+0, 0 
	RLCF        send_data_Mask_L0+1, 1 
;ScrollLED.c,15 :: 		for (t=0; t<16; t++){
	INFSNZ      R3, 1 
	INCF        R4, 1 
;ScrollLED.c,22 :: 		}
	GOTO        L_send_data0
L_send_data1:
;ScrollLED.c,24 :: 		ST_Clk = 1;
	BSF         RC7_bit+0, BitPos(RC7_bit+0) 
;ScrollLED.c,25 :: 		ST_Clk = 0;
	BCF         RC7_bit+0, BitPos(RC7_bit+0) 
;ScrollLED.c,27 :: 		}
L_end_send_data:
	RETURN      0
; end of _send_data

_main:

;ScrollLED.c,134 :: 		void main() {
;ScrollLED.c,135 :: 		CMCON = 0x07;   // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;ScrollLED.c,136 :: 		ADCON0 = 0x00; // Select ADC channel AN0
	CLRF        ADCON0+0 
;ScrollLED.c,137 :: 		ADCON1 = 0b00001110;  // RA0 as analog input
	MOVLW       14
	MOVWF       ADCON1+0 
;ScrollLED.c,138 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;ScrollLED.c,139 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;ScrollLED.c,140 :: 		TRISA = 0x01;
	MOVLW       1
	MOVWF       TRISA+0 
;ScrollLED.c,141 :: 		StringLength = strlen(message) ;
	MOVLW       _message+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_message+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       _StringLength+0 
;ScrollLED.c,142 :: 		do {
L_main5:
;ScrollLED.c,143 :: 		for (k=0; k<StringLength; k++){
	CLRF        _k+0 
L_main8:
	MOVLW       128
	XORWF       _k+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _StringLength+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;ScrollLED.c,144 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	CLRF        _scroll+0 
L_main11:
	MOVF        _shift_step+0, 0 
	MOVWF       R4 
	MOVLW       8
	MOVWF       R0 
	CALL        _Div_8x8_S+0, 0
	MOVLW       128
	XORWF       _scroll+0, 0 
	MOVWF       R1 
	MOVLW       128
	XORWF       R0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;ScrollLED.c,145 :: 		for (ShiftAmount=0; ShiftAmount<8; ShiftAmount++){
	CLRF        _ShiftAmount+0 
L_main14:
	MOVLW       128
	XORWF       _ShiftAmount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;ScrollLED.c,146 :: 		index = message[k];
	MOVLW       _message+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_message+0)
	MOVWF       FSR0H 
	MOVF        _k+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       _k+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _index+0 
;ScrollLED.c,147 :: 		temp = CharData[index-32][ShiftAmount];
	MOVLW       32
	SUBWF       R0, 0 
	MOVWF       R5 
	CLRF        R6 
	MOVLW       0
	SUBWFB      R6, 1 
	MOVLW       3
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R6, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R4, 0 
L__main32:
	BZ          L__main33
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__main32
L__main33:
	MOVLW       _CharData+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_CharData+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_CharData+0)
	ADDWFC      R2, 1 
	MOVF        _ShiftAmount+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	BTFSC       _ShiftAmount+0, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	BTFSC       _ShiftAmount+0, 7 
	MOVLW       255
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, _temp+0
;ScrollLED.c,148 :: 		DisplayBuffer[ShiftAmount] = (DisplayBuffer[ShiftAmount] << shift_step)| (temp >> ((8-shift_step)-scroll*shift_step));
	MOVF        _ShiftAmount+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _ShiftAmount+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _DisplayBuffer+0
	ADDWF       R0, 0 
	MOVWF       FLOC__main+4 
	MOVLW       hi_addr(_DisplayBuffer+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+5 
	MOVFF       FLOC__main+4, FSR0
	MOVFF       FLOC__main+5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _shift_step+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+2 
	MOVF        R2, 0 
	MOVWF       FLOC__main+3 
	MOVF        R0, 0 
L__main34:
	BZ          L__main35
	RLCF        FLOC__main+2, 1 
	BCF         FLOC__main+2, 0 
	RLCF        FLOC__main+3, 1 
	ADDLW       255
	GOTO        L__main34
L__main35:
	MOVF        _shift_step+0, 0 
	SUBLW       8
	MOVWF       FLOC__main+0 
	CLRF        FLOC__main+1 
	MOVLW       0
	BTFSC       _shift_step+0, 7 
	MOVLW       255
	SUBWFB      FLOC__main+1, 1 
	MOVF        _scroll+0, 0 
	MOVWF       R0 
	MOVF        _shift_step+0, 0 
	MOVWF       R4 
	CALL        _Mul_8x8_S+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	SUBWFB      FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        _temp+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main36:
	BZ          L__main37
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 6 
	BSF         R0, 7 
	ADDLW       255
	GOTO        L__main36
L__main37:
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	IORWF       R0, 1 
	MOVF        FLOC__main+3, 0 
	IORWF       R1, 1 
	MOVFF       FLOC__main+4, FSR1
	MOVFF       FLOC__main+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ScrollLED.c,145 :: 		for (ShiftAmount=0; ShiftAmount<8; ShiftAmount++){
	INCF        _ShiftAmount+0, 1 
;ScrollLED.c,149 :: 		}
	GOTO        L_main14
L_main15:
;ScrollLED.c,151 :: 		speed = 10+ADC_Read(0)/10;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	ADDWF       R0, 0 
	MOVWF       _speed+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       _speed+1 
;ScrollLED.c,152 :: 		for(l=0; l<speed;l++){
	CLRF        _l+0 
L_main17:
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        _speed+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        _speed+0, 0 
	SUBWF       _l+0, 0 
L__main38:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
;ScrollLED.c,154 :: 		PORTB = 0xFE;
	MOVLW       254
	MOVWF       PORTB+0 
;ScrollLED.c,155 :: 		send_data(DisplayBuffer[1]);
	MOVF        _DisplayBuffer+2, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+3, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,156 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	NOP
	NOP
;ScrollLED.c,157 :: 		PORTB = 0xFD;
	MOVLW       253
	MOVWF       PORTB+0 
;ScrollLED.c,158 :: 		send_data(DisplayBuffer[2]);
	MOVF        _DisplayBuffer+4, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+5, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,159 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	NOP
	NOP
;ScrollLED.c,160 :: 		PORTB = 0xFB;
	MOVLW       251
	MOVWF       PORTB+0 
;ScrollLED.c,161 :: 		send_data(DisplayBuffer[3]);
	MOVF        _DisplayBuffer+6, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+7, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,162 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	NOP
	NOP
;ScrollLED.c,163 :: 		PORTB = 0xF7;
	MOVLW       247
	MOVWF       PORTB+0 
;ScrollLED.c,164 :: 		send_data(DisplayBuffer[4]);
	MOVF        _DisplayBuffer+8, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+9, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,165 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main23:
	DECFSZ      R13, 1, 1
	BRA         L_main23
	NOP
	NOP
;ScrollLED.c,166 :: 		PORTB = 0xEF;
	MOVLW       239
	MOVWF       PORTB+0 
;ScrollLED.c,167 :: 		send_data(DisplayBuffer[5]);
	MOVF        _DisplayBuffer+10, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+11, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,168 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main24:
	DECFSZ      R13, 1, 1
	BRA         L_main24
	NOP
	NOP
;ScrollLED.c,169 :: 		PORTB = 0xDF;
	MOVLW       223
	MOVWF       PORTB+0 
;ScrollLED.c,170 :: 		send_data(DisplayBuffer[6]);
	MOVF        _DisplayBuffer+12, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+13, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,171 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main25:
	DECFSZ      R13, 1, 1
	BRA         L_main25
	NOP
	NOP
;ScrollLED.c,172 :: 		PORTB = 0xBF;
	MOVLW       191
	MOVWF       PORTB+0 
;ScrollLED.c,173 :: 		send_data(DisplayBuffer[7]);
	MOVF        _DisplayBuffer+14, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+15, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,174 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main26:
	DECFSZ      R13, 1, 1
	BRA         L_main26
	NOP
	NOP
;ScrollLED.c,175 :: 		PORTB = 0x7E;
	MOVLW       126
	MOVWF       PORTB+0 
;ScrollLED.c,176 :: 		send_data(DisplayBuffer[0]);
	MOVF        _DisplayBuffer+0, 0 
	MOVWF       FARG_send_data_temp+0 
	MOVF        _DisplayBuffer+1, 0 
	MOVWF       FARG_send_data_temp+1 
	CALL        _send_data+0, 0
;ScrollLED.c,177 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_main27:
	DECFSZ      R13, 1, 1
	BRA         L_main27
	NOP
	NOP
;ScrollLED.c,152 :: 		for(l=0; l<speed;l++){
	INCF        _l+0, 1 
;ScrollLED.c,189 :: 		} // l
	GOTO        L_main17
L_main18:
;ScrollLED.c,144 :: 		for (scroll=0; scroll<(8/shift_step); scroll++) {
	INCF        _scroll+0, 1 
;ScrollLED.c,190 :: 		} // scroll
	GOTO        L_main11
L_main12:
;ScrollLED.c,143 :: 		for (k=0; k<StringLength; k++){
	INCF        _k+0, 1 
;ScrollLED.c,191 :: 		} // k
	GOTO        L_main8
L_main9:
;ScrollLED.c,193 :: 		} while(1);
	GOTO        L_main5
;ScrollLED.c,195 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
