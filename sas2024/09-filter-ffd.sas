/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-12 
 *********************************************************************/

data filter;
   do C = -1 to 1 by 2; do B = -1 to 1 by 2;
   do A = -1 to 1 by 2; D=A*B*C;
      input y @@; output; 
   end; end; end;
datalines;
 45 100 45 65 75 60 80 96
;
proc print data = filter; run;

data inter;       /* Define Interaction Terms */
   set filter;
   AB=A*B; AC=A*C; AD=A*D;

proc glm data=inter;    /* GLM Proc to Obtain Effects */
   class A B C D AB AC AD;
   model y = A B C D AB AC AD;
   estimate 'A' A -1 1; estimate 'B' B -1 1; estimate 'C' C -1 1;
   estimate 'D' D -1 1; estimate 'AB' AB -1 1; estimate 'AC' AC -1 1;
   estimate 'AD' AD -1 1;  
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goption colors=(none);
%qqplot(inter, y, A B C D AB AC AD);

/********************************************************************* 
 * THE END
 *********************************************************************/
