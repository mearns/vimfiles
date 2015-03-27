
/**** C pre-code ****/
%{

//-----INCLUDES------

	//Some standard headers you're likely to need.
	#include <string.h>
	#include <stdio.h>
	#include <stdarg.h>
	#include <errno.h>


//----DEFINES--------

	#define YYERROR_VERBOSE 1

	//NILL is the value that should be assigned to nill types,
	// which are only used for syntax, but do not actually contrib anything. 
	#define NILL 0

//----FUNCTION PROTOTYPES-----

	//YACC functions
	int yylex(void);
	void yyerror(char *);

	//Custom functions
	char * concat(int num, ...);


//----GLOBAL VARS------
	//set to 1 for yacc debug mode
	int yydebug=0;

	FILE *yyin, *yyout, *yyerr;

	//You can use this for counting lines. But that's not automatic,
	// you'll need to do that yourself.
	int yylineno = 1;

%}

/**********UNIONS************/
%union
{
	int nill;
	char chr;
	int num;
	char *str;
}


/*******TOKENS**********/

%token <chr> TOK_UNKNOWN


/********TYPES**********/


%%

/************************* RULES ********************************************/

top:
	
	| TOK_UNKNOWN
	;


/****************************************************************************/

%%

/******* C post-code *******/

int main(int argc, char ** argv) {

	//Configuration
	char * in;
	char * out;

	//Default input/output streams
	yyin = stdin;
	yyout = stdout;
	yyerr = stderr;

	if(argc >= 2)
	{
		//At least 1 arg. It's the input
		in = argv[1];
		if(strcmp("-", in) != 0)
		{
			yyin = fopen(in, "rb");
			if(yyin == NULL) {
				fprintf(stderr, "Unable to open input file for reading: %s", in);
				exit(EIO);
			}
		}
	}


	if(argc >= 3)
	{
		out = argv[2];
		if(strcmp("-", out) != 0)
		{
			yyout = fopen(out, "wb");
			if(yyout == NULL)
			{
				fprintf(stderr, "Unable to open output file for writing: %s", out);
				exit(EIO);
			}
		}
	}
	
	//Do the parsing
	yyparse();

	return 0;
}

//Standard error reporting method for yacc
void yyerror(char *s) {
	fprintf(yyerr, "(On line %d):%s\n",yylineno, s);
}



/**
 * concatenate <i>num</i> strings together and return the null-terminated char * (a c-string).
 * Does NOT free any of the passed in char *'s
 */
char * concat(int num, ...)
{
	va_list argp;
	char * strs[num];	//All the passed in strings
	int lengths[num];	//Lengths of each string
	char * cur_str;	//the current string from var_args
	int total_length, cur_length;	//total concatenated length and the length of the current string
	int i;	//counter
	char *r_buf;	//Returned concatenated string
	char *r_ptr;	//Pointer into r_buf where the next string will be copied

	//Initialize varargs
	va_start(argp, num);

	
	total_length = 0;
	//Get all the strings from varargs, and add up the total length
	for(i=0; i<num; i++)
	{
		//Get the next string from varargs
		cur_str = va_arg(argp, char *);
		
		//Get it's length
		cur_length = strlen(cur_str);

		//Add the length
		total_length += cur_length;

		//Store string and length in buffer
		lengths[i] = cur_length;
		strs[i] = cur_str;
	}

	//Create the return buffer;
	r_buf = malloc(total_length + 1);
	if(r_buf == NULL)
	{
		yyerror("Could not allocate memory for concatenated string.");
	}
	else
	{
		//c-str termination
		r_buf[total_length] = 0;

		//start at the beginning
		r_ptr = r_buf;
	
		//Copy each string into the buffer
		for(i=0; i<num; i++)
		{
			memcpy(r_ptr, strs[i], lengths[i]);
			r_ptr += lengths[i];
		}
	}
	return r_buf;
}

