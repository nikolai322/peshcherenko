.data
count:
	.space 4
fmt_string:
	.string "%d"
array:
	.space 16
a:
	.space 4
.text
label_0_CF:
	movl $0, (%ebx)
	addl $4, %ebx
	jmp continue_1
label_1_CF:
	movl $1, (%ebx)
	addl $4, %ebx
	jmp continue_1
label_0_ZF:
	movl $0, (%ebx)
	addl $4, %ebx
	jmp continue_2
label_1_ZF:
	movl $1, (%ebx)
	addl $4, %ebx
	jmp continue_2
label_0_SF:
	movl $0, (%ebx)
	addl $4, %ebx
	jmp continue_3
label_1_SF:
	movl $1, (%ebx)
	addl $4, %ebx
	jmp continue_3
label_0_OF:
	movl $0, (%ebx)
	jmp continue_4
label_1_OF:
	movl $1, (%ebx)
	jmp continue_4
.globl main
.macro outf
#Carry flag
	jc label_1_CF
	jnc label_0_CF
continue_1:
#Zero flag
	je label_0_ZF
	jne label_1_ZF
continue_2:
#Sign flag
	js label_1_SF
	jns label_0_SF
continue_3:
#Overflow flag
	jo label_1_OF
	jno label_0_OF
continue_4:
.endm
.globl main
print:
#prolog
	pushl %ebp
	movl %esp, %ebp
#Main program
	movl $4, count
	movl $array, %ebx
#Now %ebx becomes the pointer to the current array element
	outf
	movl $array, %ebx
start:
	movl (%ebx), %eax
	movl %ebx, a
	pushl %eax
	pushl $fmt_string
	call printf
	movl a, %ebx
	addl $4, %ebx
	decl count
	cmpl $0, count
	jg start
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
	call print
#epilog
	movl $0, %eax
	movl %ebp, %esp
	popl %ebp
	ret
