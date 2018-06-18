%include "asm_io.inc"

%macro inicio 1
	mov ecx, %1
	%pop
%endmacro

%macro loop 1
	%push inicio
	%$inicioLoop:
	cmp %1,0
	jnz %$inicioLoop
	%push sai_loop
	%pop
%endmacro

%macro incrementar 1
	inc %1
	%pop
%endmacro

section .dat
newline 		db "", 0xa, 0

segment .bss

segment .text
  global  main
	main:
		enter	0,0
		pusha

inicio 10 ;Número de iterações
loop ecx
	mov eax, ecx
	call print_int
	mov eax, newline
	call print_string
	sub ecx, 1
	incrementar

popa
mov	eax, 0
leave
ret
