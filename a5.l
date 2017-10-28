%{
	#include<stdlib.h>
	#include<stdio.h>
	#include"y.tab.h"
%}

%%
[0-9]+ 		{yylval.symbol=(char)yytext[0];return NUM;}
[A-Za-z]+ 	{yylval.symbol=(char)yytext[0];return VAR;}
[\n]		{return 0;}
.		{return yytext[0];}

%%

int yywrap()
{
	return 1;
}
