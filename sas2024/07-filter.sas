/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-20 
 *********************************************************************/

data filter;
   do D = -1 to 1 by 2; 
     do C = -1 to 1 by 2;
       do B = -1 to 1 by 2; 
         do A = -1 to 1 by 2;
           input y @@;  
           output;
         end; 
        end; 
       end; 
      end;
datalines;
45 71 48 65 68 60 80 65 43 100 45 104 75 86 70 96
;
proc print data = filter; run;

data inter;                       /* Define Interaction Terms */
   set filter;
   AB=A*B; AC=A*C; AD=A*D; BC=B*C; BD=B*D; CD=C*D; ABC=AB*C; 
   ABD=AB*D; ACD=AC*D; BCD=BC*D; ABCD=ABC*D;
run; 

proc glm data = inter;           /* GLM Proc to Obtain Effects */
   class A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD;
   model y = A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD;
   estimate 'A' A 1 -1;
   estimate 'AC' AC 1 -1;
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goptions colors = (none);
%qqplot(inter, y, A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD);

/*** refined model ***/

proc glm data = filter;
   class A C D;
   model y = A | C | D;
run;

proc reg data = inter; 
   model y = A C D AC AD;
   output out = outres r = res p = pred;
run;

proc sgplot data = outres; 
   scatter y = res x = pred;
   refline 0; 
run;

/*** contour plot ***/
data one;
   do x1 = -1 to 1 by .1;
      do x3 = -1 to 1 by .1;
        y = 77.37 + 19.12 * x1 + 4.94 * x3 - 9.06 * x1 * x3; 
        output;
      end; 
   end;

proc gcontour data = one; 
   plot x3 * x1 = y / autolabel;
run; 

/********************************************************************* 
 * THE END
 *********************************************************************/
