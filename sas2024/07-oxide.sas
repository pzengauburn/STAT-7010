/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-20 
 *********************************************************************/

data oxide;
   input A B C D thick1 thick2 thick3 thick4 ybar s2;
   logs = log(s2);
datalines;
 -1 -1 -1 -1  378  376  379  379  378  2.00 
 +1 -1 -1 -1  415  416  416  417  416  0.67 
 -1 +1 -1 -1  380  379  382  383  381  3.33 
 +1 +1 -1 -1  450  446  449  447  448  3.33 
 -1 -1 +1 -1  375  371  373  369  372  6.67 
 +1 -1 +1 -1  391  390  388  391  390  2.00 
 -1 +1 +1 -1  384  385  386  385  385  0.67 
 +1 +1 +1 -1  426  433  430  431  430  8.67 
 -1 -1 -1 +1  381  381  375  383  380  12.00
 +1 -1 -1 +1  416  420  412  412  415  14.67
 -1 +1 -1 +1  371  372  371  370  371  0.67 
 +1 +1 -1 +1  445  448  443  448  446  6.00 
 -1 -1 +1 +1  377  377  379  379  378  1.33 
 +1 -1 +1 +1  391  391  386  400  392  34.00
 -1 +1 +1 +1  375  376  376  377  376  0.67 
 +1 +1 +1 +1  430  430  428  428  429  1.33 
;
proc print data = oxide; run;

data inter; /* Define Interaction Terms */
   set oxide;
   AB=A*B; AC=A*C; AD=A*D; BC=B*C; BD=B*D; CD=C*D; ABC=AB*C; 
   ABD=AB*D; ACD=AC*D; BCD=BC*D; ABCD=ABC*D;
run; 

proc glm data = inter; 
   class A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD;
   model ybar = A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD;
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goption colors = (none);
%qqplot(inter, ybar, A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD);

/********* fit regression model *********/
proc reg data = inter;
   model ybar = A B C AB AC;
run;

/********* QQ-plot when the response is variance *********/
goption colors = (none);
%qqplot(inter, logs, A B C D AB AC AD BC BD CD ABC ABD ACD BCD ABCD);

proc reg data = inter;
   model logs = A B D BD;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
