.data
s:
	.space 50
len:
	.space 4
count:
	.space 4
fmt_string:
	.string "%d"
fmt_str:
	.string "%s"
n:
	.long 8
.text
print_0:
	pushl %ecx
	pushl $0
	pushl $fmt_string
	call printf
	addl $4, %esp
	popl %ecx
	jmp continue
print_1:
	pushl %ecx
	pushl $1
	pushl $fmt_string
	call printf
	addl $4, %esp
	popl %ecx
	jmp continue
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
#main program
	pushl $s
	pushl $fmt_str
	call scanf
	movl $s, (%esp)
	call strlen
	movl %eax, len
	movl len, %eax
	movl $8, count
	idivl count
	movl $7, count
	movl %eax, %ecx
begin:
start:
	movl $0, %eax
	cmpl %eax, count
	jl finish
	movl count, %eax
	movzbl s(%eax), %eax
	cmpb $48, %al
	je print_0
	cmpb $49, %al
	je print_1
continue:
	movl count, %eax
	decl %eax
	movl %eax, count
	jmp start
finish:
	loop begin
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
