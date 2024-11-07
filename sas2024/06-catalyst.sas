/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-10 
 *********************************************************************/

data catalyst;
   input trt block resp @@;
datalines;
1 1 73 1 2 74 1 4 71 2 2 75 2 3 67 2 4 72
3 1 73 3 2 75 3 3 68 4 1 75 4 3 72 4 4 75
;
proc print data = catalyst; run;

proc glm data = catalyst;
   class block trt;
   model resp = block trt;
   lsmeans trt / tdiff pdiff adjust = bon stderr;
   lsmeans trt / pdiff adjust = tukey;
   contrast 'a' trt 1 -1 0 0;
   estimate 'b' trt 0 0 1 -1;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
