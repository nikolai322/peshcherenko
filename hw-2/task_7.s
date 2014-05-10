.data
buffer:
	.space 101
out:
	.space 101
error_str:
	.string "The error"
of_str:
	.string "There is too much of input data"
pr:
	.string "\n"
a:
	.space 4
count:
	.space 4
count_1:
	.space 4
num:
	.space 4
len_out:
	.space 4
max:
	.space 4
.text
overflow:
	pushl $of_str
	call printf
	jmp epilog
.globl main
command_1:
#prolog
	pushl %ebp
	movl %esp, %ebp
	movl $buffer, %ebx
	xorl %ecx, %ecx
#If the symbol is a non-zero digit then replace it with corresponding letter(1->a, 2->b)
begin:
	movl (%ebx), %eax
	cmpb $49, %al
	jl continue
	cmpb $58, %al
	jg continue
	addb $48, %al
	movl %eax, (%ebx)
continue:
	incl %ebx
	incl %ecx
	cmpl %ecx, num
	jg begin
#epilog
	movl %ebp, %esp
	popl %ebp
	ret	
command_2:
#prolog
	pushl %ebp
	movl %esp, %ebp
	movl $buffer, %ebx
	movl $1, count
	movl $out, %eax
	movl (%ebx), %ecx
	movl %ecx, (%eax)
	movl $1, len_out
	incl %ebx
start_3:
#Searching for repeating of a symbol
	movl $0, count_1
	movl $out, %eax
	movl (%ebx), %ecx
	movl %ecx, a
begin_3:
	movl (%eax), %ecx
	movl a, %edx
	cmpb %cl, %dl
	je exit
	incl %eax
	incl count_1
	movl count_1, %edx
	cmpl %edx, len_out
	jg begin_3
	movl a, %ecx
	movl %ecx, (%eax)
	incl len_out
#Here we wrote in out string only unrepeating symbols	
exit:
	incl %ebx
	incl count
	movl count, %eax
	cmpl num, %eax
	jl start_3
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
print:
#It obtains the pointer to the string and its length
#prolog
	pushl %ebp
	movl %esp, %ebp
	movl $0, count
	movl 12(%ebp), %ebx
#%ebx becomes the pointer to a string which we are trying to print 	
	movl 8(%ebp), %ecx
	movl %ecx, max
#max becomes the number of symbols in the string	
	movl %ebx, a
begin_1:
	pushl (%ebx)
	call putchar
	incl count
	movl a, %ebx
	incl %ebx
	movl %ebx, a
	movl max, %ecx
	cmpl count, %ecx
	jg begin_1
	pushl $pr
	call printf
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
#Read input data
	movl $buffer, %ebx
	movl $0, %ecx
start:
	movl %ebx, a
	pushl %ecx
	call getchar
	popl %ecx
	cmpb $10, %al #New line symbol
	je finish
	movl a, %ebx
	movl %eax, (%ebx)
	incl %ebx
	incl %ecx
	cmpl $100, %ecx
	jg overflow
	jmp start
finish:
	movl %ecx, num #num is the number of entered symbols
#Print input data
	movl num, %eax
	movl $buffer, %ebx
	pushl %ebx
	pushl %eax
	call print
#Check whether the first symbol is a digit
	movl $buffer, %ebx
	movl (%ebx), %edx
	cmpb $48, %dl
	jl error
	cmpb $58, %dl
	jg error
#Check whether the last symbol is a digit and isn't equal to the first one
	addl num, %ebx
	decl %ebx
	movl (%ebx), %eax
	cmpb $48, %al
	jl error
	cmpb $58, %al
	jg error
	cmpb %dl, %al
	je error
#This is the end of parsing the input string
	call command_1
#Print output data
	movl num, %eax
	movl $buffer, %ebx
	pushl %ebx
	pushl %eax
	call print
	jmp epilog
#In case input data does not correspond with the conditions
error:
	call command_2
#Print output data
	movl len_out, %eax
	movl $out, %ebx
	pushl %ebx
	pushl %eax
	call print
epilog:
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
