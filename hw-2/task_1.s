.data
int:
	.space 4
fmt_int:
	.string "%d"
fmt_not:
	.string "not=%d\n"
fmt_shear:
	.string "shear=%d\n"
fmt_signed:
	.string "signed\n"
fmt_unsigned:
	.string "unsigned\n"
.text
signed:
	pushl $fmt_signed
	call printf
	jmp continue
unsigned:
	pushl $fmt_unsigned
	call printf
	jmp continue
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
#main program
#read the first number
	pushl $int
	pushl $fmt_int
	call scanf
	movl int, %eax
	pushl %eax
#read the second number
	pushl $int	
	pushl $fmt_int
	call scanf
	popl %eax
	movl int, %ebx
#test command usage
	testl %ebx, %ebx
	js signed
	jmp unsigned
continue:
#not command usage
	notl %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_not
	call printf
	popl %eax
	movl int, %ebx
#shear logical left command usage
	shll $2, %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_shear
	call printf
	popl %eax
	movl int, %ebx	
//epilog
	movl %ebp, %esp
	popl %ebp
	movl $0, %eax
	ret
