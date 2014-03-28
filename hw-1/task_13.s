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
	jmp label_continue_ZF
label_1_ZF:
	pushl $1
	jmp label_continue_ZF
label_0_SF:
	pushl $0
	jmp label_continue_SF
label_1_SF:
	pushl $1
	jmp label_continue_SF
label_0_OF:
	pushl $0
	jmp label_continue_OF
label_1_OF:
	pushl $1
	jmp label_continue_OF
label_0_CF:
	pushl $0
	jmp label_continue_CF
label_1_CF:
	pushl $1
	jmp label_continue_CF
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
label_continue_ZF:
	jb label_0_CF
	jae label_1_CF
label_continue_CF:
	js label_0_SF
	jns label_1_SF
label_continue_SF:
	jno label_0_OF
	jo label_1_OF
label_continue_OF:
	pushl $format_string_OF
	call printf
	addl $8, %esp
	
	pushl $format_string_SF
	call printf
	addl $8, %esp
	
	pushl $format_string_CF
	call printf
	addl $8, %esp
	
	pushl $format_string_ZF
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
