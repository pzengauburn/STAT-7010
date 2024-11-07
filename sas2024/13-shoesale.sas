/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

data shoesale;
   input y maket A B;
datalines;
    958  1  1  1
   1005  2  1  1
    351  3  1  1
    549  4  1  1
    730  5  1  1
   1047  1  1  2
   1122  2  1  2
    436  3  1  2
    632  4  1  2
    784  5  1  2
    933  1  1  3
    986  2  1  3
    339  3  1  3
    512  4  1  3
    707  5  1  3
    780  1  2  1
    229  2  2  1
    883  3  2  1
    624  4  2  1
    375  5  2  1
    897  1  2  2
    275  2  2  2
    964  3  2  2
    695  4  2  2
    436  5  2  2
    718  1  2  3
    202  2  2  3
    817  3  2  3
    599  4  2  3
    351  5  2  3
;
proc print data = shoesale; run;

proc glm data = shoesale;
   class maket A B;
   model y = maket(A) A B A*B;
   random maket(A) / test;
run;

proc mixed data = shoesale method = type1 cl covtest;
   class maket A B;
   model y = A B A*B;
   random maket(A);
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
