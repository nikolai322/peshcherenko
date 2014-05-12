.data
numpos:
	.space 4
numneg:
	.space 4
count:
	.space 4
array:
	.space 20
a:
	.space 1
arr:#current position in array
	.space 4
fmt_int:
	.string "%d"
out:
	.string "%d\n"
.text
pos:
	incl numpos
	jmp continue
neg:
	incl numneg
	jmp continue
.globl main
.macro calc
	movl $0, count
	movl $0, numpos
	movl $0, numneg
begin:
	movl count, %eax
	cmpl $4, %eax
	jg end
	sall $2, %eax
	addl $array, %eax
	pushl %eax
	pushl $fmt_int
	call scanf
	addl $8, %esp
	movl count, %eax
	addl $1, %eax
	movl %eax, count
	jmp begin
end:
	movl $0, count
start:
	movl count, %eax
	cmpl $4, %eax
	jg finish
	sall $2, %eax
	addl $array, %eax
	cmpl $0, (%eax)
	jg pos
	jl neg
continue:
	movl count, %eax
	addl $1, %eax
	movl %eax, count
	jmp start	
finish:
	pushl numpos
	pushl $out
	call printf
	pushl numneg
	pushl $out
	call printf
.endm
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	calc
#epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
