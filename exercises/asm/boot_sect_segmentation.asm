mov ah, 0x0e ; tty

mov al, [the_secret]
int 0x10 ; 我们已经知道这个并不能运行

mov bx, 0x7c0 ;
mov ds, bx
; 从现在开始，所有的内存都会有[ds]的偏移量
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10 ; 看起来并不对，es似乎默认是0x000？

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10


jmp $

the_secret:
    db "X"

times 510 - ($-$$) db 0
dw 0xaa55
