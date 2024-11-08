/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data bloodflow;
   input y person A B;
datalines;
   2   1  1  1
  -1   2  1  1
   0   3  1  1
   3   4  1  1
   1   5  1  1
   2   6  1  1
  -2   7  1  1
   4   8  1  1
  -2   9  1  1
  -2  10  1  1
   2  11  1  1
  -1  12  1  1
  10   1  1  2
   8   2  1  2
  11   3  1  2
  15   4  1  2
   5   5  1  2
  12   6  1  2
  10   7  1  2
  16   8  1  2
   7   9  1  2
  10  10  1  2
   8  11  1  2
   8  12  1  2
   9   1  2  1
   6   2  2  1
   8   3  2  1
  11   4  2  1
   6   5  2  1
   9   6  2  1
   8   7  2  1
  12   8  2  1
   7   9  2  1
  10  10  2  1
  10  11  2  1
   6  12  2  1
  25   1  2  2
  21   2  2  2
  24   3  2  2
  31   4  2  2
  20   5  2  2
  27   6  2  2
  22   7  2  2
  30   8  2  2
  24   9  2  2
  28  10  2  2
  25  11  2  2
  23  12  2  2
;
proc print data = bloodflow; run;

proc mixed data = bloodflow;
   class person A B;
   model y = A B A*B;
   repeated / type = cs subject = person r;
run;

/*** use random effect, instead of repeated measures ***/
/*** same results                                    ***/
proc mixed data = bloodflow cl covtest;
   class person A B;
   model y = A B A*B;
   random person;
run;

proc glm data = bloodflow;
   class person A B;
   model y = A B A*B person;
   random person / test;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
