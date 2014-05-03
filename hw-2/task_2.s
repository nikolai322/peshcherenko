.data
fmt_string:
	.string "%s"
str_in_1:
	.space 4
str_in_2:
	.space 4
str_out:
	.space 4
pr:
	.string "\n"
count:
	.space 4
not_found:
	.string "No match found in the second string\n"
found:
	.string "Success! Match found in the second string\n"
digit:
	.string "%d"	
#Description:
#This program reads two strings; 
#every string consist of 4 characters;
.text
greater:
	pushl $1
	pushl $digit
	call printf
	jmp continue
less_equal:
	pushl $0
	pushl $digit
	call printf
	jmp continue
unsuccess:
	pushl $not_found
	pushl $fmt_string
	call printf
	jmp go_on
success:
	pushl $found
	pushl $fmt_string
	call printf
	jmp go_on
.globl main
main:
#prolog
	pushl %ebp
	movl %esp, %ebp
#read input data
	pushl $str_in_1
	pushl $fmt_string
	call scanf
	pushl $str_in_2
	pushl $fmt_string
	call scanf
#And here goes magic
#The search of '!' in the second string
	movl $str_in_1, %esi
	movl $str_in_2, %edi
	movl $5, %ecx
	movl $33, %eax #comparison with '!'
	repne scasb
	cmpl $0, %ecx
	je unsuccess
	jmp success
go_on:
#This part of code copies str_in_2 (each character increased by 1) in str_out
	movl $4, %ecx
	movl $str_in_2, %esi
	movl $str_out, %edi
begin:
	lodsb
	incb %al
	stosb
	loop begin
#This part of code copies str_out in str_in_2 and prints it
	movl $4, %ecx
	movl $str_out, %esi
	movl $str_in_2, %edi
	rep movsb
#This part of code returns the string with zero at the
#certain place if str_in_1 character is greater than str_in_2 and 0 otherwise
	movl $4, count
	movl $str_in_1, %esi
	movl $str_in_2, %edi
start:
	cmpsb
	jg greater
	jle less_equal
continue:
	decl count
	cmpl $0, count
	jg start
	pushl $pr
	call printf
#epilog
	movl %ebp, %esp
	popl %ebp
	ret
