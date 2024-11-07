/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-03-26 
 *********************************************************************/

filename csvfile url "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/cupcake.csv";

proc import out = cupcake datafile = csvfile 
   dbms = csv replace; 
run; 

proc print data = cupcake; run; 

/***** completely randomized design *****/ 

proc glm data = cupcake; 
   class recipe temp; 
   model volume = recipe | temp; 
run; 

/***** completely randomized block design *****/ 

proc glm data = cupcake; 
   class recipe temp rep; 
   model volume = recipe | temp rep; 
run; 

/***** split-plot design (case 1) *****/ 

data new; 
   set cupcake; 
   oven = temp || rep;
run; 

proc glm data = new; 
   class recipe temp rep oven;
   model volume = recipe | temp oven; 
   random oven;  
run;

/***** split-plot design (case 2) *****/ 

proc glm data = new; 
   class recipe temp rep oven;
   model volume = recipe | temp rep oven; 
   random oven;  
run;

/***** strip-plot design *****/ 

data new2; 
   set new; 
   batch = recipe || rep;
run; 

proc glm data = new2; 
   class recipe temp rep oven batch;
   model volume = recipe | temp rep oven batch; 
   random oven batch;  
run;

/********************************************************************* 
 * THE END
 *********************************************************************/
