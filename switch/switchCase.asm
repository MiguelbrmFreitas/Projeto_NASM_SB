%include "asm_io.inc"
extern _printf

; Descrição:	
; 	Macro que simula a parte Switch do bloco Switch Case
; Parâmetro:
; 	valor que será comparado aos valores dos casos
%macro switch 1
	%push switch                    ;cria a pilha contexto e insere o contexto switch 
	%assign %$caso 1                ;label que servira para identificar cada caso
	mov eax, dword %1        	  	;eax recebe o parâmetro
%endmacro


; Descrição:	
; 	Macro que simula a parte Case do bloco Switch Case
; Parâmetro:
; 	valor que será comparado ao valor passado para a macro switch
%macro case 1
	%ifctx switch                     ;verifica se o contexto existe
		%$proximo%$caso:
		%assign %$caso %$caso+1       ;incrementa o valor para o proximo caso
		cmp eax, %1                   ;compara o valor do caso com o valor do switch
		jne %$proximo%$caso           ;se não for igual vai para o proximo caso
	%endif
%endmacro


; Descrição:	
; 	Macro que simula a parte Default do bloco Switch Case
; Não recebe parâmetros
%macro default 0
	%ifctx switch                 ;verifica se o contexto existe 
		%define __default           ;define o o caso default
		%$proximo%$caso:			;chama um proximo caso, que seria o default
	%endif 
%endmacro


; Descrição:	
; 	Macro que simula a parte Break do bloco Switch Case - encerra a execucão do bloco
; Não recebe parâmetros
%macro break 0
	%ifctx switch                 ;verifica se o contexto existe
		jmp %$fimSwitch             ;vai para a "rotina" que encerra o switch
	%endif 
%endmacro


; Descrição:	
; 	Macro que encerra o bloco Switch Case
; Não recebe parâmetros
%macro encerraSwitch 0
	%ifctx switch                ;verifica se o contexto existe
		%$fimSwitch:               ;"rotina" chamada pelo break
		%ifndef __default          ;testa se chegou no default - se default foi definido 
			%$proximo%$caso:         ;se não foi definido então encerraSwitch é o proximo caso
		%endif
		%undef __default           ;desfaz a definição do default
		%pop switch                ;retira o contexto da pilha de contexto
	%endif
%endmacro


section .data 
	opcao 		dd 2
	msg 		db "Valor do armazenado no label opcao eh igual a %lu.", 10, 0
	teste1  	equ 1
	teste2 		equ 2
	teste3 		equ 3
	teste4 		equ 4
	msgDefault	db	"Valor armazenado em opcao nao corresponde a nenhum caso.", 10, 0

section .text
global _switchCase
_switchCase:
	enter 4,0
	pusha
	switch [opcao]          
		case teste1
			push dword teste1
			push msg
			call _printf
			add esp, 8
			break
		case teste2          
			push dword teste2
			push msg
			call _printf
			add esp, 8 
			break
		case  teste3 
			push dword teste3
			push msg
			call _printf
			add esp, 8
			break
		case  teste4 
			push dword teste4
			push msg
			call _printf
			add esp, 8
			break
		default
			push msgDefault
			call _printf
			add esp, 8
			break
	encerraSwitch

	popa
	leave 
	ret
