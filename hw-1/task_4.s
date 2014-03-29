.data
fmt_string:
	.string "%d"
pr:
	.string "\n"
.text
letter:
	subb $65, %al
	addb $10, %al
	jmp continue 
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	movl $0, %eax
start:
	call getchar	
	cmpb $32, %al
	je finish
	
	cmpb $65, %al
	jge letter
	subb $48, %al
continue:
	movl $8, %ecx
shear:
	shlb $1, %al
	movl $0, %ebx
	jnb print
	incl %ebx
print:
	cmpl $4, %ecx
	jg loop_end
	pushl %eax
	pushl %ecx
	pushl %ebx
	pushl $fmt_string
	call printf
	addl $8, %esp
	popl %ecx
	popl %eax
loop_end:
	loop shear
	jmp start
finish:
epilog:
	pushl $pr
	call printf
	addl $4, %esp
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
