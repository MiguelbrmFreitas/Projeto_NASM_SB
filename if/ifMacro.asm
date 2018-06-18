%include "asm_io.inc"

%macro ifMacro 1
	cmp %1,1
	je %$true
	jmp %$false
	%$true:
		mov eax, msgTrue
		call print_string
		mov eax, newline
		call print_string
	%$false:
		mov eax, msgFalse
		call print_string
		mov eax, newline
		call print_string
%endmacro


section .dat
newline 	db "", 0xa, 0
msgTrue		db "True", 0
msgFalse	db "False", 0

segment .bss

segment .text
  global  main
	main:
		enter	0,0
		pusha

mov ecx, 1 ;True
;mov ecx, 0 ;False

ifMacro ecx

popa
mov	eax, 0
leave
ret