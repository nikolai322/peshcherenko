.data
msg_string1:
	.string	"Call_1\n"
	.text
	.globl	main
msg_string2:
	.string	"Call_2\n"
	.text
	.globl	main

my_printf:
pushl $msg_string1
call printf
addl	$4, %esp
pushl $msg_string2
call printf
addl	$4, %esp
ret


main:
pushl %ebp
movl %esp, %ebp
call my_printf
movl	%ebp, %esp
popl	%ebp
ret
