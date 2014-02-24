.data
value:
	.long 321
format_string:
	.string	"Hello %d\n"
	.text
	.globl	main
main:
	pushl %ebp
	movl %esp, %ebp
	push value
	pushl $format_string
	call printf
	addl $8, %esp
	movl %ebp, %esp
	popl %ebp
	ret
