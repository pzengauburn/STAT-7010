/********************************************************************* 
 * STAT 7010 - Experimental Statistics II 
 * Peng Zeng (Auburn University)
 * 2024-02-10 
 *********************************************************************/

/* Method 1: Same Rows and Same Columns */

data one;                  
   input rep row col trt resp;
datalines;                 
1 1 1 1 7.0                
1 1 2 2 8.0                
1 1 3 3 9.0                
1 2 1 2 4.0                
1 2 2 3 5.0                
1 2 3 1 4.0                
1 3 1 3 6.0                
1 3 2 1 3.0                
1 3 3 2 4.0                
                           
2 1 1 3 8.0                
2 1 2 2 4.0                
2 1 3 1 7.0                
2 2 1 2 6.0                
2 2 2 1 3.0                
2 2 3 3 6.0                
2 3 1 1 5.0                
2 3 2 3 8.0                
2 3 3 2 7.0                
                           
3 1 1 2 9.0                
3 1 2 1 6.0                
3 1 3 3 8.0                
3 2 1 1 5.0                
3 2 2 3 7.0                
3 2 3 2 6.0                
3 3 1 3 9.0                
3 3 2 2 3.0                
3 3 3 1 7.0                
;   

proc glm data = one;          
   class rep row col trt;      
   model resp = rep row col trt; 
run;    

/* Method 2: New Rows and Same Columns */

data two;
   input rep row col trt resp;
datalines;
1 1 1 1 7.0
1 1 2 2 8.0
1 1 3 3 9.0
1 2 1 2 4.0
1 2 2 3 5.0
1 2 3 1 4.0
1 3 1 3 6.0
1 3 2 1 3.0
1 3 3 2 4.0

2 4 1 3 8.0
2 4 2 2 4.0
2 4 3 1 7.0
2 5 1 2 6.0
2 5 2 1 3.0
2 5 3 3 6.0
2 6 1 1 5.0
2 6 2 3 8.0
2 6 3 2 7.0

3 7 1 2 9.0
3 7 2 1 6.0
3 7 3 3 8.0
3 8 1 1 5.0
3 8 2 3 7.0
3 8 3 2 6.0
3 9 1 3 9.0
3 9 2 2 3.0
3 9 3 1 7.0
;         

proc glm data = two;              
   class rep row col trt;          
   model resp = rep row(rep) col trt;
run;    

/* Latin rectangle */
proc glm data = two;
   class row col trt;          
   model resp = row col trt;
run;


/* Method 3: New Rows and New Columns */
 
data three;
input rep row col trt resp;
datalines;
1 1 1 1 7.0
1 1 2 2 8.0
1 1 3 3 9.0
1 2 1 2 4.0
1 2 2 3 5.0
1 2 3 1 4.0
1 3 1 3 6.0
1 3 2 1 3.0
1 3 3 2 4.0

2 4 4 3 8.0
2 4 5 2 4.0
2 4 6 1 7.0
2 5 4 2 6.0
2 5 5 1 3.0
2 5 6 3 6.0
2 6 4 1 5.0
2 6 5 3 8.0
2 6 6 2 7.0

3 7 7 2 9.0 
3 7 8 1 6.0 
3 7 9 3 8.0 
3 8 7 1 5.0 
3 8 8 3 7.0 
3 8 9 2 6.0 
3 9 7 3 9.0 
3 9 8 2 3.0 
3 9 9 1 7.0 
;       

proc glm data = three;                   
   class rep row col trt;               
   model resp = rep row(rep) col(rep) trt;
run;                                 

/********************************************************************* 
 * THE END
 *********************************************************************/
