/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data loom;
   input loom strength @@;
datalines;
1 98   1 97   1 99   1 96
2 91   2 90   2 93   2 92
3 96   3 95   3 97   3 95
4 95   4 96   4 99   4 98
;
proc print data = loom; run;

proc glm data = loom;
   class loom;
   model strength = loom;
   random loom;
run;

proc varcomp data = loom method = type1;
   class loom;
   model strength = loom;
run;

proc mixed data = loom cl;
   class loom;
   model strength = ;
   random loom;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
