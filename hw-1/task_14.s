.data
int_label1:
	.space 4
int_label2:
	.space 4
format_string_CF:
	.string "CF=%d\n"
format_string_ZF:
	.string "ZF=%d\n"
format_string_SF:
	.string "SF=%d\n"
format_string_OF:
	.string "OF=%d\n"
fmt_read:
	.string "%d"
.text
label_0_ZF:
	pushl $0
	jmp label_print_ZF
label_1_ZF:
	pushl $1
	jmp label_print_ZF
label_0_CF:
	pushl $0
	jmp label_print_CF
label_1_CF:
	pushl $1
	jmp label_print_CF
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

.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//read input data
	pushl $int_label1
	pushl $fmt_read
	call scanf
	pushl $int_label2
	pushl $fmt_read
	call scanf
	movl int_label1, %eax
	movl int_label2, %ebx	
//main program
//ZF
	cmpl int_label1, %ebx
	je label_0_ZF
	jne label_1_ZF
label_print_ZF:
	pushl $format_string_ZF
	call printf
	addl $8, %esp
//CF
	movl int_label1, %eax
	movl int_label2, %ebx
	movb %al, %cl
	addb %bl, %cl
	jb label_0_CF
	jae label_1_CF
label_print_CF:
	pushl $format_string_CF
	call printf
	addl $8, %esp
//SF
	movl int_label1, %eax
	subl $0, %eax	
	js label_0_SF
	jns label_1_SF
label_print_SF:
	pushl $format_string_SF
	call printf
	addl $8, %esp
//OF
	movl int_label1, %eax
	movl int_label2, %ebx
	movl %eax, %ecx
	addl %ebx, %ecx
	jo label_0_OF
	jno label_1_OF
label_print_OF:
	pushl $format_string_OF
	call printf
	addl $8, %esp
//epilog
  movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
