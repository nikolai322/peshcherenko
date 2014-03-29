.data
long_double:
	.space 10
fmt_string:
	.string "%d"
fmt_long_double:
	.string "%Lf"
pr:
	.string "\n"
.text
adjust:
	movl $2, %eax
	addl $long_double, %eax
	movl (%eax), %ebx
	movl %ebx, %eax
	jmp continue
adjust_1:
	movl $long_double, %eax
	movl (%eax), %ebx
	movl %ebx, %eax
	jmp continue
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl $long_double
	pushl $fmt_long_double
	call scanf
	addl $8, %esp
	movl $6, %eax
	addl $long_double, %eax
	movl (%eax), %ebx
	movl %ebx, %eax
	movl $80, %ecx
shear:
	cmpl $48, %ecx
	je adjust
	cmpl $16, %ecx
	je adjust_1
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
//epilog
	pushl $pr
	call printf
	addl $4, %esp
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
