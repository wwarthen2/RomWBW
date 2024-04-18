;======================================================================
;	NABU KEYBOARD DRIVER
;
;	CREATED BY: LES BIRD
;
;======================================================================
;
; KBPORT EQU	$90
;
; POLL FOR INPUT
; KBLOOP:
;	IN	A,(KBPORT+1)
;	BIT	1,A    
;	JR	Z,KBLOOP
;	IN	A,(KBPORT)
;
; INIT:
;	XOR	A
;	CALL	SUB12
;	CALL	SUB12
;	CALL	SUB12
;	CALL	SUB12
;	CALL	SUB12
;	LD	A,40H
;	CALL	SUB12
;	LD	A,4EH
;	CALL	SUB12
;	LD	A,04H
;	CALL	SUB12
;
NABUKB_DAT	.EQU	$90
;
NABUKB_INIT:
	CALL	NEWLINE
	PRTS("NABUKB: IO=0x$")
	LD	A,NABUKB_DAT
	CALL	PRTHEXBYTE
;
	XOR	A
	CALL	NABUKB_PUT
	CALL	NABUKB_PUT
	CALL	NABUKB_PUT
	CALL	NABUKB_PUT
	CALL	NABUKB_PUT
	LD	A,$40		; RESET 8251
	CALL	NABUKB_PUT
	LD	A,$4E		; 1 STOP BIT, 8 BITS, 64X CLK
	CALL	NABUKB_PUT
	LD	A,$04		; ENABLE RECV
	CALL	NABUKB_PUT
;
	XOR	A
	RET
;
NABUKB_STAT:
	LD	A,(NABUKB_KSTAT)	; GET KEY WAITING STATUS
	OR	A			; SET FLAGS
	RET	NZ			; KEY WAITING, ALL SET
	IN	A,(NABUKB_DAT+1)	; GET BKD STATUS
	AND	$02			; CHECK DATA RDY BIT
	JR	Z,NABUKB_STAT1		; BAIL OUT IF NOT
	IN	A,(NABUKB_DAT)		; GET THE KEY
	BIT	7,A			; HIGH BIT IS SPECIAL CHAR
	CALL	NZ,NABUKB_XLAT		; IF SO, TRANSLATE IT
	JR	C,NABUKB_STAT1		; CF INDICATES INVALID
	LD	(NABUKB_KEY),A		; BUFFER IT
	LD	A,1			; KEY WAITING STATUS
	LD	(NABUKB_KSTAT),A	; SAVE IT
	OR	A			; SET FLAGS
	RET
;
NABUKB_STAT1:
	XOR	A			; SIGNAL NO CHAR READY
	JP	CIO_IDLE		; RETURN VIA IDLE PROCESSOR
;
NABUKB_XLAT:
	; NABU KEYBOARD USES $E0-$FF FOR SPECIAL KEYS
	; HERE WE TRANSLATE TO ROMWBW SPECIAL KEYS AS BEST WE CAN
	; CF IS SET ON RETURN IF KEY IS INVALID (NO TRANSLATION)
	SUB	$E0			; ZERO OFFSET
	RET	C			; ABORT IF < $E0, CF SET!
	LD	HL,NABUKB_XTBL		; POINT TO XLAT TABLE
	CALL	ADDHLA			; OFFSET BY SPECIAL KEY VAL
	LD	A,(HL)			; GET TRANSLATED VALUE
	OR	A			; CHECK FOR N/A (0)
	RET	NZ			; XLAT OK, RET W/ CF CLEAR
	SCF				; SIGNAL INVALID
	RET				; DONE
;
NABUKB_XLAT1:
	SCF				; SIGNAL INVALID
	RET				; AND DONE
;
NABUKB_FLUSH:
	XOR	A
	RET
;
NABUKB_READ:
	CALL	NABUKB_STAT		; CHECK FOR KEY READY
	JR	Z,NABUKB_READ		; LOOP TIL ONE IS READY
	LD	A,(NABUKB_KEY)		; GET THE BUFFERED KEY
	LD	E,A			; PUT IN E FOR RETURN
	XOR	A			; ZERO TO ACCUM
	LD	C,A			; NO SCANCODE
	LD	D,A			; NO KEYSTATE
	LD	(NABUKB_KSTAT),A	; CLEAR KEY WAITING STATUS
	RET				; AND RETURN
;
NABUKB_PUT:
	OUT	(NABUKB_DAT+1),A
	NOP
	NOP
	NOP
	NOP
	NOP
	RET
;
;
;
NABUKB_KSTAT	.DB	0	; KEY STATUS
NABUKB_KEY	.DB	0	; KEY BUFFER
;
; THIS TABLE TRANSLATES THE NABU KEYBOARD SPECIAL CHARS INTO
; ANALOGOUS ROMWBW STANDARD SPECIAL CHARACTERS.  THE TABLE STARTS WITH
; NABU KEY CODE $E0 AND HANDLES $20 POSSIBLE VALUES ($E0-$FF)
; THE SPECIAL KEYS SEND A SPECIFIC KEYCODE TO INDICATE DOWN (KEY
; PRESSED) AND UP (KEY RELEASED).  WE WILL ARBITRARILY CHOOSE TO
; RESPOND TO KEY RELEASED.
;
NABUKB_XTBL:
	.DB	$00		; $E0, RIGHT ARROW (DN)
	.DB	$00		; $E1, LEFT ARROW (DN)
	.DB	$00		; $E2, UP ARROW (DN)
	.DB	$00		; $E3, DOWN ARROW (DN)
	.DB	$00		; $E4, PAGE RIGHT (DN)
	.DB	$00		; $E5, PAGE LEFT (DN)
	.DB	$00		; $E6, NO (DN)
	.DB	$00		; $E7, YES (DN)
	.DB	$00		; $E8, SYM (DN)
	.DB	$00		; $E9, PAUSE (DN)
	.DB	$00		; $EA, TV/NABU (DN)
	.DB	$00		; $EB, N/A
	.DB	$00		; $EC, N/A
	.DB	$00		; $ED, N/A
	.DB	$00		; $EE, N/A
	.DB	$00		; $EF, N/A
	.DB	$F9		; $F0, RIGHT ARROW (UP) -> RIGHT ARROW
	.DB	$F8		; $F1, LEFT ARROW (UP) -> LEFT ARROW
	.DB	$F6		; $F2, UP ARROW (UP) -> UP ARROW
	.DB	$F7		; $F3, DOWN ARROW (UP) -> DOWN ARROW
	.DB	$F5		; $F4, PAGE RIGHT (UP) -> PAGE DOWN
	.DB	$F4		; $F5, PAGE LEFT (UP) -> PAGE UP
	.DB	$F3		; $F6, NO (UP) -> END
	.DB	$F2		; $F7, YES (UP) -> HOME
	.DB	$EC		; $F8, SYM (UP) -> SYSRQ
	.DB	$EE		; $F9, PAUSE (UP) -> PAUSE
	.DB	$EF		; $FA, TV/NABU (UP) -> APP
	.DB	$00		; $FB, N/A
	.DB	$00		; $FC, N/A
	.DB	$00		; $FD, N/A
	.DB	$00		; $FE, N/A
	.DB	$00		; $FF, N/A