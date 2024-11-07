/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-01-23 
 *********************************************************************/

data battery;
   input material temp life @@;
datalines;
1  15 130   1  15 155   1  15  74   1  15 180
2  15 150   2  15 188   2  15 159   2  15 126
3  15 138   3  15 110   3  15 168   3  15 160
1  70  34   1  70  40   1  70  80   1  70  75
2  70 136   2  70 122   2  70 106   2  70 115
3  70 174   3  70 120   3  70 150   3  70 139
1 125  20   1 125  70   1 125  82   1 125  58
2 125  25   2 125  70   2 125  58   2 125  45
3 125  96   3 125 104   3 125  82   3 125  60
;
proc print data = battery; run;

/*** calculate means ***/

proc means data = battery;
   class material temp;
   var life;
   output out = batterymean mean = mean_life std = std;
run;

proc print data = batterymean; run;

proc sgplot data = batterymean;
   series  x = temp y = mean_life / group = material markers;
   where _type_ = 3;
run;

proc sgplot data = batterymean;
   series  x = material y = mean_life / group = temp markers;
   where _type_ = 3;
run;

/*** use customized style ***/

%modstyle(name = mystyle, parent = statistical, type = CLM,
          linestyles = Solid LongDash MediumDash Dash ShortDash Dot ThinDot,
          markers = star plus circle square diamond starfilled
                    circlefilled squarefilled diamondfilled);

filename odsout "&_SASWS_/temp";
ods _all_ close;
ods html path = odsout gpath = odsout style = mystyle;

proc sgplot data = batterymean;
   series  x = temp y = mean_life / group = material markers;
   where _type_ = 3;
run;

/*** two-way ANOVA ***/

proc glm data = battery;
   class material temp;
   model life = material temp material * temp;
run;


/***  model diagnostics ***/

proc glm data = battery;
   class material temp;
   model life = material temp material * temp;
   output out = diag r = res p = pred;
run;

proc univariate normal data = diag; 
   var res;
   histogram res / normal;
   qqplot res / normal (L = 1 mu = est sigma = est);
run;

proc sgplot data = diag;
   scatter x = pred y = res;
   refline 0;
run;

proc sgplot data = diag;
   scatter x = material y = res; 
   refline 0;
run;

proc sgplot data = diag;
   scatter x = temp y = res; 
   refline 0;
run;

/*** multiple comparison ***/

proc glm data = battery;
   class material temp;
   model life = material temp material * temp;
   lsmeans material * temp / pdiff adjust = tukey; 
   lsmeans material * temp / pdiff adjust = bon;
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
