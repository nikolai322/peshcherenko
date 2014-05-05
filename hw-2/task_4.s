.data
x:
	.space 4
y:
	.space 4
sign:
	.space 4
one:
	.space 4
num:
	.space 4

fmt_float:
	.string "%f"
pr:
	.string "\n"
err_str:
	.string "The error while reading input data has occured. Please try again\n"
.text
error:
	pushl $err_str
	call printf
	addl $8, %esp
	jmp epilog
zero_check:
	cmpl $0, %ebx
	je error
	jmp continue
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
	addl $16, %esp
#And here goes magic
#Parsing all possible errors in input data
	movl x, %eax
	movl y, %ebx
	cmpl $0, %eax
	jl error
	je zero_check
#the main part of this program
continue:
	movl $0, sign
go_on:
	fldl y
	fldl x #Now x is in st(0), y is in st(1)
	ftst #compares x with 0
	fstsw %ax
	sahf
	jnc m1 #if (x > 0) goto m1
	incl sign
	fabs #y = fabs(y);
m1:
	fxch #swap(y,x)
	fyl2x #st(0) = y*log2(x) == z
	fst %st(1) #Stores z in st(1)
	fabs
	fld1 #pushl $1
	fcom #Here we compare z with 1
	fstsw %ax
	sahf
	jnc m2 #if (z < 1) goto m2
	jz m3 #if (z == 1) goto m3
	xor %ecx, %ecx #counter = 0
m12:
	incl %ecx #counter++
	fsub %st, %st(1) #z = z - 1
	fcom #Comparison between z and 1
	fstsw %ax
	sahf
	jz m12 # in case z==1
	jnc m2 # in case z < 1
	jmp m12 # in case z > 1
m3:
	movl $1, num
	jmp if_1
m2:
	movl %ecx, num
	fxch #swap(1,z); now in st(0) is 1, in st(1) is z
	f2xm1 #calculates 2^z - 1
	faddp # calculates 1 + 2^z - 1 = 2^z
	fild num #pushl $num; In st(0) is now stored num
if_1:
	fld1 #pushl $1 #In st(0) is now stored 1, in st(1) is stored num
	fscale #Now in st(0) is stored 2^num
	fxch 
	fincstp #It increments stack pointer
#Now in st(0) is stored 2^num and 2^z
	fmulp # It multiplies 2^num and 2^z
#check for the sign of y
	cmpl $1, sign
	jnz finish
	fld1
	fxch #swaps st(0) with st(1)
	fdivp #calculates 2^(-y*log2(x))
finish:
	fstpl 4(%esp)
	movl $fmt_float, %eax
	movl %eax, (%esp)
	call printf
	pushl $pr
	call printf
	addl $12, %esp 
epilog:
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
