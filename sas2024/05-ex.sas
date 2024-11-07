/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data ex;
   input A B C x y;
   AB = A*B; AC = A*C;
datalines;
-1  -1  -1   4.05  -30.73  
 1  -1  -1   0.36    9.07    
-1   1  -1   5.03   39.72   
 1   1  -1   1.96   16.30   
-1  -1   1   5.38  -26.39  
 1  -1   1   8.63   54.58   
-1   1   1   4.10   44.54   
 1   1   1  11.44   66.20   
-1  -1  -1   3.58  -26.46  
 1  -1  -1   1.06   10.94   
-1   1  -1  15.53  103.01  
 1   1  -1   2.92   20.44   
-1  -1   1   2.48   -8.94   
 1  -1   1  13.64   73.72   
-1   1   1  -0.67   15.89   
 1   1   1   5.13   38.57   
;
proc print data = ex; run;

/**** analysis without covariates ***/
proc glm data = ex;
   class A B C;
   model y = A | B | C;
   output out = diag r = res p = pred;
run;

proc univariate data = diag;
   qqplot res / normal (L = 1 mu = est sigma = est);
run;

proc sgplot data = diag;
   scatter y =  res  x = pred;
run;

proc reg data = ex;
   model y = A B C AB AC;
   plot r. * p.;
   plot r. * nqq.;
run;

/**** analysis with covariates ***/
proc glm data = ex;
   class A B C;
   model y = A | B | C x;
   output out = diag2 r = res p = pred;
run;

proc univariate data = diag2;
   qqplot res / normal (L = 1 mu = est sigma = est);
run;

proc sgplot data = diag2;
   scatter y = res  x = pred;
run;

proc reg data = ex;
   model y = A B AB x;
   plot r. * p.;
   plot r. * nqq.;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
