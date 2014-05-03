.data
fmt_string:
	.string "%f"
array:
	.space 16
fmt_string_pr:
	.string "%f\n"
.text
#Description. This is a program that calculates the sum of a 4-elements array
sum:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	subl $12, %esp #In order to free some space for local variables
	movl $0x00000000, %eax
	movl %eax, -8(%ebp) #sum = 0.0;
	movl $0, -4(%ebp) #i = 0;
	jmp condition_check
general_loop:
	movl -4(%ebp), %eax #eax = i;
	sall $2, %eax #sizeof(float) == 4
	addl 8(%ebp), %eax 
	flds (%eax) #a[i]
	flds -8(%ebp) #s
	faddp %st, %st(1) #s = s + a[i];
	fstps -8(%ebp)
	addl $1, -4(%ebp) #i++;
condition_check:
	movl -4(%ebp), %eax
	cmpl 12(%ebp), %eax #i < n
	jl general_loop
	movl -8(%ebp), %eax #return s;
	movl %eax, -12(%ebp)
	flds -12(%ebp)
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Read input data section
	movl $0, %ecx # counter
begin:
	movl %ecx, %eax
	sall $2, %eax
	addl $array, %eax
	pushl %ecx
	pushl %eax
	pushl $fmt_string
	call scanf
	addl $8, %esp
	popl %ecx
	incl %ecx
	cmpl $4, %ecx
	jl begin
#main part of the program
	subl $20, %esp
	movl $4, 4(%esp)
	movl $array, (%esp)
	call sum
	fstpl 4(%esp)
	movl $fmt_string_pr, %eax
	movl %eax, (%esp)
	call printf
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
