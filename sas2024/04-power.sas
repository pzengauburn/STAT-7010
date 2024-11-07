/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data exemplary;
  input variety exposure height @@;
datalines;
1 1 14  1 2 16  1 3 21
2 1 10  2 2 15  2 3 16
;
proc print data = exemplary; run;

proc glmpower data = exemplary;
  class variety exposure;
  model height = variety | exposure;
  power stddev = 5
        ntotal = 60
        power  = .;
  plot x = n min = 30 max = 90;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
