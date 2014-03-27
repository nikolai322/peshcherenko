.data
format_string_CF:
	.string "CF=%d\n"
format_string_ZF:
	.string "ZF=%d\n"
format_string_SF:
	.string "SF=%d\n"
format_string_OF:
	.string "OF=%d\n"
.text
label_0_ZF:
	pushl $0
	jmp label_print_ZF
label_1_ZF:
	pushl $1
	jmp label_print_ZF
label_0_SF:
	pushl $0
	jmp label_print_SF
label_1_SF:
	pushl $1
	jmp label_print_SF
label_0_OF:
	pushl $0
	jmp label_print_OF
label_1_OF:
	pushl $1
	jmp label_print_OF
label_0_CF:
	pushl $0
	jmp label_print_CF
label_1_CF:
	pushl $1
	jmp label_print_CF
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
		
	je label_0_ZF
	jne label_1_ZF
label_print_ZF:
	pushl $format_string_ZF
	call printf
	addl $8, %esp	

	jb label_0_CF
	jae label_1_CF
label_print_CF:
	pushl $format_string_CF
	call printf
	addl $8, %esp

	js label_0_SF
	jns label_1_SF
label_print_SF:
	pushl $format_string_SF
	call printf
	addl $8, %esp

	jno label_0_OF
	jo label_1_OF
label_print_OF:
	pushl $format_string_OF
	call printf
	addl $8, %esp
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
//epilog
	movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
