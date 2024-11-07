/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data pulp;
   input day temp method y @@;
datalines;
1 200 1 30  1 200 2 34  1 200 3 29
1 225 1 35  1 225 2 41  1 225 3 26
1 250 1 37  1 250 2 38  1 250 3 33
1 275 1 36  1 275 2 42  1 275 3 36
2 200 1 28  2 200 2 31  2 200 3 31
2 225 1 32  2 225 2 36  2 225 3 30
2 250 1 40  2 250 2 42  2 250 3 32
2 275 1 41  2 275 2 40  2 275 3 40
3 200 1 31  3 200 2 35  3 200 3 32
3 225 1 37  3 225 2 40  3 225 3 34
3 250 1 41  3 250 2 39  3 250 3 39
3 275 1 40  3 275 2 44  3 275 3 45
;
proc print data = pulp; run;

proc glm data = pulp;
   class day temp method;
   model y = day | temp | method;
   random day day*method day*temp day*temp*method / test;
run;

proc mixed data = pulp method=type3;
   class day temp method;
   model y = temp method temp*method;
   random day day*method day*temp day*temp*method;
run;

/**** alternative method ****/

proc glm data = pulp;
   class day temp method;
   model y = day method day*method temp temp*method;
   random day day*method / test;
run;

proc mixed data = pulp method = type3 cl covtest;
   class day temp method;
   model y = temp method temp*method;
   random day day*method;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
