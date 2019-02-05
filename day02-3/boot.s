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
  movb $0x0e, %ah
  movw $15, %bx
  int $0x10
  jmp putloop

fin:
  hlt
  jmp fin

msg:
  .string "\n\nhello, world\n"

  .org 0x1fe
  .byte 0x55, 0xaa
