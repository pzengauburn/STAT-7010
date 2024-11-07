/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data balloons;
   input order color $ time;
   x = order - 16.5;
datalines;
  1 p 22.0
  2 o 24.6
  3 p 20.3
  4 b 19.8
  5 o 24.3
  6 y 22.2
  7 y 28.5
  8 y 25.7
  9 o 20.2
 10 p 19.6
 11 y 28.8
 12 b 24.0
 13 b 17.1
 14 b 19.3
 15 o 24.2
 16 p 15.8
 17 y 18.3
 18 p 17.5
 19 b 18.7
 20 o 22.9
 21 p 16.3
 22 b 14.0
 23 b 16.6
 24 y 18.1
 25 y 18.9
 26 b 16.0
 27 y 20.1
 28 o 22.5
 29 o 16.0
 30 p 19.3
 31 p 15.9
 32 o 20.3 
;
proc print data = balloons; run;

/*** side-by-side boxplots ***/
proc sgplot data = balloons;
   vbox time / category = color;
run;

/*** one-way ANOVA when x is not included ***/
proc glm data = balloons;
   class color;
   model time = color / clparm;
   estimate 'b-o' color 1 -1 0 0;
   estimate 'b-p' color 1 0 -1 0;
   estimate 'b-y' color 1 0 0 -1;
   estimate 'o-p' color 0 1 -1 0;
   estimate 'o-y' color 0 1 0 -1;
   estimate 'p-y' color 0 0 1 -1;
   means color / tukey bon;
run;

/*** one-way ANOVA. check model assumptions ***/
proc glm data = balloons;
   class color; 
   model time = color;
   means color / hovtest = bartlett hovtest = levene;
   output out = fitted p = pred r = res;
run;

proc sgplot data = fitted;
   scatter y = res x = pred;
   refline 0; 
run;

proc sgplot data = fitted;
   scatter y = res x = order;
   refline 0; 
run;

proc univariate data = fitted normal;
   var res;  
   qqplot res / normal (L=1 mu=est sigma=est);
   histogram res / normal; 
run;

/*** ANCOVA. include x ***/

proc glm data = balloons;
   class color; 
   model time = color x / solution;
   output out = fitted p = pred r = res;
run;

proc sgplot data = fitted;
   scatter y = res x = pred;
   refline 0; 
run;

proc sgplot data = fitted;
   scatter y = res x = order;
   refline 0; 
run;

proc univariate data = fitted normal;
   var res;  
   qqplot res / normal (L=1 mu = est sigma = est);
   histogram res / normal; 
run;

/*** constrast and multiple comparison ***/

proc glm data = balloons;
   class color;
   model time = color x / clparm;
   estimate 'b-o' color 1 -1 0 0;
   estimate 'b-p' color 1 0 -1 0;
   estimate 'b-y' color 1 0 0 -1;
   estimate 'o-p' color 0 1 -1 0;
   estimate 'o-y' color 0 1 0 -1;
   estimate 'p-y' color 0 0 1 -1;
   means color / tukey bon;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
