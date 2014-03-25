.data
int_label:
	.space 4
char_label:
	.space 1
float_label:
	.space 4
double_label:
	.space 8
fmt_int:
	.string "%d"
fmt_char:
	.string "%c"
fmt_float:
	.string "%f"
fmt_double:
	.string "%lf"
pr:
	.string "\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp

//char
	pushl $char_label
	pushl $fmt_char
	call scanf
	movzbl	char_label, %eax
	movsbl	%al, %edx
	movl $fmt_char, %eax
	movl %edx, 4(%esp)
	movl %eax, (%esp)
	call printf
	pushl $pr
	call printf
//int
	pushl $int_label
	pushl $fmt_int
	call scanf
	pushl int_label
	pushl $fmt_int
	call printf
	pushl $pr
	call printf

//float
	pushl $float_label
	pushl $fmt_float
	call scanf
	flds float_label
	movl $fmt_float, %eax
	fstpl	4(%esp)
	movl %eax, (%esp)
	call printf
	pushl $pr
	call printf
//double
	pushl $double_label
	pushl $fmt_double
	call scanf
	fldl double_label
	movl $fmt_double, %eax
	fstpl	4(%esp)
	movl %eax, (%esp)
	call printf
	pushl $pr
	call printf

//epilog
  movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
