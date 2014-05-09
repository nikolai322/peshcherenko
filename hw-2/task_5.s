.data
sum:
	.space 4
.text
.globl sum1
sum1:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	movl $0, sum
start:
	movl (%ebx), %eax
	addl %eax, sum
	addl $4, %ebx
	loop start
	movl sum, %eax
#epilog
	movl %ebp, %esp
	popl %ebp
	ret	
.globl sum2
sum2:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	subl $4, %esp
	movl $0x00000000, %eax
	movl %eax, sum #sum = 0;
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
begin:
	movl %ebx, %eax
	flds (%eax)
	flds sum
	faddp %st, %st(1)
	fstps sum
	addl $4, %ebx
	loop begin
	movl sum, %eax
	movl %eax, -4(%ebp)
	flds -4(%ebp)
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
