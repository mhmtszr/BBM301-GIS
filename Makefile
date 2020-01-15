makeYacc: project.l project.y
	lex project.l
	yacc project.y
	gcc -o GIS++_parser lex.yy.c -lfl -w
	./GIS++_parser < test.txt
