/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2023-12-26
 *********************************************************************/

/***** select a random order *****/
data design;
   input trt $ @@;
   randno = ranuni(0);
datalines;
A A A A A
B B B B B B
;

proc sort; by randno;
proc print data = design; run;

/***** data analysis *****/
data fertilizer; 
   input yields trt$ @@;
datalines;
29.9  A  11.4  A  26.6  B  23.7  B
25.3  A  28.5  B  14.2  B  17.9  B
16.5  A  21.1  A  24.3  B
;
proc print data = fertilizer; run;

/***** calculate some descriptive statistics *****/
proc means data = fertilizer; 
   class trt;   
   var yields;
run;

/***** side-by-side boxplot *****/
proc sgplot data = fertilizer;
   vbox yields / category = trt;
run;

/***** two-sample t-test *****/
proc ttest data = fertilizer;
   class trt;
   var yields;
run;

proc ttest data = fertilizer side = L;
   class trt;
   var yields;
run;

/***** randomization test *****/
proc npar1way scores = data data = fertilizer;
   class trt;
   var yields;
   exact scores = data;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
