.data
format_string:
	.string "%d"
fmt_char:
	.string "%c"
count:
	.space 4
sum:
	.space 4
pr:
	.string "\n"
array:
	.long 1, 2, 4, 8
array_end:
.text
print_easy:
	pushl %ecx
	pushl sum
	pushl $format_string
	call printf
	addl $8, %esp
	popl %ecx
	jmp finish
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	movl $8, %ecx
start:
	movl $12, count
	movl $0, sum
begin:
	pushl %ecx
	call getchar
	popl %ecx
	movl $array, %edx
	addl count, %edx
	movl (%edx), %ebx
#now the right array element is stored in %ebx	
	subb $48, %al
	cmpb $0, %al
	je end
	addl %ebx, sum
end:
	subl $4, count
	cmpl $0, count
	jge begin
	cmpl $10, sum
	jl print_easy
	subl $10, sum
	addl $65, sum
	pushl %ecx
	pushl sum
	pushl $fmt_char
	call printf
	addl $8, %esp
	popl %ecx
finish:
	decl %ecx
	cmpl $0, %ecx
	jg start
//epilog
	pushl $pr
	call printf
	addl $4, %esp
	movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
