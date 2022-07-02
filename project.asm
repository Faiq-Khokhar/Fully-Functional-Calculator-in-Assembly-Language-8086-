include 'emu8086.inc'

org 100h

.data 
  
inp db ?    

msg      db 10,13,10,13,"Enter your password:",0ah,0dh,'$'  
invalid  db 10,13,10,13,"Incorrect password",0ah,0dh,'$'
valid    db 10,13,10,13,"You Are IN -- :)",0ah,0dh,'$'
password db "FLAMER"



str db 10,13,'Enter Values to be sorted: $'
str1 db 0dh,0ah,'Bubble Sorted: $'
array db 10dup(0) 


MSG1 DB 10,13,'For Addition :'1'$'
MSG2 DB 10,13,'For Subtraction :'2'$'
MSG3 DB 10,13,'For Multiplication :'3'$'
MSG4 DB 10,13,'For Division :'4'$'
MSG5 DB 10,13,'Choose Any One :$'
MSG6 DB 10,13,10,13,'Enter 1st Number :$'
MSG7 DB 10,13,'Enter 2nd Number :$'
MSG8 DB 10,13,10,13,'The Result is :$' 
NUM1 DB ?    
NUM2 DB ?
RESULT DB ?

ms1 db  0Dh,0Ah, 'Enter 1st number : $'
ms2 db "Enter the operator :    +  -  *  /     : $"
ms3 db "Enter 2nd number : $"
ms4 db  0dh,0ah , 'Answer is : $' 
er1 db  "Wrong Operator!", 0Dh,0Ah , '$'
opr db '?'
num3 dw ?
num4 dw ?

st db 10,13,"Enter Power: $"
st2 db 10,13, "2^$" 
st3 db " = $"
power dw ? 
p db ?  



 
.code 
main proc

print "                --::::WELCOME TO OUR PROJECT ::::--"
printN
print "Press 1 for Bubble Sorting"
printN
print "Press 2 for Calculator"
printN
print "Press 3 for Multiplication using shift commands"
printN       
print "Press 4 for Division using shift commands"
printN
print "Press 5 for Operations In Stack"
printN
print "Press 6 for Logical Instructions"

jmp security

security:
    printN
      
      lea dx, msg
      mov ah,09h 
      int 21h
      
      mov bx, offset password  
      mov cx,6
      
pass:      
      mov ah,01h
      int 21h
      
      cmp al,[bx]
      jne wrong
      inc bx
      loop pass
      
      lea dx, valid
      mov ah,09h 
      int 21h
      
      jmp switch
      
      
wrong: 
         lea dx,invalid
         mov ah,09h 
         int 21h
         loop exit
          

 
  
  
switch:

printN
print "Now choose whatever you want to do :) : "
mov ah,01h
int 21h
mov [inp],al

cmp [inp],'1'
je @choose1
cmp [inp],'2'
je @Choose  
cmp [inp],'3'
je @shlmul
cmp [inp],'4'
je @shrdiv
cmp [inp],'5'
je @stack
cmp [inp],'6'
je @logical  



printN
 

    MOV AX,@DATA
    MOV DS,AX



@ascending:

printN
print "                --::::Welcome to Ascending Bubble Sort::::--"
printN    

mov ah,9
lea dx,str
int 21h

mov cx,10
mov bx,offset array
mov ah,01

input:
int 21h
mov [bx],al
inc bx
Loop input

mov cx,10
dec cx

nextscan:
mov bx,cx
mov si,0

nextcomp:
mov al,array[si]
mov dl,array[si+1]
cmp al,dl

jc noswap

mov array[si],dl
mov array[si+1],al

noswap:
inc si
dec bx
jnz nextcomp

loop nextscan

mov ah,9
lea dx,str1
int 21h

mov cx,10
mov bx,offset array

; this loop to display elements on the screen
print:
mov ah,2
mov dl,[bx]
int 21h
inc bx
loop print

ret



@descending: 

printN
print "                --::::Welcome To Descending Bubble Sort::::--"
printN

mov ah,9
lea dx,str
int 21h

mov cx,6
mov bx,offset array
mov ah,1

inputs:
int 21h
mov [bx],al
push bx
inc bx 
Loop inputs

mov cx,6
dec cx

nexscan:
mov bx,cx
mov si,0

nexcomp:
mov al,array[si]
mov dl,array[si+1]
cmp al,dl

jc nswap
xchg al,dl

nswap:
inc si
dec bx
jnz nexcomp

loop nexscan

mov ah,9
lea dx,str1
int 21h

mov cx,6
mov bx,offset array

; this loop to display elements on the screen
display:
mov ah,2
mov dl,[bx]
int 21h
inc bx
pop bx  
loop display
jmp exit



@Choose:
printN
print "Press 1 for Non-Procedural Calculator"
printN
print "Press 2 for Procedural Calculator"
mov ah,01h
int 21h
mov [inp],al

cmp [inp],'1'
je @cal
cmp [inp],'2'
je @procedural 

@choose1:
printN
printN
print "Press 1 for Ascending Bubble Sort"
printN
printN
print "Press 2 for Descending Bubble Sort"
printN
printN
print "Enter Your Choice : "
mov ah,01h
int 21h
mov [inp],al

cmp [inp],'1'
je @ascending
cmp [inp],'2'
je @descending



@cal:


printN 
print "                               --::::Welcome To Mini Calculator::::--"
printN
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    LEA DX,MSG4
    MOV AH,9
    INT 21H 
    
    
    
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
  
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48
    
    CMP BH,1
    JE ADD
    
    CMP BH,2
    JE SUB
     
    CMP BH,3
    JE MUL
    
    CMP BH,4
    JE DIV
    
    
    
    
  ADD:
    printN
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    MOV AH,1
    INT 21H
    MOV CL,AL
    
    ADD AL,BL
    MOV AH,0
    AAA
    
    
    MOV BX,AX 
    ADD BH,48
    ADD BL,48 
    
 
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H 
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pushf ; save the flags 
          printn
          cmp BX,AX
          jnz prints
          print 'Zero flag is : 0'
    
     printn
        prints:
        print 'Zero flag is : 1'
          printn
          cmp ax,bx
          jno printss
          print 'Overflow flag is : 1'
    
     printn
        printss:
        print 'Overflow flag is : 0' 
       ;  popf ; restore the flags
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    JMP exit 
    
        
   SUB:
 
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    MOV AH,1
    INT 21H
    MOV CL,AL
    
    SUB BL,CL
    ADD BL,48
    
    
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H
    
    
    
    JMP EXIT 
    
    
    
    
   MUL:
 
    LEA DX,MSG6
    MOV AH,9
    INT 21H
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
    
    
    LEA DX,MSG7
    MOV AH,9
    INT 21H 
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL
    
    
    MUL NUM1
    MOV RESULT,AL
    AAM  
    
    
    ADD AH,30H
    ADD AL,30H
    
    
    MOV BX,AX 
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    
    
    JMP EXIT  
    
   
   
   
   
   
   DIV:
    LEA DX,MSG6
    MOV AH,9
    INT 21H
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
    
    
    LEA DX,MSG7
    MOV AH,9
    INT 21H 
    
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL
    
    MOV CL,NUM1
    MOV CH,00
    MOV AX,CX  
    
    DIV NUM2
    MOV RESULT,AL
    MOV AH, 00
    AAD  
    
    
    ADD AH,30H
    ADD AL,30H
    
    
    MOV BX,AX 
    
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H 
    
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    
    ;LEA DX,MSG
    ;MOV AH,9
    ;INT 21H 
    
    JMP EXIT     
    
    
    
    
    
    
@procedural:    

lea dx, ms1
mov ah, 09h   
int 21h  

call scan_num

mov num3, cx 



putc 0Dh
putc 0Ah




lea dx, ms2
mov ah, 09h     
int 21h  

mov ah,1 
int 21h
mov opr, al

putc 0Dh
putc 0Ah


cmp opr, 'q'     
je exit

cmp opr, '*'
jb wrong_opr
cmp opr, '/'
ja wrong_opr






lea dx, ms3
mov ah, 09h
int 21h  

call scan_num


mov num4, cx 




lea dx, ms4
mov ah, 09h     
int 21h

cmp opr, '+'
je do_plus

cmp opr, '-'
je do_minus

cmp opr, '*'
je do_mult

cmp opr, '/'
je do_div



wrong_opr:
lea dx, er1
mov ah, 09
int 21h   

do_plus:

mov ax, num3
add ax, num4
call print_num  
jmp exit

do_minus:

mov ax, num3
sub ax, num4
call print_num   

jmp exit

do_mult:

mov ax, num3
imul num4 
call print_num    

jmp exit

do_div:
mov dx, 0
mov ax, num3
idiv num4 
cmp dx, 0
jnz approx
call print_num  
jmp exit
approx:
call print_num        
int 21h  
jmp exit



SCAN_NUM        PROC    NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI
        
        MOV     CX, 0

      
        MOV     CS:make_minus, 0

next_digit:

     
        MOV     AH, 00h
        INT     16h
       
        MOV     AH, 0Eh
        INT     10h

       
        CMP     AL, '-'
        JE      set_minus

        
        CMP     AL, 0Dh 
        JNE     not_cr
        JMP     stop_input
not_cr:


        CMP     AL, 8                
        JNE     backspace_checked
        MOV     DX, 0                  
        MOV     AX, CX                 
        DIV     CS:ten                 
        MOV     CX, AX
        PUTC    ' '                     
        PUTC    8                     
        JMP     next_digit
backspace_checked:


       
        CMP     AL, '0'
        JAE     ok_AE_0
        JMP     remove_not_digit

ok_AE_0:        
        CMP     AL, '9'
        JBE     ok_digit

remove_not_digit:       
        PUTC    8       
        PUTC    ' '     
        PUTC    8              
        JMP     next_digit       

ok_digit:
        
        PUSH    AX
        MOV     AX, CX
        MUL     CS:ten                 
        MOV     CX, AX
        POP     AX

        
        CMP     DX, 0
        JNE     too_big

        
        SUB     AL, 30h

    
        MOV     AH, 0
        MOV     DX, CX      
        ADD     CX, AX
        JC      too_big2   

        JMP     next_digit

set_minus:
        MOV     CS:make_minus, 1
        JMP     next_digit

too_big2:
        MOV     CX, DX      
        MOV     DX, 0       

too_big:
        MOV     AX, CX
        DIV     CS:ten  
        MOV     CX, AX
        PUTC    8       
        PUTC    ' '     
        PUTC    8               
        JMP     next_digit 
        
        
stop_input:
        
        CMP     CS:make_minus, 0
        JE      not_minus
        NEG     CX

not_minus:

        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      ?       
SCAN_NUM        ENDP

PRINT_NUM       PROC    NEAR
        PUSH    DX
        PUSH    AX

        CMP     AX, 0
        JNZ     not_zero

        PUTC    '0'
        JMP     printed

not_zero:
        
        CMP     AX, 0
        JNS     positive
        NEG     AX

        PUTC    '-'

positive:
        CALL    PRINT_NUM_UNS

printed:
        POP     AX
        POP     DX
        RET
PRINT_NUM       ENDP




PRINT_NUM_UNS   PROC    NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX

        
        MOV     CX, 1

        
        MOV     BX, 10000       

        
        CMP     AX, 0
        JZ      print_zero

begin_print:
        
        CMP     BX,0
        JZ      end_print

        
        CMP     CX, 0
        JE      calc
        
        CMP     AX, BX
        JB      skip

calc:
        MOV     CX, 0   

        MOV     DX, 0
        DIV     BX     

        
        ADD     AL, 30h    
        PUTC    AL


        MOV     AX, DX  

skip:
        
        PUSH    AX
        MOV     DX, 0
        MOV     AX, BX
        DIV     CS:ten  
        MOV     BX, AX
        POP     AX

        JMP     begin_print
        
print_zero:
        PUTC    '0'
        
end_print:

        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
PRINT_NUM_UNS   ENDP



ten DW 10      

GET_STRING      PROC    NEAR
PUSH    AX
PUSH    CX
PUSH    DI
PUSH    DX

MOV     CX, 0                   

CMP     DX, 1                  
JBE     empty_buffer            

DEC     DX                      


wait_for_key:

MOV     AH, 0                   
INT     16h

CMP     AL, 0Dh                 
JZ      exit_GET_STRING


CMP     AL, 8                   
JNE     add_to_buffer
JCXZ    wait_for_key           
DEC     CX
DEC     DI
PUTC    8                      
PUTC    ' '                    
PUTC    8                  
JMP     wait_for_key


add_to_buffer:

        CMP     CX, DX         
        JAE     wait_for_key    

        MOV     [DI], AL
        INC     DI
        INC     CX
        
        
        MOV     AH, 0Eh
        INT     10h

JMP     wait_for_key


exit_GET_STRING:

MOV     [DI], 0


empty_buffer:

POP     DX
POP     DI
POP     CX
POP     AX

jmp exit


@shlmul:
mov ax,@data
mov ds,ax

mov bl,2

lea dx,st
mov ah,09h
int 21h

mov ah,01h
int 21h
and al,0fh  ;convert ascii to integer
mov [p],al
mov cl,al
dec cl

lea dx,st2
mov ah,09h
int 21h

mov dl,[p]
add dl,30h
mov ah,02h
int 21h

lea dx,st3
mov ah,09h
int 21h

shl bl,cl
mul ah
mov al,bl
AAM
mov [power],ax

mov dl,byte ptr power[1]
add dl,30h
mov ah,02h
int 21h  


mov dl,byte ptr power[0]
add dl,30h
mov ah,02h
int 21h


mov ax,4ch
int 21h

jmp exit
 
  
@shrdiv:

print "Division using shift register"
        printN
        print "Enter number : "
        mov ah,1
        int 21h
        sub al,48
        
        mov bl,al   
        
        printN
        
        
        print "How many times you want to shift: "
        mov ah,1
        int 21h
        sub al,48
        mov cl,al
        
        printN
        print "Answer is "
        mov dl,bl
        add dl,48
        mov ah,2
        int 21h
        
        print " / 2^"
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
        
        shr bl,cl
        print " = "
        
        cmp bl,9
        jg gretrSumthan9 
                mov dl,bl
                add dl,48
                mov ah,2
                int 21h
                ret
           gretrSumthan9:
            mov al,bl
            mov ah,0
            aam
            
            mov bx,ax
            
            mov dl,bh   ;first digit
            add dl,48
            mov ah,2
            int 21h
            
            mov dl,bl   ;second digit
            add dl,48
            mov ah,2
            int 21h
            
            jmp exit

    
@Stack:
    
    print "Welcome To Stack Operation"
    
    mov cx,2 
    loop1:
    printN
    print 'Enter the value : '
    mov ah,01   
    int 21h
    mov ah,0 
    push ax ;ax value --> stack
    printN
    loop loop1 
    
    mov dx,ax
    mov cx,2 
    print 'Value after Poping from Stack'   
    printN
    loop2:
    pop dx   ;stack->top->value->dx
    mov ah,02
    int 21h 
    printN
    loop loop2
    jmp exit
        

@logical: 

   printN
   print "Welcome To Logical Instruction"
   printN 
   print 'Enter 1st value : '
    mov ah,01   
    int 21h
    mov ah,0 
    mov cl,al
    printN        
    print 'Enter 2nd value : '
    mov ah,01   
    int 21h
    mov ah,0 
    mov bl,al
    printN   
        print 'The answer after XOR operation is : ' 
        mov dl,1  
        xor dl,0
        add dl,48 
        mov ah,02
        int 21h
        sub dl,48 
       printN 
       ;selective bit setting 
        print 'The answer after OR operation is : '  
        or bl,cl 
        mov dl,bl
        mov ah,02
        int 21h 
       printN 
       ;selective bit clearing
        print 'The answer after AND operation is : '  
        and cl,bl 
        mov dl,cl
        mov ah,02
        int 21h 
       printN 
       jmp exit 
       
        
    EXIT:
    
    MOV AH,4CH
    INT 21H   
    
    
    
 
END MAIN