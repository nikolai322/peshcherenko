.data
int:
	.space 4
fmt_int:
	.string "%d"
fmt_and:
	.string "and=%d\n"
fmt_or:
	.string "or=%d\n"
fmt_xor:
	.string "xor=%d\n"
fmt_not:
	.string "not=%d\n"
fmt_shear:
	.string "shear=%d\n"
fmt_equal:
	.string "equal\n"
fmt_not_equal:
	.string "not_equal\n"
.text
equal:
	pushl $fmt_equal
	call printf
	jmp continue
not_equal:
	pushl $fmt_not_equal
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
#and command usage
	andl %eax, %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_and
	call printf
	popl %eax
	movl int, %ebx
#or command usage
	orl %eax, %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_or
	call printf
	popl %eax
	movl int, %ebx
#xor command usage
	xorl %eax, %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_xor
	call printf
	popl %eax
	movl int, %ebx
#not command usage
	notl %ebx
	pushl %eax
	pushl %ebx
	pushl $fmt_not
	call printf
	popl %eax
	movl int, %ebx
#test command usage
	testl %eax, %ebx
	jne equal
	jmp not_equal
continue:
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
