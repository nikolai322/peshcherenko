.data
int_label:
	.space 4
int_label2:
	.space 4
format_string:
	.string "%d"
format_string_eq:
	.string "eax==ebx\n"
format_string_less:
	.string "eax < ebx\n"
format_string_more:
	.string "eax > ebx\n"
.text
label_equal:
	pushl $format_string_eq
	jmp label_print
label_less:
	pushl $format_string_less
	jmp label_print
label_more:
	pushl $format_string_more
	jmp label_print
.globl main
//This is a program that will be written in C like this:
//if (eax > ebx) printf("eax > ebx\n");
//	else 
//		if (eax < ebx) printf("eax < ebx\n");
//			else printf("eax==ebx");
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//read input data
	pushl $int_label
	pushl $format_string
	call scanf
	addl $8, %esp
	pushl $int_label2
	pushl $format_string
	call scanf
	addl $8, %esp
	movl int_label, %eax
	movl int_label2, %ebx
//main program
	cmpl %ebx, %eax
	jl label_less
	jg label_more
	je label_equal
label_print:
	call printf
	addl $4, %esp
//epilog
  movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
