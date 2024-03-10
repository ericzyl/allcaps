@ Describe the hardware to the assembler1~
      .arch   armv6
      .cpu    cortex-a53
      .syntax unified

@ Declare any external functions
      .extern putchar
      .extern printf
      .global main

@ Define any constants
      .equ    FP_OFFSET, 4
      .equ    LC_A, 0x61
      .equ    LC_Z, 0x7a
      .equ    NULL, 0x0
      .equ    EXIT_SUCCESS, 0

@ Start data segment where you will define your string
      .data
mesg: .asciz "Hello World!"

@ Start text segment and begin writing your function
      .text
      .type   main, %function
main: push  {fp, lr}
      add   fp, sp, FP_OFFSET
      //mov   r1, 0
      ldr   r4, =mesg
      ldrb  r0, [r4]
      cmp   r0, NULL
      beq   done
loop:
      cmp r0, LC_A
      blt next
      cmp r0, LC_Z
      bgt next
      sub r0, 32

next:
      bl putchar
      add r4, r4, 1
      ldrb r0, [r4]
      cmp r0, NULL
      bne loop

done:
      mov r0, EXIT_SUCCESS
      sub sp, fp, FP_OFFSET
      pop {fp, lr}
      bx  lr
.end
