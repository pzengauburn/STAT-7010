/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2023-12-26
 *********************************************************************/

/*** calculate power for difference sample size ***/
proc power;
   twosamplemeans test = diff
   alpha = 0.05
   meandiff = 0.5
   stddev = 0.25
   npergroup = 3 to 15 by 1
   power = .;
   plot x = n;
run;

/*** calculate sample size for difference power ***/
proc power;
   twosamplemeans test = diff
   alpha = 0.05
   meandiff = 0.5
   stddev = 0.25
   npergroup = .
   power = 0.80 0.90 0.95 0.99 0.999;
   plot x = power; 
run;

/*** calculate mean difference for difference sample size ***/
proc power;
   twosamplemeans test = diff
   alpha = 0.05
   meandiff = .
   stddev = 0.25
   npergroup = 7 8 9 10 11 12
   power = 0.95;
   plot x = n;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
