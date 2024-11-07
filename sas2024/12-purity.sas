/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data purity;
   input supplier batch purity @@;
datalines;
 1 1 94  1 2 91  1 3 91  1 4 94 
 1 1 92  1 2 90  1 3 93  1 4 97 
 1 1 93  1 2 89  1 3 94  1 4 93 
 2 1 94  2 2 93  2 3 92  2 4 93 
 2 1 91  2 2 97  2 3 93  2 4 96 
 2 1 90  2 2 95  2 3 91  2 4 95 
 3 1 95  3 2 91  3 3 94  3 4 96 
 3 1 97  3 2 93  3 3 92  3 4 95 
 3 1 93  3 2 95  3 3 95  3 4 94 
 ;
proc print data = purity; run;

/*** batch is nested within supplier ***/

proc glm data = purity;
    class supplier batch;
    model purity = supplier batch(supplier);
	random batch(supplier) / test;
run;

/*** wrong analysis. two-factor factorial design ***/

proc glm data = purity;
    class supplier batch;
    model purity = supplier batch batch*supplier;
	random batch batch*supplier / test;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
