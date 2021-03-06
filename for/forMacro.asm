; Autor: Miguel Barreto Rezende Marques de Freitas

%include "asm_io.inc"

%macro inicializar 1
	%push inicializar
	mov ecx, %1
	%pop
%endmacro

%macro loop 2
	%push loop
	cmp %1,%2
	jz $%saiLoop
	jnz corpoLoop 
%endmacro

%macro saiLoop 0
	%$saiLoop:
	%pop
%endmacro

%macro incrementar 1
	%push incrementar
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

inicializar 0

labelLoop:
	loop ecx, 10 ; realiza o loop 10 vezes
		corpoLoop:
			mov eax, ecx
			call print_int
			mov eax, newline
			call print_string
			incrementar ecx
			jmp labelLoop
			saiLoop

popa
mov	eax, 0
leave
ret
