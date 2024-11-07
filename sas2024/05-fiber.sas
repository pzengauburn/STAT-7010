/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data fiber;
   input y machine x @@;
datalines;
36  1 20     40  2 22     35  3 21  
41  1 25     48  2 28     37  3 23  
39  1 24     39  2 22     42  3 26  
42  1 25     45  2 30     34  3 21  
49  1 32     44  2 28     32  3 15  
;
proc print data = fiber; run;

/**** analysis of variance, ignoring x ****/
proc glm data = fiber;
   class machine; 
   model y = machine;
run;

/**** analysis of covariance ****/
proc glm data = fiber;
   class machine; 
   model y = machine x / solution;
run;

proc glm data = fiber;
   class machine; 
   model y = x machine / solution;
run;

/*** ANOVA on x, to check independence of treatments and covariates ***/
proc glm data = fiber;
   class machine;
   model x = machine;
run;

/*** model diagnostics ***/
proc glm data = fiber;
   class machine; 
   model y = machine x;
   output out = diag r = res p = pred;
run;

proc univariate data = diag; 
   qqplot res / normal (L = 1 mu = est sigma = est);
run;

proc sgplot data = diag;
   scatter y = res x = pred;
run;

proc sgplot data = diag;
   scatter y = res x = machine;
run;

proc sgplot data = diag;
   scatter y = res x = x;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
