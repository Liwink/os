; boot.s --Kernel start location.
; Also defines multiboot header.

; Multiboot Magic value. This identifies the kernel as multiboot-compatible.
MBOOT_HEADER_MAGIC  equ     0x1BADB002
; Load kernel and modules on a page boundary
MBOOT_PAGE_ALIGN    equ     1 << 0
; Provide your kernel with memory info
MBOOT_MEM_INFO      equ     1 << 1
; pass us a symbol table.
MBOOT_HEADER_FLAGS  equ     MBOOT_PAGE_ALIGN | MBOOT_MEM_INFO

MBOOT_CHECKSUM      equ     -(MBOOT_HEADER_MAGIC+MBOOT_HEADER_FLAGS)

; All instructions should be 32-bits
[BITS 32]
section .text

dd MBOOT_HEADER_MAGIC
dd MBOOT_HEADER_FLAGS
dd MBOOT_CHECKSUM

[GLOBAL start]
[GLOBAL glb_mboot_ptr]
[EXTERN kern_entry]

start:
    cli
    mov esp. STACK_TOP
    mov ebp. 0
    and esp. 0FFFFFFF0H
    mov [glb_mboot_ptr]. ebx
    call kern_entry
stop:
    hlt
    jmp stop

section .bss
stack:
    resb 32768
glb_mboot_ptr:
    resb 4

STACK_TOP equ $-stack-1
