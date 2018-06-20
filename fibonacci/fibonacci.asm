;fibonacci

%include "asm_io.inc"

%macro fibonacci 1
	mov ecx, %1			;coloca em ecx valor do termo de fibonacci
	cmp ecx, 0
	jl  %%fim_err

	cmp ecx, 2 			;caso termo <= 2

	ja %%fibo			;caso termo >= 3

	mov eax, 1			;caso termo = (0 ou 1)
	jne	%%fim

	mov eax, 1			;caso termo = 2
	jmp %%fim

	%%fibo:
		push ebx		;salva ebx

		sub ecx, 2		;calcula fibo a partir do termo 3

		mov ebx, 1		;inicializa sequencia fib(1) = 1
		mov eax, 1		;inicializa sequencia fib(2) = 1

	%%proximo:
		xchg eax, ebx	;passa sequencia para o proximo
		add eax, ebx	;soma termo anterior e corrente

		sub ecx, 1		;subtrai contador de termos
		cmp ecx, 0		;caso termo encontrado termina
		jnz %%proximo	;senao calcula proximo

	pop ebx				;volta registrador utilizado
	jmp %%fim

	%%fim_err:
		mov eax, -1
	%%fim:

%endmacro

section .dat
newline 		db "", 0xa, 0
err_msg			db "numero invalido...", 0xa, 0

segment .bss

segment .text

global  main
	main:
		enter	0,0
		pusha

fibonacci 7

cmp eax, -1
jne fim_fibo
	mov eax, err_msg
	call print_string
	mov eax, newline
	call print_string
	jmp fim

fim_fibo:
	call print_int
	mov eax, newline
	call print_string

fim:
popa
mov	eax, 0
leave
ret
