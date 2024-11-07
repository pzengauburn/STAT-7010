/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-12 
 *********************************************************************/

data layer;
   do A = -1 to 1 by 2; do B = -1 to 1 by 2;
   do C = -1 to 1 by 2; do E = -1 to 1 by 2;
   do L = -1 to 1 by 2; do M = 1 to 4 by 1;
   input y@@; D = - A*B*C; F=A*B*E; G=A*C*E; H=B*C*E;
   output;
   end; end; end; end; end; end;
datalines;
 14.2908  14.1924  14.2714  14.1876  15.3182  15.4279  15.2657  15.4056 
 14.8030  14.7193  14.6960  14.7635  14.9306  14.8954  14.9210  15.1349 
 13.8793  13.9213  13.8532  14.0849  14.0121  13.9386  14.2118  14.0789 
 13.4054  13.4788  13.5878  13.5167  14.2444  14.2573  14.3951  14.3724 
 14.1736  14.0306  14.1398  14.0796  14.1492  14.1654  14.1487  14.2765 
 13.2539  13.3338  13.1920  13.4430  14.2204  14.3028  14.2689  14.4104 
 14.0623  14.0888  14.1766  14.0528  15.2969  15.5209  15.4200  15.2077 
 14.3068  14.4055  14.6780  14.5811  15.0100  15.0618  15.5724  15.4668 
 13.7259  13.2934  12.6502  13.2666  14.9039  14.7952  14.1886  14.6254 
 13.8953  14.5597  14.4492  13.7064  13.7546  14.3229  14.2224  13.8209 
 14.2201  14.3974  15.2757  15.0363  14.1936  14.4295  15.5537  15.2200 
 13.5228  13.5828  14.2822  13.8449  14.5640  14.4670  15.2293  15.1099 
 14.5335  14.2492  14.6701  15.2799  14.7437  14.1827  14.9695  15.5484 
 14.5676  14.0310  13.7099  14.6375  15.8717  15.2239  14.9700  16.0001 
 12.9012  12.7071  13.1484  13.8940  14.2537  13.8368  14.1332  15.1681 
 13.9532  14.0830  14.1119  13.5963  13.8136  14.0745  14.4313  13.6862 
;
proc print data = layer; run;

proc sort data = layer; by A B C E;
proc means noprint data = layer;
   var y; 
   by A B C E;
   output out = layermean mean = ybar var = yvar;
proc print data = layermean; run;


data spring2;
   set layermean;
   D = - A*B*C; F=A*B*E; G=A*C*E; H=B*C*E;
   logs = log(yvar);
proc print data = spring2; run;


data inter; 
   set spring2; 
   AB=A*B; AC=A*C; AE=A*E; BC=B*C; BE=B*E; CE=C*E; ABC=AB*C; ABE=AB*E;
   ACE=AC*E; BCE=BC*E; ABCE=ABC*E;
run;

filename myfile1 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/qqplot_macro.sas";
%include myfile1;

goptions colors=(none);
%qqplot(inter, ybar, A B C E AB AC AE BC BE CE ABC ABE ACE BCE ABCE);
%qqplot(inter, logs, A B C E AB AC AE BC BE CE ABC ABE ACE BCE ABCE);



/************** Response Modeling *************/
data layer2; 
   set layer;
   if M = 1 then xmL = 1;  if M = 1 then xmQ = 1;  if M = 1 then xmC = 1;
   if M = 2 then xmL = 1;  if M = 2 then xmQ = -1; if M = 2 then xmC = -1;
   if M = 3 then xmL = -1; if M = 3 then xmQ = -1; if M = 3 then xmC = 1;
   if M = 4 then xmL = -1; if M = 4 then xmQ = 1;  if M = 4 then xmC = -1;

data inter2;
   set layer2;
   AB=A*B; AC=A*C; AE=A*E; BC=B*C; BE=B*E; CE=C*E; ABC=AB*C; ABE=AB*E;
   ACE=AC*E; BCE=BC*E; ABCE=ABC*E;
   HL = H*L; CxmL = C * xmL; AHxmQ = A * H * xmQ;
   
proc reg data = inter2;
   model y = D H L xmL HL CxmL AHxmQ;
run;

/****** interaction plot *********/

filename myfile2 url "http://www.auburn.edu/~zengpen/teaching/SAS-template/interplot2_macro.sas";
%include myfile2;

%interplot2(layer, y, L, H);
%interplot2(layer, y, M, C);


data interAHM;
   set layer;
   if A = 1 and H = 1 then AH = 'A+H+';
   if A = 1 and H =-1 then AH = 'A+H-';
   if A =-1 and H = 1 then AH = 'A-H+';
   if A =-1 and H =-1 then AH = 'A-H-';
run;

%interplot2(interAHM, y, M, AH);

/********************************************************************* 
 * THE END
 *********************************************************************/
