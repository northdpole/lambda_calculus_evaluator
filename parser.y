/***************************************************************/
/* File: eval.y                                                */
/* Yacc definition file for lambda calculus evaluator.         */
/***************************************************************/

%{
#define YYPARSER

#include "globals.h"
#include "util.h"

#define YYSTYPE TreeNode *

extern YYSTYPE tree;
%}

%token  LAMBDA_ID
%token  LAMBDA
%token  ID

%start expression_list

%%

expression_list : expression_list expression
                    {
                        $$ = newTreeNode(AppK);
                        $$->children[0] = $1;
                        $$->children[1] = $2;
                        tree = $$;
                    }
                |
                 expression
                    {
                        tree = $1;
                    }
                ;

expression      : ID    
                    {
                        $$ = newTreeNode(IdK);
                        $$->name = stringCopy(yytext);
                    }
                | '('LAMBDA_ID
		   {
			$$ = newTreeNode(IdK);
			/* drop the LAMBDA in the beginning and the . in the end */
			$$->name = stringCopy(&yytext[1]);
 			$$->name[strlen($$->name)-1] = '\0';
		   }
		  expression_list')'
		  {
			$$ = newTreeNode(AbsK);
                        $$->children[0] = $3;
                        $$->children[1] = $4;
		  }
		| '('LAMBDA ID 
                    {
                        $$ = newTreeNode(IdK);
                        $$->name = stringCopy(yytext);
		    } 
                    expression_list')'
                    {
                        $$ = newTreeNode(AbsK);
                        $$->children[0] = $4;
                        $$->children[1] = $5;
                    }
		 | '('expression_list')'
		    {
			$$ = $2;
		}
;
                ;

%%

int yyerror(char *message) {
    fprintf(errOut,"%s\n",message);
    fprintf(errOut,"\ttoken: %s\n",yytext);
}
