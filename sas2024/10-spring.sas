/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-12 
 *********************************************************************/

data spring;
   do D = 1 to -1 by -2; do C = 1 to -1 by -2;
   do B = -1 to 1 by 2;  do Q = -1 to 1 by 2;
   do rep = 1 to 3 by 1;
   input y @@; E = B*C*D; output;
   end; end; end; end; end;
datalines;
 7.78  7.78  7.81  7.50  7.25  7.12 
 8.15  8.18  7.88  7.88  7.88  7.44 
 7.50  7.56  7.50  7.50  7.56  7.50 
 7.59  7.56  7.75  7.63  7.75  7.56 
 7.94  8.00  7.88  7.32  7.44  7.44 
 7.69  8.09  8.06  7.56  7.69  7.62 
 7.56  7.62  7.44  7.18  7.18  7.25 
 7.56  7.81  7.69  7.81  7.50  7.59 
;
proc print data = spring; run;

proc sort data = spring; by B C D E;
proc means data = spring; 
   var y;
   by B C D E;
   output out = springmean mean = ybar var = yvar;
run;

data inter;
   set springmean;
   BC = B*C; BD = B*D; BE = B*E; logs = log(yvar);
run;


/********** QQ-plot for location and dispersion model ***********/
filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goptions colors=(none);
%qqplot(inter, ybar, B C D E BC BD BE);
%qqplot(inter, logs, B C D E BC BD BE);

/********************************************************************* 
 * THE END
 *********************************************************************/
