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
      call out

      movw $0, %ax
      movw %ax, %ss
      movw $0x7c00, %sp
      movw %ax, %ds
      movw %ax, %es
      movw $msg, %si

# .byte 0x8e, 0xd8, 0x8e

putloop:
    movb (%si), %al
    add $1, %si
    cmp $0, %al
    je fin
    call putchar
    jmp putloop

putchar:
    movb $0x0e, %ah
    movw $15, %bx
    int $0x10
    ret

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
    mov %dx, %ax
    add $'0', %ax
    mov %al, (%si)
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

fin:
    hlt
    jmp fin

buf:
    .string "0000000000000"
msg:
    .string "\n\nhello, world\n"

    .org 0x1fe
    .byte 0x55, 0xaa
