%{
#include "globals.h"
%}

lambda      "\\"
identifier  [A-Za-z]+
whitespace  [ \t]+
newline     [\r\n]+

%%

    /* reserved words */
{lambda}{identifier}"."  {return LAMBDA_ID;}
{lambda}        {return LAMBDA;}

    /* identifier */
{identifier}    {return ID;}

{whitespace}    /* do nothing. */;
{newline}       ;

.               {return yytext[0];}

%%

int yywrap() {
    return 1;
}
