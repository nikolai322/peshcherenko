.data
format_string:
	.string "%d"
int_label:
	.space 4
fmt_print:
	.string "\n"
.text
print_0:
	pushl $0
	pushl $format_string
	call printf
	jmp finish
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//read input data
	pushl $int_label
	pushl $format_string
	call scanf
	addl $8, %esp
//main program
	movl int_label, %eax
	movl $32, %ecx
	movl $0, %edx
shear:
	shll $1, %eax
	movl $0, %ebx
	jnb print
	incl %ebx
	movl $1, %edx
print:
	cmpl $1, %edx
	jne loop_end
	pushl %ecx
	pushl %eax
	pushl %edx
	pushl %ebx
	pushl $format_string
	call printf
	addl $8, %esp
	popl %edx
	popl %eax
	popl %ecx
loop_end:
	loop shear
	cmpl $1, %edx
	jne print_0
finish:
	pushl $fmt_print
	call printf
	addl $12, %esp
	
//epilog
	movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
