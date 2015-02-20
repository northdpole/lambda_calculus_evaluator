/*****************************************************************/
/* File: test.c                                                  */
/* Test driver of the \\ calculus evaluator.                 */
/*****************************************************************/

#include "globals.h"
#include "util.h"
#include "eval.h"

#define PARSE_DUMP 0

TreeNode * tree = NULL;

FILE* out;
FILE* errOut;

int main(int argc, char* argv[]) {
    out = stdout;
    errOut = stderr;
    
    char* exprs[] = {"x","X","(\\ x x)","(\\ x y)",
                    "(\\ x (\\ y y))",
                    "(\\ x (\\ y x))",
                    "(\\ x (\\ y y) z)",
                    "x y",
                    "x (\\ y y)",
                    "(\\ x x) y",
                    "(\\ x x) (\\ y y)",
                    "(\\ x x) (\\ y y) z",
                    "(\\ x x x)",
                    "(\\ x x x) (\\ x x x)",
                    "(\\ x (\\ x x))",
                    "(\\ x (\\ y x))",
                    "(\\ x (\\ y y))",
                    "(\\ p (\\ q p q p))",
                    "(\\ p (\\ q p p q))",
                    "(\\ p (\\ a (\\ b p b a)))",
                    "(\\ p (\\ a (\\ b p a b)))",
                    "(\\ x (\\ y (\\ f f x y)))",
                    "(\\ p p (\\ x (\\ y x)))",
                    "(\\ p p (\\ x (\\ y y)))",
                    "(\\ x (\\ y (\\ z y)))",
                    "(\\ p (\\ x (\\ y (\\ a (\\ b b)))))"
                    };
    int i;
    for(i=0;i<26;i++) {
        fprintf(out,"Expression: %s\n",exprs[i]);
        yy_scan_string(exprs[i]);
        yyparse();
        if(PARSE_DUMP) {
            printTree(tree);
            fprintf(out,"\n");
        }
        tree = evaluate(tree);
        fprintf(out,"\t->  ");
        printExpression(tree);
        fprintf(out,"\n");
        deleteTreeNode(tree);
        tree=NULL;
    }
    return 0;
}
