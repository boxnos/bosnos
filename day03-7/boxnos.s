# black out
    mov $13, %al
    mov $0x00, %ah
    int $0x10
fin:
    hlt
    jmp fin
