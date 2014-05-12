.data
x:
	.space 4
y:
	.space 4
z:
	.space 4
t:
	.space 4
fmt_float:
	.string "%f"
pr:
	.string "\n"
.text
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	pushl $x
	pushl $fmt_float
	call scanf
	pushl $y
	pushl $fmt_float
	call scanf
	flds x
	flds y
	faddp
	fstps z# z = x + y;
	fld1
	flds z
	fyl2x
	fstps t # t = log2(x+y)
	fldl2t
	flds t
	fdivp %st, %st(1)
	flds t
	faddp
#print
	movl $fmt_float, %eax
	fstpl 4(%esp)
	movl %eax, (%esp)
	call printf
	pushl $pr
	call printf
#epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
