/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data bottling;
   input percent pressure speed dev @@;
datalines;
10 25 200 -3   10 25 200 -1    10 25 250 -1   10 25 250  0
12 25 200  0   12 25 200  1    12 25 250  2   12 25 250  1
14 25 200  5   14 25 200  4    14 25 250  7   14 25 250  6
10 30 200 -1   10 30 200  0    10 30 250  1   10 30 250  1
12 30 200  2   12 30 200  3    12 30 250  6   12 30 250  5
14 30 200  7   14 30 200  9    14 30 250 10   14 30 250 11
;
proc print data = bottling; run;

/*** interaction plot ***/

proc means data = bottling;
   class percent pressure speed;
   var dev;
   output out = bottling_mean mean = dev_mean std = std;
run;

proc sgplot data = bottling_mean;
   series x = speed y = dev_mean / group = pressure markers;
   where _type_ = 3;
run;

proc sgplot data = bottling_mean;
   series x = pressure y = dev_mean / group = speed markers;
   where _type_ = 3;
run;

proc sgplot data = bottling_mean;
   series x = percent y = dev_mean / group = speed markers;
   where _type_ = 5;
run;

proc sgplot data = bottling_mean;
   series x = speed y = dev_mean / group = percent markers;
   where _type_ = 5;
run;

proc sgplot data = bottling_mean;
   series x = percent y = dev_mean / group = pressure markers;
   where _type_ = 6;
run;

proc sgplot data = bottling_mean;
   series x = pressure y = dev_mean / group = percent markers;
   where _type_ = 6;
run;

/*** three-way ANOVA ***/

proc glm data = bottling;
   class percent pressure speed;
   model dev = percent | pressure | speed;
run;

/*** pool insignificant SS to error ***/
proc glm data = bottling;
   class percent pressure speed;
   model dev = percent | pressure | speed @2;
run;

/*** pool insignificant SS to error ***/

proc glm data = bottling;
   class percent pressure speed;
   model dev = percent pressure speed percent * pressure;
run;

/*** multiple comparison ***/

proc glm data = bottling;
   class percent pressure speed;
   model dev = percent pressure speed percent * pressure;
   means speed / tukey bon;
   lsmeans percent * pressure / pdiff adjust = tukey;
   lsmeans percent * pressure / pdiff adjust = bon;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
