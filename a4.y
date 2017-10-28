%{
	#include<stdlib.h>
	#include<stdio.h>
	void yyerror(char *);
	int yylex(void);
	extern FILE * yyin;
%}

%start	program
%token	NUM IF ELSE FOR HEADER MAIN EQ LE GE NE PI PD TV FV PRINT DTYPE VAR RETURN WHILE 	
%right	'='
%left	EQ NE
%left	'<' '>' LE GE
%left	'-' '+'
%left	'*' '/' '%'
%left	'(' ')' PI PD

%%
exp	:	exp '-' exp
	|	exp '+' exp
	|	exp '*' exp
	|	exp '/' exp
	|	exp '%' exp
	|	'(' exp ')'
	|	exp PI
	|	exp PD
	|	VAR
	|	NUM
	;

cond	:	TV
	|	FV
	|	exp '<' exp
	|	exp '>' exp
	|	exp EQ exp
	|	exp NE exp
	|	exp LE exp
	|	exp GE exp
	;

assign	:	VAR '=' exp
	;

varlist	:	VAR
	|	assign
	|	varlist ',' VAR
	|	varlist ',' assign
	;

stmt	:	DTYPE varlist ';' 			{printf("Declaration\n");}
	|	assign ';'  				{printf("Assignment\n");}
	|	RETURN NUM ';'  			{printf("Return\n");}
	|	WHILE '(' cond ')' '{' stmts '}'	{printf("While Loop\n");}
	|	FOR '('start';'mid';'end')''{'stmts'}'	{printf("For Loop\n");}
	;

stmts	: 
	|	stmts stmt
	;

start	:
	|	assign
	;

mid	:
	|	cond
	;

end	:
	|	exp
	;

header	:
	|	header HEADER				{printf("Header\n");}
	;

program	:	header DTYPE MAIN '(' ')' '{' stmts '}'	{printf("Program with main\n");}
	;


%%
void yyerror(char* s){
	printf("%s\n",s);
}
int main(){
	char ifile[100];
	printf("Enter the file name: ");
	scanf("%s",ifile);
	yyin=fopen(ifile,"r");
	yyparse();
}
