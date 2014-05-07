.data
x:
	.space 4
y:
	.space 4
z:
	.space 4
eps:
	.space 4
num:
	.space 4
fmt_float:
	.string "%f"
pr:
	.string "\n"
str_less:
	.string "z < 1\n"
str_eq:
	.string "z == 1\n"
sign:
	.space 4
.text
sign_adjust:
	movl $1, sign
	flds z
	fabs
	fstps z
	jmp go_on_1
change_sign:
	fld1
	fdivp %st, %st(1)
	jmp finish
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Read input data
	pushl $x
	pushl $fmt_float
	call scanf
	pushl $y
	pushl $fmt_float
	call scanf
	movl $0x3f800000, %eax
	movl %eax, eps #Now in esp is stored 1.00000001. It will be 
#used for comparison with 1
	flds y
	flds x #Now x is in st(0), y is in st(1)
	fyl2x
	fstps z
	flds eps #comparison with 0
	fld1
	fsubrp %st, %st(1)
	flds z	
	fxch %st(1)
	fucomip %st(1), %st
	fstp %st(0)
	seta %al
	testb %al, %al
	jne sign_adjust
	movl $0, sign #If sign == 0 then z > 0
go_on_1:
	movl $0, %ecx
	jmp begin
go_on:
	flds z
	fld1
	fsubrp %st, %st(1)
	fstps z # z = z - 1;
	incl %ecx
begin:
	flds z
	fld1
	fsubrp %st, %st(1)
	fabs
	flds eps
	fxch %st(1)
	fucomip %st(1), %st
	fstp %st(0)
	seta %al
	testb %al, %al
	jne go_on # If z > 1 then repeat (go_on)	
continue:
	flds z
	fld1
	fsubrp %st, %st(1)
	fstps z # z = z - 1;
	flds z
	f2xm1
	fld1
	faddp %st, %st(1)
	fstps z #z = (2^z - 1) + 1 
	movl %ecx, num
	incl num
	fild num
	fld1
	fscale
	flds z
	fmulp %st, %st(1)
	cmpl $0, sign
	jne change_sign
finish:	
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
