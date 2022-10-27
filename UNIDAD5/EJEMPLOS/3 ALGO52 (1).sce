// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema 5:Técnicas de Solución de Ecuaciones Diferenciales 
//% RUNGE-KUTTA (ORDER 4) ALGORITHM 5.2
 //%
 //% TO APPROXIMATE THE SOLUTION TO THE INITIAL VALUE PROBLEM:
 //%            Y' = F(T,Y), A<=T<=B, Y(A) = ALPHA,
 //% AT (N+1) EQUALLY SPACED NUMBERS IN THE INTERVAL [A,B].
// %
// % INPUT:   ENDPOINTS A,B; INITIAL CONDITION ALPHA; INTEGER N.
// %
// % OUTPUT:  APPROXIMATION W TO Y AT THE (N+1) VALUES OF T.
// syms('F', 'OK', 'A', 'B', 'ALPHA', 'N', 'FLAG', 'NAME', 'OUP');
// syms('H', 'T', 'W', 'I', 'K1', 'K2', 'K3', 'K4','t','d');
ieee(2)
clc
format(15)
funcprot(0)
 TRUE = 1;
 FALSE = 0;
 printf('This is the Runge-Kutta Order Four Method.\n');
 printf('Input the function F(t,y) in terms of t and y\n');
 printf('For example: x=y-t^2+1 entre apostrofes\n');
 s = input(' ');
 //F = inline(s,'t','y');
 deff('x=F(t,y)',s);
 OK = FALSE;
 while OK == FALSE 
     printf('Input left and right endpoints on separate lines.\n');
     A = input(' ');
     B = input(' ');
     if A >= B  
         printf('Left endpoint must be less than right endpoint\n');
     else
         OK = TRUE;
     end;
 end;
 printf('Input the initial condition\n');
 ALPHA = input(' ');
 OK = FALSE;
 while OK == FALSE 
     printf('Input a positive integer for the number of subintervals\n');
     N = input(' ');
     if N <= 0 
         printf('Number must be a positive integer\n');
     else
         OK = TRUE;
     end;
 end;
 if OK == TRUE 
     printf('Choice of output method:\n');
     printf('1. Output to screen\n');
     printf('2. Output to text file\n');
     printf('Please enter 1 or 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Input the file name in the form - drive:\\name.ext\n');
         printf('For example   A:\\OUTPUT.DTA\n');
         NAME = input(' ','s');
         //OUP = fopen(NAME,'wt');
         OUP=file('open',NAME,'unknow');
     else
         OUP = 1;
     end;
     if OUP==1 then
         printf('RUNGE-KUTTA FOURTH ORDER METHOD\n\n');
         printf('    t           w\n\n');
        //% STEP 1
         H = (B-A)/N;
         T = A;
         W = ALPHA;
         printf('%5.3f %11.7f\n', T, W);
        //% STEP 2
         for I = 1:N 
            //% STEP 3
             K1 = H*F(T,W);
             K2 = H*F(T+H/2.0, W+K1/2.0);
             K3 = H*F(T+H/2.0, W+K2/2.0);
             K4 = H*F(T+H,W+K3);
            //% STEP 4
            //% compute W(I)
             W = W+(K1+2.0*(K2+K3)+K4)/6.0;
            //% compute T(I)
             T = A+I*H;
            //% STEP 5
             printf('%5.3f %11.7f\n', T, W);
         end;       
     else
         //fprintf(OUP, 'RUNGE-KUTTA FOURTH ORDER METHOD\n\n');
         //fprintf(OUP, '    t           w\n\n');
         text1='RUNGE-KUTTA FOURTH ORDER METHOD';
         write(OUP,text1);
        //% STEP 1
         H = (B-A)/N;
         T = A;
         W = ALPHA;
         //fprintf(OUP, '%5.3f %11.7f\n', T, W);
         text2='t';
         write(OUP,text2);         
         write(OUP,T);
         text3='w';
         write(OUP,text3);
         write(OUP,W);
        //% STEP 2
         for I = 1:N 
            //% STEP 3
            //% use K1, K2, K3, K4 for K(1), K(2), K(3), K(4) RESP.
             K1 = H*F(T,W);
             K2 = H*F(T+H/2.0, W+K1/2.0);
             K3 = H*F(T+H/2.0, W+K2/2.0);
             K4 = H*F(T+H,W+K3);
            //% STEP 4
            //% compute W(I)
             W = W+(K1+2.0*(K2+K3)+K4)/6.0;
            //% compute T(I)
             T = A+I*H;
            //% STEP 5
             //fprintf(OUP, '%5.3f %11.7f\n', T, W);
             text4='Iteraicon:'
             write(OUP,text4);
             write(OUP,I);
            // text5't';
             write(OUP,text5);         
             write(OUP,T);
             text6='w';
             write(OUP,text6);
             write(OUP,W);
         end;
        //% STEP 6
        file('close',OUP); 
        printf('Output file %s created successfully. \n',NAME);
     end     
 end;
