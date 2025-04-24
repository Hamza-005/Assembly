.MODEL SMALL
.STACK 100H

.DATA
    source_string DB 'Hamza Younes$', 0   ; Source string
    dest_string DB 15 DUP('$')            ; Destination buffer
    compare_string1 DB 'Hamza Younes$', 0 ; First string to compare
    compare_string2 DB 'Hamza$', 0        ; Second string to compare
    less_msg DB '1$', 0
    equal_msg DB '0$', 0
    greater_msg DB '-1$', 0
    newline DB 13, 10, '$'                ; New line characters for printing

.CODE


;STRCPY FUNCTION COPY
my_strcpy MACRO source, dest
    PUSH DS
    PUSH ES

    ; Initialize DS to point to source and ES to point to destination
    LEA SI, source
    LEA DI, dest

copy_loop:
    MOV AL, [SI]      ; Load byte from source
    MOV [DI], AL      ; Store byte to destination
    INC SI            ; Move to the next byte in source
    INC DI            ; Move to the next byte in destination
    CMP AL, '$'       ; Check if end of string
    JNZ copy_loop     ; Repeat if not end of string

    POP ES
    POP DS
ENDM


;STRCMP FUNCTION COMPARE
my_strcmp MACRO str1, str2
    LEA SI, str1
    LEA DI, str2

compare_loop:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE not_equal

    CMP AL, '$'
    JE equal

    INC SI
    INC DI
    JMP compare_loop

not_equal:
    JB less_than    ; Print -1 if str1 < str2
    JA greater_than ; Print 1 if str1 > str2

equal:
    LEA DX, equal_msg
    JMP print_result

less_than:
    LEA DX, less_msg
    JMP print_result

greater_than:
    LEA DX, greater_msg

print_result:
    MOV AH, 09H
    INT 21H

    LEA DX, newline
    MOV AH, 09H
    INT 21H
ENDM


;MAIN FUNCTION
.STARTUP

    ; Use the macro to copy from src to dst
    my_strcpy source_string, dest_string

    ; Print the destination string
    MOV AH, 09H      
    LEA DX, dest_string
    INT 21H

    ; Print new line
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Use the macro to compare strings
    my_strcmp compare_string1, compare_string2

    ; Exit program
    MOV AX, 4C00H
    INT 21H

END
