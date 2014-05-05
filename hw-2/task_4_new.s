.data
x:
	.space 4
y:
	.space 4
fmt_float:
	.string "%f"
pr:
	.string "\n"
str_less:
	.string "z < 1\n"
str_eq:
	.string "z == 1\n"
.text
go_on:
	fxch
	fsubp
	fld1
	jmp start
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#float
	pushl $x
	pushl $fmt_float
	call scanf
	pushl $y
	pushl $fmt_float
	call scanf
	flds y
	flds x #Now x is in st(0), y is in st(1)
	fyl2x
start:
	fst %st(1)
	fld1
	fucomip %st(1), %st
	fstp %st(0)
	seta %al
	testb %al, %al
	je go_on #In case 1 <= z
continue:
	fincstp
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
