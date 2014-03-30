.data
fmt_int:
	.string "%d"
fmt_int_out:
	.string "%d\n"
fmt_float:
	.string "%f"
fmt_float_out:
	.string "%f\n"
fmt_double:	
	.string "%lf"
fmt_double_out:
	.string "%lf\n"

.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
#main program
	andl $-16, %esp
	subl $48, %esp
#char
	call getchar
	movb %al, 47(%esp)
	movsbl 47(%esp), %eax
	movl %eax, (%esp)
	call putchar
#int
	movl $fmt_int, %eax
	leal 36(%esp), %edx
	movl %edx, 4(%esp)
	movl %eax, (%esp)
	call scanf
	movl 36(%esp), %edx
	movl $fmt_int_out, %eax
	movl %edx, 4(%esp)
	movl %eax, (%esp)
	call printf
#float
	movl $fmt_float, %eax
	leal 40(%esp), %edx
	movl %edx, 4(%esp)
	movl %eax, (%esp)
	call scanf
	flds 40(%esp)
	movl $fmt_float_out, %eax
	fstpl 4(%esp)
	movl %eax, (%esp)
	call printf
#double
	movl $fmt_double, %eax
	leal 24(%esp), %edx
	movl %edx, 4(%esp)
	movl %eax, (%esp)
	call scanf
	fldl 24(%esp)
	movl $fmt_double_out, %eax
	fstpl 4(%esp)
	movl %eax, (%esp)
	call printf
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
