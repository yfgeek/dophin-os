mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; 设定一个远离起始点（0x7c00）的地址，不会被系统轻易覆盖
mov sp, bp ; 如果栈空，设定sp指向bp

push 'A'
push 'B'
push 'C'

; 用pop将数据出栈
; 我们需要辅助寄存器操作较低的字节
; 打印出完整的单词
pop bx
mov al, bl
int 0x10 ; 打印 C

pop bx
mov al, bl
int 0x10 ; 打印 B

pop bx
mov al, bl
int 0x10 ; 打印 A

; 所有的数据都被弹出，现在栈为空
mov al, [0x8000]
int 0x10


jmp $
times 510-($-$$) db 0
dw 0xaa55
