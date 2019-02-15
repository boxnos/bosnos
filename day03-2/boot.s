    .code16

    jmp entry
    .byte 0x90

    .ascii "HELLOIPL"
    .word 512
    .byte 1
    .word 1
    .byte 2
    .word 224
    .word 2880
    .byte 0xf0
    .word 9
    .word 18
    .word 2

    .long 0
    .long 2880
    .byte 0x00, 0x00, 0x29
    .long 0xffffffff
    .ascii "BOXNOS     "
    .ascii "FAT12   "
    .skip 18
#  . = . + 18

entry:
    mov $12345, %di
    call outl

    movw $0, %ax
    movw %ax, %ss
    movw $0x7c00, %sp
    movw %ax, %ds
    movw %ax, %es

#read floppy
    mov $0x820, %ax
    mov %ax, %es
    mov $0, %ch
    mov $0, %dh
    mov $2, %cl

    mov $5, %si
retry:
    mov $0x02, %ah
    mov $1, %al
    mov $0, %bx
    mov $0x00, %dl
    int $0x13
    jnc fin
    sub $1, %si
    cmp $0, %si
    je error

    mov $0, %ah
    mov $0, %dl
    int $13
    jmp retry

# finish to read

fin:
    movw $msg, %si
    call puts
fin_loop:
    hlt
    jmp fin_loop

# %si: string address
puts:
    movb (%si), %al
    add $1, %si
    cmp $0, %al
    je puts_end
    call putchar
    jmp puts
puts_end:
    mov $'\r', %al
    call putchar
    mov $'\n', %al
    call putchar
    ret

# %al: char
putchar:
    movb $0x0e, %ah
    movw $15, %bx
    int $0x10
    ret

error:
    mov $read_error_message, %si
    call puts
    jmp fin_loop

read_error_message:
    .string "BOOT: read error."
msg:
    .string "BOOT: [OK]"

# for debug

# %di: int
outl:
    call out
    mov $'\r', %al
    call putchar
    mov $'\n', %al
    call putchar
    ret

# %di: int
out:
    mov $buf, %si
out_loop:
    cmp $0, %di
    je out_put
    mov $0, %dx
    mov %di, %ax
    mov $10, %bx
    div %bx
    mov %ax, %di
    add $'0', %dx
    mov %dx, (%si)
    add $1, %si
    jmp out_loop
out_put:
    sub $1, %si
    mov (%si), %al
    call putchar
    cmp $buf, %si
    je out_end
    jmp out_put
out_end:
    ret
buf:
    .string "0000000000000"


    .org 0x1fe
    .byte 0x55, 0xaa
