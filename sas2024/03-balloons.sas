/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-14 
 *********************************************************************/

data balloons;
   input order color $ time;
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

/*** some descriptive statistics ***/
proc means data = balloons n mean std clm;
   class color; 
   var time;
run;

/*** one-way ANOVA model ***/
proc glm data = balloons;
   class color; 
   model time = color;
run;


/*** check model assumptions ***/
proc glm data = balloons;
   class color; 
   model time = color;
   means color / hovtest = bartlett hovtest = levene;
   output out = fitted p = pred r = res student=stures;
run;

proc sgplot data = fitted;
   scatter x = pred y = res;
   refline 0;
run;

proc sgplot data = fitted;
   scatter x = pred y = stures;
   refline 0;
run;

proc sgplot data = fitted;
   scatter x = order y = res;
   refline 0;
run;

proc univariate data = fitted normal;
   var res;  
   qqplot res / normal (L=1 mu=est sigma=est);
   histogram res / normal; 
run;


/*** estimate contrast ***/
proc glm data = balloons;
   class color; 
   model time = color / clparm;
   estimate 'yellow-orange'  color 0 -1 0 1;
   estimate 'y-o versus p-b'  color 0.5 -0.5 0.5 -0.5;
run;

/*** orthogonal contrast ***/
proc glm data = balloons;
   class color; 
   model time = color / clparm;
   contrast 'blue-pink'      color 1  0 -1  0;
   contrast 'yellow-orange'  color 0  1  0 -1;
   contrast 'y-o versus p-b' color 1 -1  1 -1;
run;


/*** multiple comparison ***/
proc glm data = balloons;
   class color;
   model time = color;

   /* Construct CI for Treatment Means*/
   means color / alpha =.05 lsd clm;
   means color / alpha =.05 bon clm;

   /* Pairwise Comparison*/
   means color / alpha = 0.05 lines lsd;
   means color / alpha = 0.05 lines bon;
   means color / alpha = 0.05 lines scheffe;
   means color / alpha = 0.05 lines tukey;
   means color / alpha = 0.05 dunnett ('y');
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
