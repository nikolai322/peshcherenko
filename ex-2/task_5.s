.data
str:
	.space 100
str_out:
	.space 100
p:
	.space 4
i:
	.space 4
len:
	.space 4
fmt_str:
	.string "%s"
fmt_int:
	.string "%d"
.text
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	pushl $str
	pushl $fmt_str
	call scanf
	pushl $p
	pushl $fmt_int
	call scanf
	pushl $i
	pushl $fmt_int
	call scanf
	movl $str, %eax
	movl $str_out, %ebx
	movl p, %ecx
	decl %ecx
start:
	movl (%eax), %edx
	movl %edx, (%ebx)
	incl %eax
	incl %ebx
	loop start
	movl i, %ecx
	decl %ecx
begin:
	incl %eax
	loop begin
#strlen(str)
	movl $str, %edi
	movl $0xffffffff, %ecx
	xorl %eax, %eax 
	repne scasb
	notl %ecx
	decl %ecx
	movl %ecx, len
	subl i, %ecx
	subl p, %ecx 
	incl %ecx
commencement:
	movl (%eax), %edx
	movl %edx, (%ebx)
	incl %eax
	incl %ebx
	loop commencement
	pushl $str_out
	pushl $fmt_str
	call printf
#epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
