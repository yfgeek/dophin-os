[bits 16]
switch_to_pm:
    cli ; 1. 禁用中断
    lgdt [gdt_descriptor] ; 2. 加载 GDT descriptor
    mov eax, cr0
    or eax, 0x1 ; 3. 在cr0中设置32位模式
    mov cr0, eax
    jmp CODE_SEG:init_pm ; 4. 跳到init_pm

[bits 32]
init_pm:
    mov ax, DATA_SEG ; 5. 更新寄存器中的数据段
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; 6. 在空闲空间的顶部更新堆栈
    mov esp, ebp

    call BEGIN_PM ; 7. 调用BEGIN_PM
