/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data turbine;
   input temp operator gauge y @@;
datalines;
60 1 1 -2  60 2 1  0  60 3 1 -1  60 4 1  4 
60 1 1 -3  60 2 1 -9  60 3 1 -8  60 4 1  4 
60 1 2 -6  60 2 2 -5  60 3 2 -8  60 4 2 -3 
60 1 2  4  60 2 2 -1  60 3 2 -2  60 4 2 -7 
60 1 3 -1  60 2 3 -4  60 3 3  0  60 4 3 -2 
60 1 3 -2  60 2 3 -8  60 3 3 -7  60 4 3  4 
75 1 1 14  75 2 1 6   75 3 1 1   75 4 1 -7 
75 1 1 14  75 2 1 0   75 3 1 2   75 4 1  6 
75 1 2 22  75 2 2 8   75 3 2 6   75 4 2 -5 
75 1 2 24  75 2 2 6   75 3 2 2   75 4 2  2 
75 1 3 20  75 2 3 2   75 3 3 3   75 4 3 -5 
75 1 3 16  75 2 3 0   75 3 3 0   75 4 3 -1 
90 1 1 -8  90 2 1 -2  90 3 1 -1  90 4 1 -2 
90 1 1 -8  90 2 1 20  90 3 1 -2  90 4 1  1 
90 1 2 -8  90 2 2  1  90 3 2 -9  90 4 2 -8 
90 1 2  3  90 2 2 -7  90 3 2 -8  90 4 2  3 
90 1 3 -2  90 2 3 -1  90 3 3 -4  90 4 3  1 
90 1 3 -1  90 2 3 -2  90 3 3 -7  90 4 3  3 
;
proc print data = turbine; run;

proc glm data = turbine;
   class temp operator gauge;
   model y = temp | operator | gauge;
   random operator gauge operator*gauge temp*gauge temp*operator temp*gauge*operator / test;
run;


proc mixed data = turbine cl covtest method = type1;
   class temp operator gauge;
   model y = temp;
   random operator gauge operator*gauge temp*gauge temp*operator temp*gauge*operator;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
