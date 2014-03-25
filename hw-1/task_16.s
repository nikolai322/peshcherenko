.data
format_string:
	.string "%d"
format_string_other:
	.string "Other"
int_label:
	.space 4
pr:
	.string "\n"
.text
.globl main
main:
//prolog
	pushl %ebp
	movl %esp, %ebp
//main program
/*
This is a code that will bew written in C like this:
switch (eax) {
case 0: 
	printf("0");
	break;
case 1: 
	printf("1");
	break;
case 2: 
	printf("2");
	break;
case 3: 
	printf("3");
	break;
default: 
	printf("Other");
	break;
}
*/
//read input data
	pushl $int_label
	pushl $format_string
	call scanf
	movl int_label, %eax
	movl $0, %ebx
	cmpl %eax, %ebx
	je label_print
	movl $1, %ebx
	cmpl %eax, %ebx
	je label_print
	movl $2, %ebx
	cmpl %eax, %ebx
	je label_print
	movl $3, %ebx
	cmpl %eax, %ebx
	je label_print
	jmp label_print_other
label_print:
	pushl %ebx
	pushl $format_string
	call printf
	pushl $pr
	call printf
	jmp epilog
label_print_other:
	pushl $format_string_other
	call printf
	pushl $pr
	call printf
epilog:
  movl $0, %eax
	movl %ebp, %esp	
	popl %ebp
	ret
