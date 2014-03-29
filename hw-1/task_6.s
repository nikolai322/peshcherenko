.data
double_label:
	.space 8
fmt_string:
	.string "%d"
fmt_double:
	.string "%lf"
pr:
	.string "\n"
.text
adjust:
	movl $double_label, %eax
	movl (%eax), %ebx
	movl %ebx, %eax
	jmp continue
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl $double_label
	pushl $fmt_double
	call scanf
	addl $12, %esp	
	movl $4, %eax
	addl $double_label, %eax
	movl (%eax), %ebx
	movl %ebx, %eax
	movl $64, %ecx
shear:
	cmpl $32, %ecx
	je adjust
continue:
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
	movl double_label, %eax
	movl $32, %ecx
//epilog
	pushl $pr
	call printf
	addl $4, %esp
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
