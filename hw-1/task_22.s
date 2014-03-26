/*
This is a code that will be written in C like this:
#include <stdio.h>
struct PERSON
{
char SURNAME[10];
char NAME[10];
int AGE;
};
struct PERSON A;
int main()
{
scanf("%s",A.SURNAME);
scanf("%s",A.NAME);
scanf("%d",&A.AGE);
printf("%s\n",A.SURNAME);
printf("%s\n",A.NAME);
printf("%d\n",A.AGE);
return 0;
}
*/

.data
A:
.space 24
fmt_str:
.string "%s"
fmt_int:
.string "%d"
fmt_str_pr:
.string "%s\n"
fmt_int_pr:
.string "%d\n"
.text
.globl main
main:
//prolog
pushl %ebp
movl %esp, %ebp
//main program
pushl $A
pushl $fmt_str
call scanf
pushl $A+10
pushl $fmt_str
call scanf
pushl $A+20
pushl $fmt_int
call scanf
movl $A, (%esp)
call puts
movl $A+10, (%esp)
call puts
movl A+20, %edx
pushl %edx
pushl $fmt_int_pr
call printf
//epilog
  movl $0, %eax
movl %ebp, %esp
popl %ebp
ret
