%include "asm_io.inc"

%macro if 1
	%push if
	jne %$ifnot
%endmacro
%macro else 0
	%ifctx if
		%repl else
		jmp %$ifend
		%$ifnot:
	%else
		%error "expected ‘if’ before ‘else’"
	%endif
%endmacro
%macro endif 0
	%ifctx if
		%$ifnot:
		%pop
	%elifctx else
		%$ifend:
		%pop
	%else
		%error "expected ‘if’ or ‘else’ before ‘endif’"
	%endif
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

;mov ecx, 1 ;True
mov ecx, 0 ;False

cmp ecx,1
if e
	mov eax, msgTrue
	call print_string
	mov eax, newline
	call print_string
else
	mov eax, msgFalse
	call print_string
	mov eax, newline
	call print_string
endif

popa
mov	eax, 0
leave
ret