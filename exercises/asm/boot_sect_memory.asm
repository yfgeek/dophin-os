mov ah, 0x0e

; 第一次尝试
; 失败，因为这样打出了'the_secret'的内存地址
; 这并不是真正的内容
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; 第二次尝试
; 尝试打印'the_secret'内存地址对应的内容，虽然失败，但是结果接近
; 这是因为BIOS在启动时，CPU从默认内存地址加载，而非启动程序对应的默认内存地址，程序启动地址为 0x7c00
; 所以我们需要在第三次尝试中，将偏移量加到内存上
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; 第三次尝试
; 把0x7c00偏移量加到X对应的内存地址上
; 然后把加的结果放到指针上，输出
; 因为mov al, [ax]语句并非合法语句，我们需要找bx寄存器做存储
; 一个寄存器的地址不可以同时作为一条语句的输入地址和输出地址
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; 第四次尝试
; 因为我们知道，X在地址0x2d存储字符，我们可以提前做运算，
; 计算出0x7c00+0x2d=0x7c2d 为存放X的地址
; 减少查找地址的次数
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ;

the_secret:
    ; 在zero padding之前，存储ASCII 对应代码 0x58 ('X')
    db "X"

; 代码填充和告知BIOS这是boot sector
times 510-($-$$) db 0
dw 0xaa55
