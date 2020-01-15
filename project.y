%token INT FLOAT BOOL VOID STRING CHAR 
%token GRAPH ARRAY NEW USER CROSSROAD ROAD LOCATION THREEDOBJECT
%token FALSE TRUE
%token AND OR
%token IF ELSE SWITCH CASE DEFAULT
%token WHILE DO BREAK CONTINUE FOR
%token FUNCTION RETURN
%token PRINT SHOWONMAP SEARCHLOCATION GETROADSPEED GETLOCATION SHOWTARGET 
%token GETINPUT GETTURKEYMAP REGISTER GETRIDETIME GETUSERLOCATION SHOWROAD DRAWOUT
%token LESS_EQUAL GREATER_EQUAL NOT_EQUAL IS_EQUAL LESS_THAN GREATER_THAN 
%token ASSIGNMENT ADDITION_ASSIGNMENT SUBTRACTION_ASSIGNMENT MULTIPLICATION_ASSIGNMENT DIVISION_ASSIGNMENT MODE_ASSIGNMENT POWER_ASSIGNMENT
%token INCREMENT DECREMENT NOT_SIGN
%token MULTIPLICATION DIVISION MODE ADDITION SUBTRACTION POWER
%token INT_TYPE FLOAT_TYPE STRING_TYPE CHAR_TYPE IDENTIFIER
%token L_PARENTHESIS R_PARENTHESIS L_BRACKET R_BRACKET LSQ_BRACKET RSQ_BRACKET DOT COMMA COLON SEMICOLON
%token NEW_LINE WHITE_SPACE

%left ADDITION SUBTRACTION
%left MULTIPLICATION DIVISION MODE
%left POWER 

%%

program: function 
		| program function 
		;
		
function: FUNCTION return_type IDENTIFIER L_PARENTHESIS argument_list R_PARENTHESIS inside_statements
		| FUNCTION return_type function_definition L_PARENTHESIS argument_list R_PARENTHESIS inside_statements
		;
		
function_definition: REGISTER
		| GETUSERLOCATION
		| SHOWROAD
		;
		
return_type: data_type		
		;
		
argument_list: empty 
		| data_type IDENTIFIER
		| argument_list COMMA data_type IDENTIFIER
		| VOID
		;
		
inside_statements: L_BRACKET statement_list R_BRACKET
		| L_BRACKET empty R_BRACKET
		;
		
statement_list: statement
		| statement_list statement
		;
		
statement: assignment SEMICOLON
		| declaration SEMICOLON
		| loop
		| condition
		| function_call SEMICOLON
		| BREAK SEMICOLON
		| CONTINUE SEMICOLON
		| RETURN SEMICOLON
		| RETURN IDENTIFIER SEMICOLON
		| RETURN factor SEMICOLON
		| RETURN function_call SEMICOLON
		;
		
declaration: data_type IDENTIFIER 
		| declaration assignment_operator RightHandSide
		| ARRAY data_type IDENTIFIER LSQ_BRACKET INT_TYPE RSQ_BRACKET ASSIGNMENT L_BRACKET factor_list R_BRACKET
		;
		
factor_list: factor
		| factor_list COMMA factor
		;
		
RightHandSide: arithmetic_phrases
		| function_call
		| boolean_expression
		| NEW GRAPH L_PARENTHESIS identifier_list R_PARENTHESIS
		| NEW USER L_PARENTHESIS identifier_list R_PARENTHESIS
		| NEW CROSSROAD L_PARENTHESIS identifier_list R_PARENTHESIS
		| NEW ROAD L_PARENTHESIS identifier_list R_PARENTHESIS
		| NEW LOCATION L_PARENTHESIS identifier_list R_PARENTHESIS
		| NEW THREEDOBJECT L_PARENTHESIS identifier_list R_PARENTHESIS
		| IDENTIFIER DOT IDENTIFIER
		;

function_call: PRINT L_PARENTHESIS identifier_list R_PARENTHESIS
		| SHOWONMAP L_PARENTHESIS identifier_list R_PARENTHESIS
		| SEARCHLOCATION L_PARENTHESIS identifier_list R_PARENTHESIS
		| SHOWTARGET L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETROADSPEED L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETLOCATION L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETINPUT L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETTURKEYMAP L_PARENTHESIS identifier_list R_PARENTHESIS
		| REGISTER L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETRIDETIME L_PARENTHESIS identifier_list R_PARENTHESIS
		| GETUSERLOCATION L_PARENTHESIS identifier_list R_PARENTHESIS
		| SHOWROAD L_PARENTHESIS identifier_list R_PARENTHESIS
		| DRAWOUT L_PARENTHESIS identifier_list R_PARENTHESIS
		;
		
identifier_list: empty 
		| IDENTIFIER
		| IDENTIFIER DOT IDENTIFIER
		| identifier_list COMMA IDENTIFIER DOT IDENTIFIER
		| identifier_list COMMA IDENTIFIER
		| factor
		| identifier_list COMMA factor
		| function_call
		| identifier_list COMMA function_call
		;

arithmetic_phrases: term
		| arithmetic_phrases ADDITION term
		| arithmetic_phrases SUBTRACTION term
		;
		
term: factor
		| term MULTIPLICATION factor
		| term DIVISION factor
		| term POWER factor
		| term MODE factor
		;
		
factor: INT_TYPE
		| FLOAT_TYPE 
		| STRING_TYPE
		| CHAR_TYPE
		;
		
assignment_operator: ASSIGNMENT 
		| MULTIPLICATION_ASSIGNMENT 
		| DIVISION_ASSIGNMENT 
		| ADDITION_ASSIGNMENT 
		| SUBTRACTION_ASSIGNMENT 
		| MODE_ASSIGNMENT
		| POWER_ASSIGNMENT
		;
		
assignment: LeftHandSide assignment_operator RightHandSide
		| LeftHandSide INCREMENT 
		| LeftHandSide DECREMENT
		;
		
LeftHandSide: IDENTIFIER
		| IDENTIFIER LSQ_BRACKET INT_TYPE RSQ_BRACKET
		| IDENTIFIER DOT IDENTIFIER
		;
		
loop: while_loop
		| for_loop
		| do_while_loop
		;
		
while_loop: WHILE L_PARENTHESIS boolean_expression R_PARENTHESIS inside_statements 
		;
		
do_while_loop: do_statement WHILE L_PARENTHESIS boolean_expression R_PARENTHESIS SEMICOLON
		;
		
do_statement: DO inside_statements
		;
		
for_loop: FOR L_PARENTHESIS for_statement R_PARENTHESIS inside_statements
		;
		
for_statement: initialize SEMICOLON boolean_expression SEMICOLON assignment
		;
		
initialize: declaration
		| assignment
		;
		
condition: if_statement
		| switch_statement
		;
		
if_statement: IF L_PARENTHESIS boolean_expression R_PARENTHESIS inside_statements
		| IF L_PARENTHESIS function_call R_PARENTHESIS inside_statements
		| if_statement ELSE IF L_PARENTHESIS boolean_expression R_PARENTHESIS inside_statements
		| if_statement ELSE inside_statements
		;
		
boolean_expression: comparison
		| IDENTIFIER
		| FALSE 
		| TRUE
		| NOT_SIGN IDENTIFIER
		;
		
comparison: boolean_expression relational_operators comparable_factors
		| boolean_expression boolean_operators comparable_factors
		| function_call relational_operators comparable_factors
		| IDENTIFIER DOT IDENTIFIER relational_operators comparable_factors
		;
		
comparable_factors: IDENTIFIER
		| FALSE 
		| TRUE
		| factor
		;
		
relational_operators: LESS_EQUAL
		| GREATER_EQUAL 
		| NOT_EQUAL 
		| IS_EQUAL 
		| LESS_THAN 
		| GREATER_THAN
		;
		
boolean_operators: AND 
		| OR 
		;
		
switch_statement: SWITCH L_PARENTHESIS IDENTIFIER R_PARENTHESIS L_BRACKET case_statement R_BRACKET 
		| SWITCH L_PARENTHESIS IDENTIFIER LSQ_BRACKET IDENTIFIER RSQ_BRACKET R_PARENTHESIS L_BRACKET case_statement R_BRACKET 
		;
		
case_statement: CASE IDENTIFIER COLON statement_list
		| CASE factor COLON statement_list
		| case_statement CASE IDENTIFIER COLON statement_list
		| case_statement CASE factor COLON statement_list
	    | case_statement DEFAULT COLON statement_list
		;
		
data_type: CHAR 
		| INT 
		| FLOAT 
		| VOID
		| BOOL
		| STRING
		| GRAPH
		| USER
		| CROSSROAD
		| ROAD
		| LOCATION
		| THREEDOBJECT
		;
		
empty: /* empty */
		;
		
%%

int main(void) 
{
    if(yyparse()==0)
	{
    	printf("The program was compiled successfully.\n");
    }
    return 0;
}

void yyerror(char *c) 
{
    fprintf(stderr, "Line no: %d found error\n", yylineno);
}