mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10 ; 中断，用于输出字母
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; 重复输出l
mov al, 'o'
int 0x10

jmp $ ; 循环等待

; 填充和告知bios这是boot sector
times 510 - ($-$$) db 0
dw 0xaa55
