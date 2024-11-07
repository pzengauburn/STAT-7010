/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data nail;
   input order solvent varnish time;
datalines;
 1   2 3 32.50
 2   1 3 30.20
 3   1 3 27.25
 4   2 3 24.25
 5   2 2 34.42
 6   2 2 26.00
 7   1 2 22.50
 8   2 2 31.08
 9   1 2 25.17
 10  2 1 29.17
 11  1 1 27.58
 12  1 1 28.75
 13  2 1 31.75
 14  1 3 29.75
 15  2 3 30.75
 16  2 2 29.17
 17  1 2 27.75
 18  1 1 25.83
 19  2 2 24.75
 20  1 2 21.50
 21  2 1 32.08
 22  2 3 29.50
 23  1 3 24.50
 24  2 1 28.50
 25  2 3 28.75
 26  1 3 22.75
 27  1 1 29.25
 28  2 1 31.25
 29  1 1 22.08
 30  1 2 25.00
;
proc print data = nail; run;

/*** interaction plots ***/

proc means data = nail;
   class solvent varnish;
   var time;
   output out = nail_mean mean = time_mean std = std;
run;

proc sgplot data = nail_mean;
   series x = varnish y = time_mean / group = solvent markers;
   where _type_ = 3;
run;

proc sgplot data = nail_mean;
   series x = solvent y = time_mean / group = varnish markers;
   where _type_ = 3;
run;

proc glm data = nail;
   class solvent varnish;
   model time = solvent | varnish;
run;

proc glm data = nail;
   class solvent varnish;
   model time = solvent varnish;
   means solvent varnish / tukey bon;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
