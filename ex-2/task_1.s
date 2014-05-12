.data
str_1:
	.space 100
str_2:
	.space 100
fmt_str:
	.string "%s"
fmt_int:
	.string "%d\n"
int:
	.space 4
len_2:
	.space 4
len_1:
	.space 4
num:
	.space 4
str_ptr:
	.space 4
unsuccess:
	.string "not found\n"
.text
not_found:
	pushl $unsuccess
	call printf
	jmp epilog
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	pushl $str_1
	pushl $fmt_str
	call scanf
	pushl $str_2
	pushl $fmt_str
	call scanf
	movl $str_1, %edi
	movl $0xffffffff, %ecx
	xorl %eax, %eax 
	repne scasb
	notl %ecx
	decl %ecx
	movl %ecx, len_1
	movl $str_2, %edi
	movl $0xffffffff, %ecx
	xorl %eax, %eax 
	repne scasb
	notl %ecx
	decl %ecx
	movl %ecx, len_2
	movl $100, %ecx
	movl $str_1, %edi
	movl %edi, str_ptr
start:
	movl $str_2, %eax
	movl (%eax), %eax
	repne scasb
	movl $100, %eax
	subl %ecx, %eax
	movl %eax, %ecx
	cmpl $0, %ecx
	je not_found
	decl %ecx
#Now in %ecx is stored the number of first matched symbol
	movl %ecx, int
	movl $str_ptr, %eax
	addl %ecx, %eax
	movl $str_1, %ebx
	addl len_1, %ebx
#Mind that len_1 - %ecx >= len_2
	subl %eax, %ebx
	cmpl len_2, %ebx
	jl not_found
	movl len_2, %ecx
#Now in %ecx is stored len_2
continue:
	movl $str_2, %edi
	repe cmpsb
	cmpl $0, %ecx
	je finish
/*	incl %ecx
	movl len_2, %eax
	subl %ecx, %eax
	decl %esi
	movl $str_1, %eax
	addl len_1, %eax
	subl %eax, %esi
#Mind that the remaining of len_1 >= len_2
	movl len_2, %eax
#Prepairing for the new loop
	movl $str_1, %eax
	addl int, %eax
	cmpl %ebx, %eax

	jg start*/
	movl %esi, str_ptr
	jmp start	
finish:
	pushl int
	pushl $fmt_int
	call printf
epilog:
  movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
