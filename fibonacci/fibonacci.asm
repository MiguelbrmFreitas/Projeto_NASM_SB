;fibonacci

%include "asm_io.inc"

%macro fibonacci 1
	mov ecx, %1
	cmp ecx, 2 			;caso termo <= 2

	ja %%fibo			;caso termo >= 3

	mov eax, 1			;caso termo = (0 ou 1)
	jne	%%fim

	mov eax, 1			;caso termo = 2
	jmp %%fim

	%%fibo:
		push ebx		;salva ebx

		sub ecx, 2		;calcula fibo a partir do termo 3

		mov ebx, 1
		mov eax, 1

	%%proximo:
		xchg eax, ebx
		add eax, ebx

		sub ecx, 1
		cmp ecx, 0
		jnz %%proximo

	pop ebx
	%%fim:
%endmacro

section .dat
newline 		db "", 0xa, 0

segment .bss

segment .text

global  main
	main:
		enter	0,0
		pusha

fibonacci 7

call print_int
mov eax, newline
call print_string

popa
mov	eax, 0
leave
ret
