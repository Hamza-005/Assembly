ORG 100h

JMP START
;define variables here

VAR DB 0        ;variable for input
ARRAY DB 9 (?)  ;array of 9 bytes for 9 numbers
MSG DB "Enter 9 Non-Letter Chars or enter cash sign to terminate",10,13,"$"
MSG1 DB 10,13,"Enter a non char only",10,13,"$"
MSG2 db 10,13,"Array contents are",10,13,"$"



START:
;write code here

MOV AX,@DATA
MOV DS,AX
MOV AH,9    
LEA DX,MSG  ;displays msg
INT 21H

MOV CX,9    ;take 9 numbers



INPUT:

    MOV AH,1        ;take input
    INT 21H

    MOV VAR,AL      ;store input

    MOV AH,2        
    MOV DL,10       ;dsiplay next line
    INT 21H

    MOV AH,2        ;carriage return code service
    MOV DL,13
    INT 21H

    CMP VAR,'1'     ;compare variable with non chars
    JZ STORE        ;if equal then ZF is set and jump to store
    CMP VAR,'2'
    JZ STORE
    CMP VAR,'3'
    JZ STORE
    CMP VAR,'4'
    JZ STORE
    CMP VAR,'5'
    JZ STORE
    CMP VAR,'6'
    JZ STORE
    CMP VAR,'7'
    JZ STORE
    CMP VAR,'8'
    JZ STORE
    CMP VAR,'9'
    JZ STORE
    CMP VAR,'0'
    JZ STORE
    CMP VAR,'-'
    JZ STORE
    CMP VAR,'='
    JZ STORE
    CMP VAR,'`'
    JZ STORE
    CMP VAR,'}'
    JZ STORE
    CMP VAR,']'
    JZ STORE
    CMP VAR,'['
    JZ STORE
    CMP VAR,'{'
    JZ STORE
    CMP VAR,'?'
    JZ STORE
    CMP VAR,'/'
    JZ STORE
    CMP VAR,'.'
    JZ STORE
    CMP VAR,','
    JZ STORE
    CMP VAR,'>'
    JZ STORE
    CMP VAR,'<'
    JZ STORE
    CMP VAR,'!'
    JZ STORE
    CMP VAR,'@'
    JZ STORE
    CMP VAR,'#'
    JZ STORE
    CMP VAR,'%'
    JZ STORE
    CMP VAR,'^'
    JZ STORE
    CMP VAR,'&'
    JZ STORE
    CMP VAR,'*'
    JZ STORE
    CMP VAR,'('
    JZ STORE
    CMP VAR,')'
    JZ STORE
    CMP VAR,'$'             ;if $ is entered then go to finish
    JZ FINISH

    MOV AH,9                ;if above cases didn't match and no jmp was made
    LEA DX,MSG1             ;then it was an invalid input
    INT 21H



    backToLoop:             ;check if 9 inputs were entered and stored
        CMP CX,0
        JA INPUT            ;if dx!=0 then loop
    JMP FINISH              ;else finish no more input is permitted



    STORE:
        MOV AL,VAR          ;store the input
        MOV ARRAY[DI],AL    
        INC DI
        DEC CX              ;update cx that one valid input was read and stored
    jmp backToLoop          ;go to check if dx==0(i.e,9 inputs were given>



    FINISH:                 
        MOV CX,DI
        MOV AH,2            
        MOV DL,10
        INT 21H

        MOV AH,9
        LEA DX,MSG2
        INT 21H

        MOV AH,2
        MOV DL,10           
        INT 21H



    for1:
        MOV AH,2
        MOV DL,ARRAY[SI]    ;display array elements
        INT 21H
        MOV DL,0
        MOV DX,SI
        ADD DL,'0'
        MOV AH,2
        INT 21H
        INC SI
        MOV AH,2
        MOV DL,' '          
        INT 21H
    LOOP for1
ret
