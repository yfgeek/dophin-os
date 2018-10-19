; Infinite loop (e9 fd ff)
loop:
    jmp loop

; F用510个0填充之前的代码
times 510-($-$$) db 0
; 告知BIOS这是boot sector
dw 0xaa55
