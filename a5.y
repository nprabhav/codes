%{
	#include<stdlib.h>
	#include<stdio.h>
	void yyerror(char *);
	int yylex(void);
	void three_address_code();
	void triple();
	void quadruple();
	char addtotable(char,char,char,char);
	struct table
	{
		char op;
		char a;
		char b;
		char result;
	};
	char temp='A';
	int id=0;
%}

%start st
%union{
	char symbol;
}
%token <symbol> NUM VAR
%type <symbol>	e
%right '='
%left '-' '+'
%left '*' '/' '%'
%left '(' ')'

%%
st	:	VAR '=' e	{addtotable((char)$1,'=',(char)$3,(char)$1);}
	| 	e	
	;
e	: 	e '+' e		{$$=addtotable((char)$1,'+',(char)$3,temp);temp++;}
	|	e '-' e		{$$=addtotable((char)$1,'-',(char)$3,temp);temp++;}
	|	e '*' e		{$$=addtotable((char)$1,'*',(char)$3,temp);temp++;}
	|	e '/' e		{$$=addtotable((char)$1,'/',(char)$3,temp);temp++;}
	|	e '%' e		{$$=addtotable((char)$1,'%',(char)$3,temp);temp++;}
	|	'(' e ')'	{$$=(char)$2;}
	|	NUM		{$$=(char)$1;}
	|	VAR		{$$=(char)$1;}
	;



%%
struct table tab[50];

void three_address_code()
{
	int cnt=0;
	printf("THREE ADDRESS CODE \n");
	while(cnt<id && tab[cnt].op!='=')
	{
		printf("%c\t",tab[cnt].result);
		printf(":=\t");
		printf("%c\t",tab[cnt].a);
		printf("%c\t",tab[cnt].op);
		printf("%c\t",tab[cnt].b);
		cnt++;
		printf("\n");
	}

	if(tab[cnt].op=='=')
	{
		printf("%c\t",tab[cnt].a);
		printf(":=\t");
		printf("%c\t",tab[cnt].b);
		cnt++;
		printf("\n\n");
	}

}

void quadruple()
{
	int cnt=0;
	printf("\nQUADRAPLE\n");
	while(cnt<id && tab[cnt].op != '='){
		printf("%d\t",cnt);
		printf("%c\t",tab[cnt].op);
		printf("%c\t",tab[cnt].a);		
		printf("%c\t",tab[cnt].b);
		printf("%c\t",tab[cnt].result);
		cnt++;
		printf("\n");
	}
	if(tab[cnt].op == '='){
		printf("%d\t",cnt);
		printf("%c\t",tab[cnt].op);
		printf("%c\t",tab[cnt].b);
		printf("_\t");
		printf("%c\t",tab[cnt].a);
		cnt++;
		printf("\n\n");
	}
	

}

void triple()
{
int cnt=0;
	printf("\nTRIPLE\n");
	while(cnt<id && tab[cnt].op != '='){
		printf("%d\t",cnt);
		printf("%c\t",tab[cnt].op);
		if('Z'-tab[cnt].a>=0){
			printf("%d\t",25-'Z'+tab[cnt].a);	
		}
		else{
			printf("%c\t",tab[cnt].a);
		}
		if('Z'-tab[cnt].b>=0){
			printf("%d\t",25-'Z'+tab[cnt].b);	
		}
		else{
			printf("%c\t",tab[cnt].b);
		}
		printf("\n");
		cnt++;
	}
	if(tab[cnt].op == '='){
		printf("%d\t",cnt);
		printf("%c\t",tab[cnt].op);
		printf("%c\t",tab[cnt].a);
		if('Z'-tab[cnt].b>=0){
			printf("%d\t",25-'Z'+tab[cnt].b);	
		}
		else{
			printf("%c\t",tab[cnt].b);
		}
		cnt++;
		printf("\n\n");
	}
}

char addtotable(char a,char op,char b,char result)
{	
	tab[id].a=a;
	tab[id].op=op;
	tab[id].b=b;
	tab[id].result=result;
	id++;
	return result;
}

void yyerror(char *s)
{	
	printf("%s\n",s);
}
int main()
{
	char ifile[100];
	printf("Enter a expression :");
	yyparse();
	three_address_code();
	quadruple();
	triple();
	return 0;
}
