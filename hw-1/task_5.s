.data
float_label:
	.space 4
fmt_string:
	.string "%d"
fmt_float:
	.string "%f"
pr:
	.string "\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl $float_label
	pushl $fmt_float
	call scanf
	movl float_label, %eax
	movl $32, %ecx
shear:
	shll $1, %eax
	movl $0, %ebx
	jnb print
	incl %ebx
print:
	pushl %ecx
	pushl %eax
	pushl %ebx
	pushl $fmt_string
	call printf
	addl $8, %esp
	popl %eax
	popl %ecx
	loop shear
//epilog
	pushl $pr
	call printf
	addl $4, %esp
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
