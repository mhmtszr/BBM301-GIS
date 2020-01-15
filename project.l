%{
	
#include "y.tab.c"

%}
%option yylineno
alphabet_char		[A-Za-z]
numbers 			[0-9]
sign			[\-+]
char_and_numbers	({alphabet_char}|{numbers})

%%

int				return(INT);
float			return(FLOAT);
bool			return(BOOL);
char			return(CHAR);
void			return(VOID);
string			return(STRING);

new				return(NEW);
array			return(ARRAY);
Graph			return(GRAPH);
User			return(USER);
Location		return(LOCATION);
ThreeDObject	return(THREEDOBJECT);
Crossroad		return(CROSSROAD);
Road			return(ROAD);

true			return(TRUE);
false			return(FALSE);

"&&"			return(AND);
"||"			return(OR);

if				return(IF);
else			return(ELSE);
switch			return(SWITCH);
case			return(CASE);
default			return(DEFAULT);

while			return(WHILE);
for				return(FOR);
do				return(DO);
break			return(BREAK);
continue		return(CONTINUE);

function		return(FUNCTION);
"getridetime"	return(GETRIDETIME);
"Register"		return(REGISTER);
"getTurkeyMap"	return(GETTURKEYMAP);
"getinput"		return(GETINPUT);
"printGis"			return(PRINT);
"showonmap"			return(SHOWONMAP);
"showtarget"		return(SHOWTARGET);
"searchlocation"	return(SEARCHLOCATION);
"getroadspeed"		return(GETROADSPEED);
"getlocation"		return(GETLOCATION);
"getUserLocation"	return(GETUSERLOCATION);
"showRoad"			return(SHOWROAD);
"drawOut"			return(DRAWOUT);

return			return(RETURN);

"<"				return(LESS_THAN);
">"				return(GREATER_THAN);
"<="			return(LESS_EQUAL);
">="			return(GREATER_EQUAL);
"!="			return(NOT_EQUAL);
"=="			return(IS_EQUAL);

"++"			return(INCREMENT);
"--"			return(DECREMENT);
"!"				return(NOT_SIGN);

"=+"			return(ADDITION_ASSIGNMENT);
"=-"			return(SUBTRACTION_ASSIGNMENT);
"=*"			return(MULTIPLICATION_ASSIGNMENT);
"=/"			return(DIVISION_ASSIGNMENT);
"=%"			return(MODE_ASSIGNMENT);
"=^"			return(POWER_ASSIGNMENT);
"="				return(ASSIGNMENT);

"+"				return(ADDITION);
"-"				return(SUBTRACTION);
"*"				return(MULTIPLICATION);
"/"				return(DIVISION);
"%"				return(MODE);
"^"|"**"		return(POWER);

\.				return(DOT);
","				return(COMMA);
":"				return(COLON);
";"				return(SEMICOLON);
"{"				return(L_BRACKET);
"}"				return(R_BRACKET);
"("				return(L_PARENTHESIS);
")"				return(R_PARENTHESIS);
"["				return(LSQ_BRACKET);
"]"				return(RSQ_BRACKET);

\'(\\.|[^\\'])+\'			return(CHAR_TYPE);
\"(\\.|[^\\"])*\"			return(STRING_TYPE);
{sign}?{numbers}+				return(INT_TYPE);
{sign}?{numbers}*"."{numbers}+	return(FLOAT_TYPE);
{alphabet_char}({char_and_numbers}|_)*	return(IDENTIFIER);

(\r|\n|\r\n)	;
[ \t\v\f]+		;

%%