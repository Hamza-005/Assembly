ORG 100h


CALL readtwodigits
CALL convtod

choosemode:    
    mov ah, 09h
    lea dx, prompt2
    int 21h
    mov ah, 01h      
    int 21h          
    
    mov bh,al
    mov al,ch
    
    mov ah, 09h
    lea dx,prompt
    int 21h
    
    cmp bh, 'd'
    je dd
    cmp bh, 'b'
    je dispb
    cmp bh,'o'
    je dispo
    cmp bh,'h'
    je disph
    jmp choosemode

dd: 
CALL displaydecimal
RET
dispb:
CALL convtob
CALL displaybinary
RET
dispo:
CALL convtob
CALL displayoctal
RET
disph:
CALL convtob
CALL displayhex
RET

readtwodigits PROC
    mov ah, 09h
    lea dx,prompt1
    int 21h
    mov ah, 01h      
    int 21h          
    MOV CH,AL
    SUB CH,'0'
    SHL CH,4
    mov ah, 01h      
    int 21h          
    SUB AL,'0'
    add AL,CH
    mov CH,AL
    RET
readtwodigits ENDP


;procedure to convert AL to decimal
convtod PROC
    MOV BL,0    
    OR BL,AL    
    SHL BL,4    
    SHR BL,4 ; Units are stored in BL
    MOV CL,0    
    OR CL,AL    
    SHR CL,4 ; Tens are stored in CL

    RET
convtod ENDP


;procedure to display decimal
displaydecimal PROC
    mov ah, 09h
    lea dx,prompt
    int 21h
    MOV AH,2

    MOV DL,CL   
    ADD DL,'0'  
    INT 21H     

    MOV DL,BL   
    ADD DL,'0'  
    INT 21H 

    MOV DL,'d'
    INT 21H
    MOV DL,' '
    INT 21H
    RET
displaydecimal ENDP


;procedure to convert AL to binary
convtob PROC
    MOV DH,CL   
    SHL DH,3    
    ADD DH,CL   
    ADD DH,BL   
    ADD DH,CL    

    RET
convtob ENDP


;procedure to display binary
displaybinary PROC
    MOV CX,8
    PRINT:
        MOV AH,2
        MOV DL,'0'
        TEST DH,10000000b
        JZ ZERO
        MOV DL,'1'
    
    ZERO: 
        INT 21H
        SHL DH,1
    LOOP PRINT
    
    MOV DL,'b'
    INT 21H
    
    RET
displaybinary ENDP

;procedure to display octal
displayoctal PROC
    MOV CH,DH
    SHR CH,6
    ADD CH,'0'
    MOV AH,02h
    MOV DL,CH
    INT 21h
    MOV CH,DH
    SHL CH,2
    SHR CH,5
    ADD CH,'0'
    MOV AH,02h
    MOV DL,CH
    INT 21h
    MOV CH,DH
    SHL CH,5
    SHR CH,5
    ADD CH,'0'
    MOV AH,02h
    MOV DL,CH
    INT 21h
    RET           
displayoctal ENDP

;procedure to display hex
displayhex PROC
    MOV CH,DH
    SHR CH,4
    CALL hexchar
    MOV AH,02h
    MOV DL,CH
    INT 21h
    MOV CH,DH
    SHL CH,4
    SHR CH,4
    CALL hexchar
    MOV AH,02h
    MOV DL,CH
    INT 21h
    RET         
displayhex ENDP

hexchar PROC
    ADD CH, '0'
    CMP CH, '9'
    JLE hexcharend
    ADD CH, 7         ; Adjust for A-F
hexcharend:
    RET
hexchar ENDP

prompt1 db 'Enter two digit decimal number:$'
prompt2 db 13, 10, 'Choose base (O=Octal, b=binary, h=hex, d=decimal):$'
prompt db 13,10,'$'
