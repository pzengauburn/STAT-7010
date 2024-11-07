/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-14 
 *********************************************************************/

/*** randomization ***/
data design;
   input percent @@;
   randno = ranuni(0);
datalines;
15 15 15 15 15
20 20 20 20 20
25 25 25 25 25
30 30 30 30 30
35 35 35 35 35
;

proc sort; by randno;
proc print data = design; run;


/*** data analysis ***/
data tensile;
   input percent strength time @@;
datalines;
15  7 15   15  7 19   15 15 25   15 11 12   15  9  6
20 12  8   20 17 14   20 12  1   20 18 11   20 18  3
25 14 18   25 18 13   25 18 20   25 19  7   25 19  9
30 19 22   30 25  5   30 22  2   30 19 24   30 23 10
35  7 17   35 10 21   35 11  4   35 15 16   35 11 23
;
proc print data = tensile; run;

/*** side-by-side boxplots ****/
proc sgplot data = tensile;
   vbox strength / category = percent;
run;

/*** some descriptive statistics ***/
proc means data = tensile n mean std clm;
   class percent;
   var strength;
run;

/*** one-way ANOVA ***/
proc glm data = tensile;
   class percent; 
   model strength = percent;
run;


/*** check model assumptions ***/
proc glm data = tensile plots = diagnostics;
   class percent; 
   model strength = percent;
run;

proc glm data = tensile;
   class percent; 
   model strength = percent;
   output out = fitted p = pred r = res student=stures;
run;

proc sgplot data = fitted; 
   scatter x = pred y = res;
   refline 0;
run;

proc sgplot data = fitted; 
   scatter x = time y = res;
   refline 0;
run;

proc sgplot data = fitted; 
   scatter x = pred y = stures;
   refline 0;
run;

proc sgplot data = fitted; 
   scatter x = time y = stures;
   refline 0;
run;


proc univariate data = fitted normal;
   var res;  
   qqplot res / normal (L=1 mu=est sigma=est);
   histogram res / normal; 
run;


/*** check constant-variance assumptions ***/
proc glm data = tensile;
   class percent;
   model strength = percent;
   means percent / hovtest = bartlett hovtest = levene;
run;


/*** box-cox transformation ***/
proc transreg data = tensile;
   model boxcox(strength / lambda = -2.0 to 2.0 by 0.1) = class(percent);
run;


/*** Kruskal-Wallis Test ***/
proc npar1way wilcoxon data = tensile;
   class percent;
   var strength;
run;


/*** a complete set of orthogonal contrast ***/
proc glm data = tensile;
   class percent;
   model strength = percent;
   contrast 'C1' percent 0  0  0  1 -1;
   contrast 'C2' percent 1  0  1 -1 -1;
   contrast 'C3' percent 1  0 -1  0  0;
   contrast 'C4' percent 1 -4  1  1  1;
run;


/*** another complete set of orthogonal contrast ***/
proc glm data = tensile;
   class percent;
   model strength = percent;
   contrast 'linear'    percent -2 -1  0  1 2;
   contrast 'quadratic' percent  2 -1 -2 -1 2;
   contrast 'cubic'     percent -1  2  0 -2 1;
   contrast 'quartic'   percent  1 -4  6 -4 1;
run;


/*** multiple comparison ***/
proc glm data = tensile;
   class percent;
   model strength = percent;

   /* Construct CI for Treatment Means*/
   means percent / alpha =.05 lsd clm;
   means percent / alpha =.05 bon clm;

   /* Pairwise Comparison*/
   means percent / alpha = 0.05 lines lsd;
   means percent / alpha = 0.05 lines bon;
   means percent / alpha = 0.05 lines scheffe;
   means percent / alpha = 0.05 lines tukey;
   means percent / alpha = 0.05 dunnett ('15');
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
