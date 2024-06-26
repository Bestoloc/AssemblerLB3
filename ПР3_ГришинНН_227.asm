DATA SEGMENT
A DB ?
X DB ? 
Y DB ?  
Y1 DB ?
Y2 DB ?
PERENOS DB 13,10,"$" 
VVOD_A DB 13,10,"VVEDITE A=$" 

VVOD_X DB 13,10,"VVEDITE X=$",13,10 

VIVOD_Y DB "Y=$"
ENDS
STACK SEGMENT
DW 128 DUP(0) 
ENDS
CODE SEGMENT
START:

MOV AX, DATA
MOV DS, AX 
MOV ES, AX 
XOR AX, AX
MOV DX, OFFSET VVOD_A 
MOV AH, 9 
INT 21H 
SLED2:
MOV AH, 1
INT 21H
CMP AL, "-"
JNZ SLED1 
MOV BX, 1 
JMP SLED2 
SLED1:
SUB AL, 30H 
TEST BX, BX
JZ SLED3 
NEG AL 

SLED3:
MOV A, AL 
XOR AX, AX 
XOR BX, BX 
MOV DX, OFFSET VVOD_X 
MOV AH, 9 
INT 21H 
SLED4:
MOV AH, 1 
INT 21H 
CMP AL, "-" 
JNZ SLED5 
MOV BX, 1 
JMP SLED4 
SLED5:
SUB AL, 30H 
TEST BX, BX 
JZ SLED6 
NEG AL 
SLED6:
MOV X, AL
    MOV AL, A
    ; GET Y1
    MOV AL, X
    CMP AL, 4
    JLE @LEFT
    SUB AL, A
  
@LEFT:
    MOV AL, X
    SHL AL, 2
    JMP @Y1_2
@Y1_2:
    MOV Y1, AL 

 ; GET Y2
    MOV Al, X
    TEST Al, 1
    JNZ @Y2_1
    MOV Al, A
    ADD Al, X
    SHR Al, 1
    JMP @Y2_2 
 
@Y2_1:
    MOV Al, 7
    
@Y2_2:
    MOV Y2, Al
    
    ; GET Y
    MOV AH, 0
    MOV AL, Y1
    CBW
    MOV Ch, Y2
    ADD Al, ch
    MOV Y, Ah 
   JMP SHORT @VIXOD 
    
@VIXOD:
MOV Y, AL
MOV DX, OFFSET PERENOS 
MOV AH, 9 
INT 21H 
MOV DX, OFFSET VIVOD_Y 
MOV AH, 9 
INT 21H
MOV AL, Y
CMP Y, 0 
JGE SLED7 
NEG AL
MOV BL, AL 
MOV DL, "-" 
MOV AH, 2 
INT 21H 
MOV DL, BL 
ADD DL, 30H
INT 21H 
JMP SLED8
SLED7:
MOV DL, Y 
ADD DL, 30H 
MOV AH, 2 
INT 21H
SLED8:
MOV DX, OFFSET PERENOS 
MOV AH, 9 
INT 21H

MOV AH, 1 
INT 21H 
MOV AX, 4C00H
INT 21H
ENDS
END START
