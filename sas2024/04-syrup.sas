/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data syrup;
   input nozzle speed pressure loss @@;
datalines;
1 100 10  -35  1 120 10 -45  1 140 10 -40
1 100 10  -25  1 120 10 -60  1 140 10 15  
1 100 15  110  1 120 15 -10  1 140 15 80  
1 100 15  75   1 120 15 30   1 140 15 54  
1 100 20  4    1 120 20 -40  1 140 20 31  
1 100 20  5    1 120 20 -30  1 140 20 36  
2 100 10 17    2 120 10 -65  2 140 10 20  
2 100 10 24    2 120 10 -58  2 140 10 4   
2 100 15 55    2 120 15 -55  2 140 15 110 
2 100 15 120   2 120 15 -44  2 140 15 44  
2 100 20 -23   2 120 20 -64  2 140 20 -20 
2 100 20 -5    2 120 20 -62  2 140 20 -31 
3 100 10 -39   3 120 10 -55  3 140 10 15  
3 100 10 -35   3 120 10 -67  3 140 10 -30 
3 100 15 90    3 120 15 -28  3 140 15 110 
3 100 15 113   3 120 15 -26  3 140 15 135 
3 100 20 -30   3 120 20 -61  3 140 20 54  
3 100 20 -55   3 120 20 -52  3 140 20 4   
;
proc print data = syrup; run;

/*** interaction plots ***/

proc means data = syrup;
   class nozzle speed pressure;
   var loss;
   output out = syrup_mean mean = loss_mean std = std;
run;

proc sgplot data = syrup_mean;
   series x = speed y = loss_mean / group = pressure markers;
   where _type_ = 3;
run;

proc sgplot data = syrup_mean;
   series x = pressure y = loss_mean / group = speed markers;
   where _type_ = 3;
run;

proc sgplot data = syrup_mean;
   series x = nozzle y = loss_mean / group = pressure markers;
   where _type_ = 5;
run;

proc sgplot data = syrup_mean;
   series x = pressure y = loss_mean / group = nozzle markers;
   where _type_ = 5;
run;

proc sgplot data = syrup_mean;
   series x = speed y = loss_mean / group = nozzle markers;
   where _type_ = 6;
run;

proc sgplot data = syrup_mean;
   series x = nozzle y = loss_mean / group = speed markers;
   where _type_ = 6;
run;

/*** three-way ANOVA ***/

proc glm data = syrup;
   class nozzle speed pressure;
   model loss = nozzle | speed | pressure;
run;

proc glm data = syrup;
   class nozzle speed pressure;
   model loss = nozzle | speed | pressure @2;
run;

/*** response surface ***/

data inter;
   set syrup;
   s2 = speed * speed;
   p2 = pressure * pressure;
   sp = speed * pressure;

proc sort data = inter; by nozzle;
proc reg data = inter;
   model loss = speed pressure s2 p2 sp;
   by nozzle;
run;

/******************/

data n1;
   do speed = 100 to 140 by 0.1;
   do pressure = 10 to 20 by 0.05;
   y = 1217.3 - 31.256 * speed + 86.017 * pressure + 0.12917 * speed * speed 
      - 2.8733 * pressure * pressure + 0.02875 * pressure * speed;
   output;
   end; end;

proc gcontour data = n1;
   plot speed * pressure = y / autolabel;
run;


data n2;
   do speed = 100 to 140 by 0.1;
   do pressure = 10 to 20 by 0.05;
   y = 2526.667 - 50.69167 * speed + 70.75 * pressure + 0.21063 * speed * speed 
      - 2.41 * pressure * pressure - 0.0075 * pressure * speed;
   output;
   end; end;

proc gcontour data = n2;
   plot speed * pressure = y / autolabel;
run;


data n3;
   do speed = 100 to 140 by 0.1;
   do pressure = 10 to 20 by 0.05;
   y = 1940.1 - 46.058 * speed + 102.48 * pressure + 0.18958 * speed * speed 
      - 3.7967 * pressure * pressure + 0.105 * pressure * speed;
   output;
   end; end;

proc gcontour data = n3;
   plot speed * pressure = y / autolabel;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
