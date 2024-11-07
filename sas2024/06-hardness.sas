/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-10 
 *********************************************************************/

data hardness;
   input type coupon hardness @@;
datalines;
1  1  9.3    1  2  9.4    1  3  9.6     1  4  10.0
2  1  9.4    2  2  9.3    2  3  9.8     2  4   9.9
3  1  9.2    3  2  9.4    3  3  9.5     3  4   9.7
4  1  9.7    4  2  9.6    4  3 10.0     4  4  10.2
;
proc print data = hardness; run;

/*** ANOVA ***/

proc glm data = hardness;
   class type coupon;
   model hardness = type coupon;
   means type / alpha = 0.05 tukey lines;
run;

/*** check model assumptions ***/

proc glm data = hardness;
   class type coupon;
   model hardness = type coupon;
   output out = diag r = res p = pred;
run;

proc univariate normal data = diag;
   var res;
   qqplot res / normal (L = 1 mu = 0 sigma = est);
   histogram res / normal;
run;

proc sgplot data = diag;
   scatter y = res x = pred;
run;

proc sgplot data = diag;
   scatter y = res x = type;
run;

proc sgplot data = diag;
   scatter y = res x = coupon;
run;

/*** Tukey's test for non-additivity ***/

data two;
   set diag;
   q = pred * pred;

proc glm data = two;
   class type coupon;
   model hardness = type coupon q;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
