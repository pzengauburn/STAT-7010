/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-10 
 *********************************************************************/

data propellant;
   input material operator trt$ resp @@;
datalines;
1 1 A 24   1 2 B 20   1 3 C 19   1 4 D 24   1 5 E 24
2 1 B 17   2 2 C 24   2 3 D 30   2 4 E 27   2 5 A 36
3 1 C 18   3 2 D 38   3 3 E 26   3 4 A 27   3 5 B 21
4 1 D 26   4 2 E 31   4 3 A 26   4 4 B 23   4 5 C 22
5 1 E 22   5 2 A 30   5 3 B 20   5 4 C 29   5 5 D 31
;
proc print data = propellant; run;

/*** ANOVA and chech model assumptions ***/

proc glm data = propellant;
   class material operator trt;
   model resp = trt material operator;
   means trt / lines tukey;
   means material operator;
   output out = diag r = res p = pred;
run;

proc sgplot data = diag;
   scatter y = res  x = pred;
   refline 0;
run;

proc univariate normal data = diag;
   histogram res / normal;
   qqplot res / normal (L = 1 mu = 0 sigma = est);
run;

/*** Graeco-Latin square ***/

data propellant2;
   input material operator trt$ assembly$ resp @@;
datalines;
1 1 A a 24   1 2 B c 20   1 3 C e 19   1 4 D b 24   1 5 E d 24
2 1 B b 17   2 2 C d 24   2 3 D a 30   2 4 E c 27   2 5 A e 36
3 1 C c 18   3 2 D e 38   3 3 E b 26   3 4 A d 27   3 5 B a 21
4 1 D d 26   4 2 E a 31   4 3 A c 26   4 4 B e 23   4 5 C b 22
5 1 E e 22   5 2 A b 30   5 3 B d 20   5 4 C a 29   5 5 D c 31
;
proc print data = propellant2; run;

proc glm data = propellant2;
   class material operator trt assembly;
   model resp = trt material operator assembly;
   means trt / lines tukey;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
