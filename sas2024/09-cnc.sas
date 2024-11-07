/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-12 
 *********************************************************************/

data cnc;
   do E = -1 to 1 by 2; do D = -1 to 1 by 2;
   do C = -1 to 1 by 2; do B = -1 to 1 by 2;
   do A = -1 to 1 by 2; 
   input y @@; logy = log(y);
   F = A * B * C; G = A * B * D; H = B * C * D * E;
   output;
   end; end; end; end; end;
datalines;
2.76  6.18  2.43  4.01  2.48  5.91  2.39  3.35
4.40  4.10  3.22  3.78  5.32  3.87  3.03  2.95
2.64  5.50  2.24  4.28  2.57  5.37  2.11  4.18
3.96  3.27  3.41  4.30  4.44  3.65  4.41  3.40
;
proc print data = cnc; run;

data inter;
   set cnc;
   AB=A*B; AC=A*C; AD=A*D; AE=A*E; AF=A*F; AG=A*G; AH=A*H; BE=B*E;
   BH=B*H; CD=C*D; CE=C*E; CG=C*G; CH=C*H; DE=D*E; DH=D*H; EF=E*F; 
   EG=E*G; EH=E*H; FH=F*H; GH=G*H; ABE=A*B*E; ABH=A*B*H; ACD=A*C*D;

proc glm data = inter outstat=glmout;
   class A B C D E F G H AB AC AD AE AF AG AH BE BH CD CE CG CH DE 
         DH EF EG EH FH GH ABE ABH ACD;
   model logy = A B C D E F G H AB AC AD AE AF AG AH BE BH CD CE CG CH DE 
         DH EF EG EH FH GH ABE ABH ACD;
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goption colors=(none);
%qqplot(inter, logy, A B C D E F G H AB AC AD AE AF AG AH BE BH CD CE CG CH DE 
         DH EF EG EH FH GH ABE ABH ACD);

/********************************************************************* 
 * THE END
 *********************************************************************/
