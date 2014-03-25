.data
int_label1:
	.space 4
int_label2:
	.space 4
format_string:
	.string "%d"
format_string_sum:
	.string "sum=%d\n"
format_string_sub:
	.string "sub=%d\n"
format_string_mul:
	.string "mul=%d\n"
format_string_div:
	.string "div=%d\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//read input data
	pushl $int_label1
	pushl $format_string
	call scanf
	addl $8, %esp
	pushl $int_label2
	pushl $format_string
	call scanf
	addl $8, %esp
//sum
	movl int_label1, %eax
	addl int_label2, %eax
	pushl %eax
	pushl $format_string_sum
	call printf
	addl $8, %esp
//sub
	movl int_label1, %eax
	subl int_label2, %eax
	pushl %eax
	pushl $format_string_sub
	call printf
	addl $8, %esp
//mul
	movl int_label1, %eax
	mull int_label2
	pushl %eax
	pushl $format_string_mul
	call printf
	addl $8, %esp
//idivl
	movl int_label1, %eax
	idivl int_label2
	pushl %eax
	pushl $format_string_div
	call printf
	addl $8, %esp
//epilog
  movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
