// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica
// % HERMITE INTERPOLATION ALGORITHM 3.3
// % TO OBTAIN THE COEFFICIENTS OF THE HERMITE INTERPOLATING
// % POLYNOMIAL H ON THE (N+1) DISTINCT NUMBERS X(0), ..., X(N)
// % FOR THE FUNCTION F:
// % INPUT:   NUMBERS X(0), X(1), ..., X(N); VALUES F(X(0)), F(X(1)),
// %          ..., F(X(N)) AND F'(X(0)), F'(X(1)), ..., F'(X(N)).
// % OUTPUT:  NUMBERS Q(0,0), Q(1,1), ..., Q(2N + 1,2N + 1) WHERE
// %          H(X) = Q(0,0) + Q(1,1) * ( X - X(0) ) + Q(2,2) *
// %                 ( X - X(0) )**2 + Q(3,3) * ( X - X(0) )**2 *
// %                 ( X - X(1) ) + Q(4,4) * ( X - X(0) )**2 *
// %                 ( X - X(1) )**2 + ... + Q(2N + 1,2N + 1) *
// %                 ( X - X(0) )**2 * ( X - X(1) )**2 * ... *
// %                 ( X - X(N - 1) )**2 * (X - X(N) ).
// syms('OK', 'FLAG', 'N', 'I', 'X', 'Q', 'A', 'NAME', 'INP'); 
// syms('Z', 'K', 'J', 'OUP', 'XX', 'S','x','s','I1');
 TRUE = 1;
 FALSE = 0;
 printf('This is Hermite interpolation.\n');
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
         printf('Input the number of data points minus 1\n');
         N = input(' ');
         if N > 0 
             OK = TRUE;               
             X = zeros(N+1);
             Q = zeros(2*N+2,2*N+2);
             for I = 0:N                  
                 printf('Input X(%d), F(X(%d)), and ', I, I);
                 printf('F''(X(%d)) on separate lines\n ', I);          
                 X(I+1) = input(' ');
                 Q(2*I+1,1) = input(' ');
                 Q(2*I+2,2) = input(' ');
             end            
         else
             printf('Number must be a positive integer\n');         
         end
     end
 end
 if FLAG == 2 
     printf('Has a text file been created with the data in one column?\n');
     printf('Enter Y or N\n');
     A = input(' ','s');
     if A == 'Y' | A == 'y' 
         printf('Input the file name in the form - ');
         printf('drive:\\name.ext\n');
         printf('for example:   E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         OK = FALSE;
         while OK == FALSE 
             printf('Input the number of data points minus 1\n');
             N = input(' ');
             if N > 0 
                 X = zeros(N+1);
                 Q = zeros(2*N+2,2*N+2);
                 for I = 0:N
                     X(I+1) = fscanf(INP, '%f');
                     Q(2*I+1,1) = fscanf(INP, '%f');
                     Q(2*I+2,2) = fscanf(INP, '%f');
                 end
                 mclose(INP);
                 OK = TRUE;
             else 
                 printf('Number must be a positive integer\n');
             end
         end
     else
         printf('Please create the input file in one column ');
         printf('form with the X values, F(X), and\n');
         printf('derivative values for each X in the set.\n');
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
     printf('Input the Derivative of F(x) in terms of x.\n');
     printf('For example: y=9*x^2-4*x\n');
     s = input(' ');
     deff('y=FP(x)',s);
//     FP = inline(s,'x');
     OK = FALSE;
     while OK == FALSE 
         printf('Input the number of data points minus 1\n');
         N = input(' ');
         if N > 0 
             X = zeros(1,N+1);
             Q = zeros(2*N+2,2*N+2);
             for I1 = 0:N
                 printf('Input X(%d)\n', I1);
                 X(I1+1) = input(' ');
                 Q(2*I1+1,1) = F(X(I1+1));
                 Q(2*I1+2,2) = FP(X(I1+1));
             end
             OK = TRUE;
         else
             printf('Number must be a positive integer\n');
         end
     end
 end
 if OK == TRUE 
//% STEP 1
     Z = zeros(2*N+2);
     for I = 0:N
//% STEP 2
         Z(2*I+1) = X(I+1);
         Z(2*I+2) = X(I+1);
         Q(2*I+2,1) = Q(2*I+1,1);
//% STEP 3
         if I ~= 0 
             Q(2*I+1,2) = (Q(2*I+1,1)-Q(2*I,1))/(Z(2*I+1)-Z(2*I));
         end
     end
//% STEP 4
     K = 2*N+1;
     for I = 2:K
         for J = 2:I
             Q(I+1,J+1) = (Q(I+1,J)-Q(I,J))/(Z(I+1)-Z(I-J+1));
         end
     end
//% STEP 5
     printf('Choice of output method:\n');
     printf('1. Output to screen\n');
     printf('2. Output to text file\n');
     printf('Please enter 1 or 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Input the file name in the form - drive:\\name.ext\n');
         printf('for example:   C:\\OUTPUT.TXT\n');
         NAME = input(' ','s');
         OUP = file('open',NAME,'unknown');
         text1='HERMITE INTERPOLATION POLYNOMIAL\n\n'
         write(OUP,text1);
     else OUP = 1;
     end
     
     if OUP==1 then
         printf('INTERPOLACION POLINOMIAL DE HERMITE\n\n');
         printf( 'The input data follows:\n');
         printf( '  X, F(X), F''(x)\n');
     else
         text2='INTERPOLACION POLINOMIAL DE HERMITE\n\n';
         text3='The input data follows:\n';
         text4='  X, F(X), F''(x)\n'
         write(OUP,text2);
         write(OUP,text3);
         write(OUP,text4); 
     end
//     printf( 'HERMITE INTERPOLATING POLYNOMIAL\n\n');
//     printf( 'The input data follows:\n');
//     printf( '  X, F(X), F''(x)\n');
     for I = 0:N
         if OUP==1 then
             printf('  %12.10e %12.10e %12.10e\n',X(I+1),Q(2*I+1,1),Q(2*I+2,2));
         else
             write(OUP,X(I+1))
             write(OUP,Q(2*I+1,1));
             write(OUP,Q(2*I+2,2));
         end
//         printf('  %12.10e %12.10e %12.10e\n',X(I+1),Q(2*I+1,1),Q(2*I+2,2));
     end
     if OUP==1 then
         printf( '\nThe Coefficients of the Hermite Interpolation ');
         printf( 'Polynomial\n');
         printf( 'in order of increasing exponent follow:\n\n');
     else
         text5='\nThe Coefficients of the Hermite Interpolation ';
         text6='Polynomial\n';
         text7='in order of increasing exponent follow:\n\n'
         write(OUP,text5);
         write(OUP,text6);
         write(OUP,text7); 
     end
//     printf( '\nThe Coefficients of the Hermite Interpolation ');
//     printf( 'Polynomial\n');
//     printf( 'in order of increasing exponent follow:\n\n');
     for I = 0:K
         if OUP==1 then
             printf( '  %12.10e\n', Q(I+1,I+1));
         else
             write(OUP,Q(I+1,I+1))
         end
//         printf( '  %12.10e\n', Q(I+1,I+1));
     end
     if OUP==1 then
         printf('Do you wish to evaluate this polynomial?\n');
         printf('Enter Y or N\n');
     else
         text8='Do you wish to evaluate this polynomial?\n';
         text9='Enter Y or N\n';
         write(OUP,text8);
         write(OUP,text9);
     end
//     printf('Do you wish to evaluate this polynomial?\n');
//     printf('Enter Y or N\n');
     A = input(' ','s');
     if A == 'Y' | A == 'y' 
         printf('Enter a point at which to evaluate\n');
         XX = input(' ');
         S = Q(K+1,K+1)*(XX-Z(K));
         for I = 2:K
             J = K-I+1;
             S = (S+Q(J+1,J+1))*(XX-Z(J));
         end
         S = S + Q(1,1);
         if OUP==1 then
             printf( 'x-value and interpolated-value\n');
             printf( '  %12.10e %12.10e\n', XX, S);
         else
             text10='x-value and interpolated-value\n';
             write(OUP,XX);
             write(OUP,S);
         end

//         printf( 'x-value and interpolated-value\n');
//         printf( '  %12.10e %12.10e\n', XX, S);
     end
     if OUP ~= 1 
         file('close',OUP);
         if OUP==1 then
             printf('Output file %s created successfully\n',NAME);
         else
             text11='Output file %s created successfully\n';
             write(OUP,text11); 
         end
//         printf('Output file %s created successfully\n',NAME);
     end
 end
