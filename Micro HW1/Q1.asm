ORG 100h

MOV AL,35H  ;AL

CALL convtod 
CALL displaydecimal
CALL convtob
CALL displaybinary

RET


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
