[org 0x7c00] ; 告诉编译器，boot sector位移量

; main过程
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

jmp $

; 包含子过程
%include "boot_sect_print.asm"


; 数据
HELLO:
    db 'Hello, World', 0

GOODBYE:
    db 'Goodbye', 0

times 510-($-$$) db 0
dw 0xaa55
