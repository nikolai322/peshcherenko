.data
count:
	.space 4
a:
	.space 30
print:
	.string "%d"
min:
	.space 4
pr:
	.string "\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
	movl $0, count
//read input data
begin:
	movl count, %eax
	cmpl $5, %eax
	jg end
	sall $2, %eax
	#leal a(%eax), %edx
	addl $a, %eax
	pushl %eax
	pushl $print
	call scanf
	addl $8, %esp
	movl count, %eax
	addl $1, %eax
	movl %eax, count
	jmp begin
end:
//main program
	movl a, %eax
	movl %eax, min
	movl $0, count
loop_start:
	movl count, %eax
	sall $2, %eax
	addl $a, %eax
	movl (%eax), %edx
	movl %edx, %eax
	movl min, %ebx
	cmpl %eax, %ebx
	jle more
	movl %eax, min
more:
	incl count
	cmpl $6, count
	je loop_end
	jmp loop_start
loop_end:
	pushl min
	pushl $print
	call printf
	addl $8, %esp
	pushl $pr
	call printf
	addl $4, %esp
//epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
