%include "asm_io.inc"

%macro loop 0
	%push inicio
	%$inicioLoop:
%endmacro

%macro endloop 1
	cmp %1,0
	jnz %$inicioLoop 	                 
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

mov ecx, 10 ;Número de iterações

loop
	mov eax, ecx
	call print_int
	mov eax, newline
	call print_string
	sub ecx, 1
endloop ecx

popa
mov	eax, 0
leave
ret
