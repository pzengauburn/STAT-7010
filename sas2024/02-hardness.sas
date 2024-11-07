/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2023-12-26
 *********************************************************************/

data hardness;
   input tip1 tip2;
   diff = tip1 - tip2;
datalines;
7 6
3 3
3 5
4 3
8 8
3 2
2 4
9 9
5 4
4 5
;
proc print data = hardness; run;

/***** calculate some descriptive statistics *****/
proc means data = hardness n mean std clm;
   var diff;
run;

/***** paired two-sample t-test *****/
proc ttest data = hardness;
   paired tip1 * tip2;
run;

data hardness2;
   input tip hardness @@;
datalines;
1 7 2 6
1 3 2 3
1 3 2 5
1 4 2 3
1 8 2 8
1 3 2 2
1 2 2 4
1 9 2 9
1 5 2 4
1 4 2 5
;
proc print data = hardness2; run;

/***** two-sample t-test *****/
proc ttest data = hardness2;
   class tip;
   var hardness;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
