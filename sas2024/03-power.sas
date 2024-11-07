/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-14 
 *********************************************************************/

proc power;
   onewayanova test = overall
   groupmeans = 11 | 12 | 15 | 18 | 19
   npergroup = 3 to 10 by 1
   stddev = 3
   alpha = 0.01
   power = .;
run;

/*** instead of groupmean, we can specify tau ***/
proc power;
   onewayanova test = overall
   groupmeans = -4 | -3 | 0 | 3 | 4
   npergroup = 3 to 10 by 1
   stddev = 3
   alpha = 0.01
   power = .;
run;

/*** the power does not change if tau are in terms of std ***/
proc power;
   onewayanova test = overall
   groupmeans = -1.3333 | -1 | 0 | 1 | 1.3333
   npergroup = 3 to 10 by 1
   stddev = 1
   alpha = 0.01
   power = .;
run;


/*** the power does not change if tau are in terms of std ***/
proc power;
   onewayanova test = overall
   groupmeans = -2.8284 | -2.8284 | 0 | 2.8284 | 2.8284
   npergroup = 3 to 10 by 1
   stddev = 3
   alpha = 0.01
   power = .;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
