.data
fmt_string:
	.string "%s"
fmt_print:
	.string "%s\n"
str_1:
	.space 5
str_2:
	.space 5

.text
less:
	
more:
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
#main program
	pushl $str_1
	pushl $fmt_string
	call scanf
	movl $str_1, %esi
	movl $str_2, %edi
	movl $4, %ecx
1:
	lodsb
	incb %al
	stosb
	loop 1b
	movsb 
	pushl $str_1_out
	pushl $fmt_print
	call printf
#strcmp
	movl $str_1, %esi
	movl $str_2, %edi
	movl $4, %ecx	
	cld
	repe cmpsb
	cmpl $0, %ecx
	
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
