/*
Grammar:

E->TE'
E'->+TE'|epsilon
T->FT'
T'->*FT'|epsilon
F->(E)|id

*/

#include<iostream>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
using namespace std;

char input[10];
int i,error;
void E();
void Edash();
void T();
void Tdash();
void F();
int match(char,char);

void E()
{
T();
Edash();
}


void Edash()
{
	if(match(input[i],'+'))
	{
		i++;
		T();
		Edash();
	}
}


void T()
{
	F();
	Tdash();
}


void Tdash()
{
	if(match(input[i],'*'))
	{
		i++;
		F();
		Tdash();
	}
}


void F()
{	
	if(isalnum(input[i]))
	i++;
	else if(match(input[i],'('))
	{
		i++;
		E();
		if(match(input[i],')'))
		i++;
		else
		{	
			cout<<"Terminating as no matching bracket";
			exit(EXIT_FAILURE);
		}	
	}	
	else
	{	
		cout<<"Terminating as production of F is Incomplete";
		exit(EXIT_FAILURE);
	}
}

int match(char a,char b)
{	
	if(a==b)
	return 1;
	else 
	return 0;	
}	
int main()
{
i=0;
error=0;
cout<<"Enter arithmatic expression (eg. a+a*a):";
cin>>input;
E();
if(strlen(input)==i && error==0)
	cout<<"String is Accpeted"<<endl;
else
	cout<<"String is not Accpeted"<<endl;
return 0;
}
