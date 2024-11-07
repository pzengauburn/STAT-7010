/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-12 
 *********************************************************************/

data molding;
   do D = -1 to 1 by 2;
   do C = -1 to 1 by 2;
   do B = -1 to 1 by 2; do A = -1 to 1 by 2; 
   E=A*B*C; F=B*C*D;
   input y @@; output; 
   end; end; end; end;
datalines;
 6 10 32 60 4 15 26 60 8 12 34 60 16 5 37 52
;
proc print data = molding; run;

data inter;       /* Define Interaction Terms */
   set molding;
   AB=A*B; AC=A*C; AD=A*D; AE=A*E; AF=A*F; BD=B*D; 
   BF=B*F; ABD=A*B*D; ACD=A*C*D;

proc glm data=inter;    /* GLM Proc to Obtain Effects */
   class A B C D E F AB AC AD AE AF BD BF ABD ACD;
   model y=A B C D E F AB AC AD AE AF BD BF ABD ACD;
   estimate 'A' A -1 1; estimate 'B' B -1 1; estimate 'C' C -1 1;
   estimate 'D' D -1 1; estimate 'E' E -1 1; estimate 'F' F -1 1;
   estimate 'AB' AB -1 1; estimate 'AC' AC -1 1; estimate 'AD' AD -1 1;
   estimate 'AE' AE -1 1; estimate 'AF' AF -1 1; estimate 'BD' BD -1 1;
   estimate 'BF' BF -1 1; estimate 'ABD' ABD -1 1; estimate 'ACD' ACD -1 1;
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goption colors=(none);
%qqplot(inter, y, A B C D E F AB AC AD AE AF BD BF ABD ACD);

/**************************/

proc reg data = inter;
   model y = A B AB AD ACD;
run;

proc reg data=inter;
   model y = A B AB;
run;

data inter3;       /* Define Interaction Terms */
   set molding;
   AB=A*B; AC=A*C; AD=A*D; AE=A*E; AF=A*F; BD=B*D; BF=B*F; 
   ABD=A*B*D; ACD=A*C*D;
   if B=-1 and F=-1 then SBF='B-F-';
   if B=-1 and F=1  then SBF='B-F+';
   if B=1  and F=-1 then SBF='B+F-';
   if B=1  and F=1  then SBF='B+F+';
proc print data = inter3; run;


filename myfile2 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/interplot2_macro.sas";
%include myfile2;

%interplot2(inter3, y, A, SBF);

/********************************************************************* 
 * THE END
 *********************************************************************/
