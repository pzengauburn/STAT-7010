/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-20 
 *********************************************************************/

data filter;
   do D = -1 to 1 by 2;do C = -1 to 1 by 2;
   do B = -1 to 1 by 2;do A = -1 to 1 by 2;
   input y @@; output;
   end; end; end; end;
datalines;
25 71 48 45 68 40 60 65 43 80 25 104 55 86 70 76
;
proc print data = filter; run;

data inter;
   set filter; 
   AB=A*B; AC=A*C; AD=A*D; BC=B*C; BD=B*D; CD=C*D; ABC=AB*C;
   ABD=AB*D; ACD=AC*D; BCD=BC*D; block=ABC*D;
run; 

proc glm data=inter;
   class A B C D AB AC AD BC BD CD ABC ABD ACD BCD block;
   model y = block A B C D AB AC AD BC BD CD ABC ABD ACD BCD; 
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goption colors=(none);
%qqplot(inter, y, A B C D AB AC AD BC BD CD ABC ABD ACD BCD block);

/********************************************************************* 
 * THE END
 *********************************************************************/
