print:
    pusha

; 相当于:
; while (string[i] != 0) { print string[i]; i++ }

start:
    mov al, [bx] ; 'bx' 是字符串开始位置
    cmp al, 0
    je done

    ; 打印出当前位字符
    mov ah, 0x0e
    int 0x10 ;

    ; bx指针地址加1
    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; 换行字符
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret
