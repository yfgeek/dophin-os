[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; offset

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print
call print_nl

call load_kernel ; 从硬盘加载内核
call switch_to_pm ; 禁用中断，加载GDT，结束后跳转到BEGIN_PM
jmp $ ; 此处永远不会被执行

%include "boot/print.asm"
%include "boot/print_hex.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/32bit_print.asm"
%include "boot/switch_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; 设置在读取或写操作从 KERNEL_OFFSET 0x1000开始
    mov dh, 16 ;
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ;
    jmp $ ;


BOOT_DRIVE db 0 ;
MSG_REAL_MODE db    "16-bit Real Mode........OK", 0
MSG_PROT_MODE db    "32-bit Protected Mode...OK", 0
MSG_LOAD_KERNEL db  "Loading kernel............", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55
