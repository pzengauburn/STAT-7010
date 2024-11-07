/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data impurity;
   input pressure temp y @@;
datalines;
25 100 5 30 100 4 35 100 6 40 100 3 45 100 5
25 125 3 30 125 1 35 125 4 40 125 2 45 125 3
25 150 1 30 150 1 35 150 3 40 150 1 45 150 2
;
proc print data = impurity; run;

/*** interaction plots ***/

proc means data = impurity;
   class temp pressure;
   var y;
   output out = impurity_mean mean = y_mean std = std;
run;

proc sgplot data = impurity_mean;
   series x = temp y = y_mean / group = pressure markers;
   where _type_ = 3;
run;

proc sgplot data = impurity_mean;
   series x = pressure y = y_mean / group = temp markers;
   where _type_ = 3;
run;

/*** model with interaction ***/

proc glm data = impurity;
   class temp pressure;
   model y = temp | pressure;
run;

/*** model without interaction ***/

proc glm data = impurity;
   class temp pressure;
   model y = temp pressure;
run;

/*** Tukey's Test for non-additivity ***/

proc glm data = impurity;
   class temp pressure;
   model y = temp pressure;
   output out = fitted p = yhat;
run;

data new;
   set fitted;
   q = yhat * yhat;
run;

proc glm data = new;
   class temp pressure;
   model y = temp pressure q;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
