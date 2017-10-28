%{
#include<stdio.h>
#include<stdlib.h>
int line=1;
%}

%%
\n line++;
# printf("%d\t\t\t%s\t\t\tPreprocessor\t\t\n",line,yytext);
include|main|return printf("%d\t\t\t%s\t\t\tKeyword\t\t\n",line,yytext);
int|float|double|char printf("%d\t\t\t%s\t\t\tData Type\t\t\n",line,yytext);
[a-zA-Z][a-zA-Z0-9]*\.h printf("%d\t\t\t%s\t\tHeader File\t\t\n",line,yytext);
[a-zA-Z][a-zA-Z0-9]* printf("%d\t\t\t%s\t\t\tIdentifier\t\t\n",line,yytext);
\{ printf("%d\t\t\t%s\t\t\tOpen Block\t\t\n",line,yytext);
\} printf("%d\t\t\t%s\t\t\tClose Block\t\t\n",line,yytext);
\=  printf("%d\t\t\t%s\t\t\tOperator\t\t\n",line,yytext);
\(  printf("%d\t\t\t%s\t\t\tOpen\t\t\n",line,yytext);
\)  printf("%d\t\t\t%s\t\t\tClose\t\t\n",line,yytext);
[0-9]+  printf("%d\t\t\t%s\t\t\tInteger\t\t\n",line,yytext);
\;  printf("%d\t\t\t%s\t\t\tTerminator\t\t\n",line,yytext);
\<  printf("%d\t\t\t%s\t\t\tLess Than\t\t\n",line,yytext);
\>  printf("%d\t\t\t%s\t\t\tGreater Than\t\t\n",line,yytext);
\,  printf("%d\t\t\t%s\t\t\tSeperator\t\t\n",line,yytext);
[ \t] ;
%%

int main()
{
	char ifile[100];
	printf("Enter Input file name: ");
	scanf("%s",ifile);
	yyin=fopen(ifile,"r");
	printf("Line No.\t\tLexeme\t\t\tToken \n");
	yylex();
	return 0;

}

int yywrap()
{
	return 1;
}
