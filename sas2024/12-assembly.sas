/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26  
 *********************************************************************/

data assembly;
   input layout$ fixture$ operator time @@;
datalines;
layout1 f1 1 22 layout1 f1 2 23 layout1 f1 3 28 layout1 f1 4 25 
layout1 f1 1 24 layout1 f1 2 24 layout1 f1 3 29 layout1 f1 4 23 
layout1 f2 1 30 layout1 f2 2 29 layout1 f2 3 30 layout1 f2 4 27 
layout1 f2 1 27 layout1 f2 2 28 layout1 f2 3 32 layout1 f2 4 25 
layout1 f3 1 25 layout1 f3 2 24 layout1 f3 3 27 layout1 f3 4 26 
layout1 f3 1 21 layout1 f3 2 22 layout1 f3 3 25 layout1 f3 4 23 
layout2 f1 1 26 layout2 f1 2 27 layout2 f1 3 28 layout2 f1 4 24 
layout2 f1 1 28 layout2 f1 2 25 layout2 f1 3 25 layout2 f1 4 23 
layout2 f2 1 29 layout2 f2 2 30 layout2 f2 3 24 layout2 f2 4 28 
layout2 f2 1 28 layout2 f2 2 27 layout2 f2 3 23 layout2 f2 4 30 
layout2 f3 1 27 layout2 f3 2 26 layout2 f3 3 24 layout2 f3 4 28 
layout2 f3 1 25 layout2 f3 2 24 layout2 f3 3 27 layout2 f3 4 27 
;
proc print data = assembly; run;

proc glm data = assembly;
   class layout fixture operator;
   model time = layout fixture operator(layout) layout*fixture
                fixture*operator(layout);
   random operator(layout) fixture*operator(layout) / test;
run;

proc mixed data = assembly method = type3 cl covtest;
   class layout fixture operator;
   model time = layout fixture layout*fixture;
   random operator(layout) fixture*operator(layout);
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
