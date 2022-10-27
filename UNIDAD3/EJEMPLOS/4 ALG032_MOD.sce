// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema   : Interpolacion Numerica
// % NEWTONS INTERPOLATORY DIVIDED-DIFFERENCE FORMULA ALGORITHM 3.2        
// % To obtain the divided-difference coefficients of the                    
// % interpolatory polynomial P on the (n+1) distinct numbers x(0),          
// % x(1), ..., x(n) for the function f:                                    
// % INPUT:   numbers x(0), x(1), ..., x(n); values f(x(0)), f(x(1)),          
// %          ..., f(x(n)) as the first column Q(0,0), Q(1,0), ...,          
// %    Q(N,0) of Q, or may be computed if function f is supplied.
// % OUTPUT:  the numbers Q(0,0), Q(1,1), ..., Q(N,N) where
// %          P(x) = Q(0,0) + Q(1,1)*(x-x(0)) + Q(2,2)*(x-x(0))*             
// %          (x-x(1)) +... + Q(N,N)*(x-x(0))*(x-x(1))*...*(x-x(N-1)).
// %
// % Modificado por: JUAN CARLOS ALVARADO.
// syms('OK', 'FLAG', 'N', 'I', 'X', 'Q', 'A', 'NAME', 'INP','OUP', 'J');
// syms('s','x');
 funcprot(0);
 ieee(2);
 format(25);
 clc;
 TRUE = 1;
 FALSE = 0;
 printf('Newtons form of the interpolation polynomial\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Choice of input method:\n');
     printf('1. Input entry by entry from keyboard\n');
     printf('2. Input data from a text file\n');
     printf('3. Generate data using a function F\n');
     printf('Choose 1, 2, or 3 please\n');
     FLAG = input(' ');
     if FLAG == 1 | FLAG == 2 | FLAG == 3 
         OK = TRUE;
     end
 end
 if FLAG == 1 
     OK = FALSE;
     while OK == FALSE 
         printf('Input n\n');
         N = input(' ');
         if N > 0 
             OK = TRUE;
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Input X(%d) and F(X(%d)) ', I, I);
                 printf('on separate lines\n');
                 X(I+1) = input(' ');
                 Q(I+1,1) = input(' ');
             end
         else 
             printf('Number must be a positive integer\n');
         end
     end
 end
 if FLAG == 2 
     printf('Has a text file been created with the data in one columns?\n');
     printf('Enter Y or N\n');
     A = input(' ','s');
     if A == 'Y' | A == 'y' 
         printf('Input the file name in the form - ');
         printf('drive:\\name.ext\n');
         printf('For example:   E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         OK = FALSE;
         while OK == FALSE 
             printf('Input n\n'); 
             N = input(' ');
             if N > 0                   
                 X = zeros(N+1);
                 Q = zeros(N+1,N+1);
                 for I = 0:N
                     X(I+1) = fscanf(INP, '%f');
                     Q(I+1,1) = fscanf(INP, '%f');
                 end
                 mclose(INP);
                 OK = TRUE;
             else
                 printf('Number must be a positive integer\n')
             end
         end
     else
         printf('Please create the input file in one column ');
         printf('form with the X values and F(X) value\n');
         printf('each X is followed by the corresponding F(X) value.\n');
         printf('The program will end so the input file can ');
         printf('be created.\n');
         OK = FALSE;
     end
 end
 if FLAG == 3 
     printf('Input the function F(x) in terms of x\n');
     printf('For example: y=3*x^3-2*x^2+1\n');
     s = input(' ');
     deff('y=F(x)',s);
     OK = FALSE;
     while OK == FALSE 
         printf('Input n\n');
         N = input(' ');
         if N > 0 
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Input X(%d)\n', I);
                 X(I+1) = input(' ');
                 Q(I+1,1) = F(X(I+1));
             end
             OK = TRUE;
         else
             printf('Number must be a positive integer\n');
         end
     end
 end
 
 //%-------------------------------------------------------------------------
 //%lectura 
 if OK == TRUE 
     printf('Input point at which the polynomial is to be evaluated\n');
     x = input(' ');
     a=X(1); 
     b=X(N+1);
     while ~((x>a & x<b))//|(a>x & x>b)) 
          //%valido si el numero ingresado esta en el intervalo Xo-Xn
          printf('Number must be in the range Xo-Xn\n');   
          printf('Input point at which the polynomial is to be evaluated\n');
          x = input(' ');
     end
 
 end
 //%--------------------------------------------------------------------------
 
 if OK == TRUE 
     printf('Select output destination\n');
     printf('1. Screen\n');
     printf('2. Text file\n');
     printf('Enter 1 or 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Input the file name in the form - drive:\\name.ext\n');
         printf('For example:   E:\\OUTPUT.TXT\n');
         NAME = input(' ','s');
         OUP = file('open',NAME,'unknown');
     else
         OUP = 1;
     end
     if OUP==1 then
         printf('NEWTONS INTERPOLATION POLYNOMIAL\n\n');
     else
         text1='NEWTONS INTERPOLATION POLYNOMIAL';
         write(OUP,text1)
     end
 
  //fprintf(OUP, 'NEWTONS INTERPOLATION POLYNOMIAL\n\n');
  //% STEP 1
     for I = 1:N
         for J = 1:I
             Q(I+1,J+1) = (Q(I+1,J) - Q(I,J)) / (X(I+1) - X(I-J+1));
         end
     end
 
 //%----------------------------------------------------
 //%genero polinomio Pn(x) y evaluo el punto ingresado
     p=Q(1,1);
     K=(x-X(1));
     for I=2:N+1
         if I>2
           K=K*(x-X(I-1));
         end
         p=p+Q(I,I)*K;
     end
 //%---------------------------------------------------
 
//% STEP 2
    if  OUP==1 then
        printf('Input data follows');
    else
        text2='Input data follows';
        write(OUP,text2);
    end
 
// fprintf(OUP, 'Input data follows:\n');      
     for I = 0:N
         if  OUP==1 then
             printf('X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));
         else
             text3='-----------------------';
             write(OUP,text3);
             write(OUP,I);
             write(OUP,X(I+1));
             write(OUP,Q(I+1,1));
         end
             
         
//         fprintf(OUP,'X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));      
     end
     
     if OUP==1 then
         printf('\nThe coefficients Q(0,0), ..., Q(N,N) are:\n');
     else
         text4='The coefficients Q(0,0), ..., Q(N,N) are:';
         write(OUP,text4);
     end
          
//     fprintf(OUP, '\nThe coefficients Q(0,0), ..., Q(N,N) are:\n');      
     for I = 0:N
         if OUP==1 then
             printf('%12.8f\n', Q(I+1,I+1))
         else
             text5='-.-.-.-.-.-.-.-.-.-.-.-';
             write(OUP,text5);
             write(OUP,Q(I+1,I+1));
         end
         
         
//         fprintf(OUP, '%12.8f\n', Q(I+1,I+1));
     end
     if OUP==1 then
         printf('\nP(%12.8f)=%12.14f\n',x,p);
     else
         text6='=================';
         write(OUP,text6);
         write(OUP,x);
         write(OUP,p);
     end

//     fprintf(OUP, '\nP(%12.8f)=%12.14f\n',x,p); 
 
 
 if OUP ~= 1 
     file ('close',OUP);
     printf('Output file %s created successfully\n',NAME);
 end
 end

