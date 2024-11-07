/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data toollife;
   input angle speed life @@;
datalines;
15 125 -2   15 150 -3   15 175  2
15 125 -1   15 150  0   15 175  3
20 125  0   20 150  1   20 175  4
20 125  2   20 150  3   20 175  6
25 125 -1   25 150  5   25 175  0
25 125  0   25 150  6   25 175 -1
;
proc print data = toollife; run;

/*** interaction plots ***/

proc means data = toollife;
   class angle speed;
   var life;
   output out = toollife_mean mean = mean_life std = std;
run;

proc sgplot data = toollife_mean;
   series x = angle y = mean_life / group = speed markers;
   where _type_ = 3;
run;
   
proc sgplot data = toollife_mean;
   series x = speed y = mean_life / group = angle markers;
   where _type_ = 3;
run;

/*** contrasts ***/

proc glm data = toollife;
   class angle speed;
   model life = angle speed angle*speed;
   contrast 'a-L' angle -1  0 1;
   contrast 'a-Q' angle  1 -2 1;
   contrast 's-L' speed -1  0 1;
   contrast 's-Q' speed  1 -2 1;
   contrast 'a-L-s-L' angle*speed  1  0 -1  0 0  0 -1  0 1;
   contrast 'a-L-s-Q' angle*speed -1  2 -1  0 0  0  1 -2 1;
   contrast 'a-Q-s-L' angle*speed -1  0  1  2 0 -2 -1  0 1;
   contrast 'a-Q-s-Q' angle*speed  1 -2  1 -2 4 -2  1 -2 1;
run;

/*** response surface ***/

data toollife2;
   set toollife;
   angle2 = angle * angle;
   speed2 = speed * speed;
   anglespeed = angle * speed;
run;

proc reg data = toollife2;
   model life = angle speed angle2 speed2 anglespeed;
run;

data new;
   do angle = 15 to 25 by 1;
   do speed = 125 to 175 by 5;
     y = - 100 + 4.567 * angle + 0.693 * speed - 0.080 * angle * angle
         - 0.0016 * speed * speed - 0.008 * angle * speed;
   output;
   end; end;
run;

proc gcontour data = new;
   plot angle * speed = y / autolabel;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
