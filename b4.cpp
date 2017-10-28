#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define MAX 100
#define P printf
#define S scanf
typedef struct triple_type
{
 char num[5];
 char op[5];
 char arg1[10];
 char arg2[10];
 struct triple_type *next;
}TRIPLE;
TRIPLE *start,*current,*prev,*lookahead,*ref;
int numinst;
void init(void)
{
 int i=0;
 P("\n In Syntax Tree Intermediate node become Operator & Leaf Nodes become Operand");
 P("\nPlease enter the Syntax Tree :\n");
 P("(Enter \" $ \" for operand to end)\n");
 P("\tOPERATOR\tARG1\tARG2\n");
 start = (TRIPLE *)malloc(sizeof(TRIPLE));
 current = start;
 while(1)
 {
 P("%d\t",i);
 S("%s%s%s",current->op,current->arg1,current->arg2);
 if(current->op[0] == '$')
 {
 current->next = NULL;
 break;
 }
 sprintf(current->num,"%d",i);
 current->next = (TRIPLE *)malloc(sizeof(TRIPLE));
 current = current->next;
 i++;
 }
 numinst = i;
}
void show_code(void)
{
 current = start;
 P("\n\n The Optimised Code using DAG is :\n");
 P("\tOPERATOR\tARG1\tARG2");
 while(current->next)
 {
 P("\n%s\t%s\t\t%s\t\t%s",current->num,current->op,current->arg1,current->arg2);
 current = current->next;
 }
}
int main()
{
char arg[10];
init();
current = start;
while(current) 
{
 prev = current;
 lookahead = current->next;
 while(lookahead)
 {
 if(strcmp(lookahead->arg1,current->arg2) == 0)
 {
 current = current->next;
 break;
 }
 if(strcmp(current->op,lookahead->op)==0 && strcmp(current->arg1,
 lookahead->arg1) == 0 && strcmp(current->arg2,lookahead->arg2) == 0)
 {
 ref = lookahead->next;
 strcpy(arg,lookahead->num);
 while(ref)
 {
 if(strcmp(ref->arg1,arg) == 0)
 strcpy(ref->arg1,current->num);
 if(strcmp(ref->arg2,arg) == 0)
 strcpy(ref->arg2,current->num);
 ref = ref->next;
 }
 prev->next = lookahead->next;
 lookahead = lookahead->next;
 }
 else
 {
 prev = lookahead;
 lookahead = lookahead->next;
 }
 }
 current = current->next;
 }
 show_code();
return 0;
}

