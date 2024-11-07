/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-20 
 *********************************************************************/

data bottling;
   input A B C dev @@;
datalines;
-1 -1 -1 -3   -1 -1 -1 -1
 1 -1 -1  0    1 -1 -1  1
-1  1 -1 -1   -1  1 -1  0
 1  1 -1  2    1  1 -1  3
-1 -1  1 -1   -1 -1  1  0
 1 -1  1  2    1 -1  1  1
-1  1  1  1   -1  1  1  1
 1  1  1  6    1  1  1  5
;
proc print data = bottling; run;

proc glm data = bottling;
   class A B C;
   model dev = A | B | C;
   output out = diag r = res p = pred;
run;

proc univariate data = diag;
   var res;
   qqplot res / normal (L = 1 mu = 0 sigma = est);
   histogram res / normal;
run;

proc sgplot data = diag;
   scatter y = res x = pred;
   refline 0;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
