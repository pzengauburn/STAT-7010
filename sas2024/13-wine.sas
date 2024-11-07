/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data wine;
   input score judge wine;
datalines;
  20  1  1    
  24  1  2    
  28  1  3    
  28  1  4    
  15  2  1    
  18  2  2    
  23  2  3    
  24  2  4    
  18  3  1    
  19  3  2    
  24  3  3    
  23  3  4    
  26  4  1    
  26  4  2    
  30  4  3    
  30  4  4    
  22  5  1    
  24  5  2    
  28  5  3    
  26  5  4    
  19  6  1    
  21  6  2    
  27  6  3    
  25  6  4    
;
proc print data = wine; run;

proc glm data = wine;
   class judge wine;
   model score = judge wine;
run;

/*** correlation structure: compound symmetry ***/

proc mixed data = wine;
   class judge wine;
   model score = wine / s;
   repeated / type = cs subject = judge r;
run;

/*** different SAS code, same results ***/

proc mixed data = wine;
   class judge wine;
   model score = wine;
   random judge;
run;

/*** correlation structure: unstructured ***/

proc mixed data = wine;
   class judge wine;
   model score = wine / s;
   repeated / type = un subject = judge r;
run;

/*** correlation structure: ar(1) ***/

proc mixed data = wine;
   class judge wine;
   model score = wine / s;
   repeated / type = ar(1) subject = judge r;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
