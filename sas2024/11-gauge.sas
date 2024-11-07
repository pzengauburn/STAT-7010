/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data gauge;
   input part operator resp @@;
datalines;
1 1 21 1 1 20 1 2 20 1 2 20 1 3 19 1 3 21
2 1 24 2 1 23 2 2 24 2 2 24 2 3 23 2 3 24
3 1 20 3 1 21 3 2 19 3 2 21 3 3 20 3 3 22
4 1 27 4 1 27 4 2 28 4 2 26 4 3 27 4 3 28
5 1 19 5 1 18 5 2 19 5 2 18 5 3 18 5 3 21
6 1 23 6 1 21 6 2 24 6 2 21 6 3 23 6 3 22
7 1 22 7 1 21 7 2 22 7 2 24 7 3 22 7 3 20
8 1 19 8 1 17 8 2 18 8 2 20 8 3 19 8 3 18
9 1 24 9 1 23 9 2 25 9 2 23 9 3 24 9 3 24
10 1 25 10 1 23 10 2 26 10 2 25 10 3 24 10 3 25
11 1 21 11 1 20 11 2 20 11 2 20 11 3 21 11 3 20
12 1 18 12 1 19 12 2 17 12 2 19 12 3 18 12 3 19
13 1 23 13 1 25 13 2 25 13 2 25 13 3 25 13 3 25
14 1 24 14 1 24 14 2 23 14 2 25 14 3 24 14 3 25
15 1 29 15 1 30 15 2 30 15 2 28 15 3 31 15 3 30
16 1 26 16 1 26 16 2 25 16 2 26 16 3 25 16 3 27
17 1 20 17 1 20 17 2 19 17 2 20 17 3 20 17 3 20
18 1 19 18 1 21 18 2 19 18 2 19 18 3 21 18 3 23
19 1 25 19 1 26 19 2 25 19 2 24 19 3 25 19 3 25
20 1 19 20 1 19 20 2 18 20 2 17 20 3 19 20 3 17
;
proc print data = gauge; run;

/************************************************************/
/*    treat both factors as random effects                  */
/************************************************************/

proc glm data = gauge;
   class operator part;
   model resp = operator | part;
   random operator part operator*part / test;
   test H = operator E = operator*part;
   test H = part E = operator*part;
run;

proc mixed cl covtest method = type1;
   class operator part;
   model resp = ; 
   random operator part operator*part;
run;

/*** method = REML by default ***/
proc mixed cl covtest;
   class operator part;
   model resp = ; 
   random operator part operator*part;
run;

/*** additive model (without interaction) ***/
proc mixed cl covtest method = type1;
   class operator part;
   model resp = ; 
   random operator part;
run;

/************************************************************/
/* part as random effect and operator as fixed effec        */
/************************************************************/

proc glm data = gauge;
   class operator part;
   model resp = operator | part;
   random part operator * part / test;
   means operator / lines tukey E = operator*part;
   lsmeans operator / pdiff adjust = tukey E = operator*part;
run;

proc mixed data = gauge cl covtest;
   class operator part;
   model resp = operator;
   random part operator * part;
   lsmeans operator / cl diff adjust = tukey;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
