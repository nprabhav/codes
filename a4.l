%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
%}

%%
[ \t\n]				;
#include\<[A-Za-z]+\.h\>	{return HEADER;}
[0-9]+				{yylval=atoi(yytext);return NUM;}
int|char|float|double		{return DTYPE;}
main				{return MAIN;}
return				{return RETURN;}
printf				{return PRINT;}
while				{return WHILE;}
for				{return FOR;}
if				{return IF;}
else				{return ELSE;}
[_a-zA-Z][_a-zA-Z0-9]*		{return VAR;}
true				{return TV;}
false				{return FV;}
"=="				{return EQ;}
"<="				{return LE;}
">="				{return GE;}
"!="				{return NE;}
"++"				{return PI;}
"--"				{return PD;}
.				{return yytext[0];}	
%%

int yywrap()
{
	return 1;
}
