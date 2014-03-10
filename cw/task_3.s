.data
.text
.globl my_sum
my_sum:
	pushl %ebp
	movl %esp, %ebp

	pushl %ebx
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	addl %eax, %ebx
	movl %ebx, %eax
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
.globl my_sub
my_sub:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	subl %eax, %ebx
	movl %ebx, %eax
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
.globl my_mul
my_mul:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	mull %ebx
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
.globl my_div
my_div:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	sarl $31, %edx
	idivl %ebx
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
.globl my_inc
my_inc:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	movl 8(%ebp), %eax
	incl %eax
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
.globl my_dec
my_dec:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	movl 8(%ebp), %eax
	decl %eax
	popl %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
