// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica
//% NATURAL CUBIC SPLINE ALGORITHM 3.4                                     %
// % To construct the cubic spline interpolant S for the function f,
// % defined at the numbers x(0) < x(1) < ... < x(n), satisfying
// % S''(x(0)) = S''(x(n)) = 0:
// %
// % INPUT:   n; x(0), x(1), ..., x(n); either generate A(I) = f(x(I))
// %          for I = 0, 1, ..., n or input A(I) for I = 0, 1, ..., n.
// %
// % OUTPUT:  A(J), B(J), C(J), D(J) for J = 0, 1, ..., n - 1.
// %
// % NOTE:    S(x) = A(J) + B(J)*( x - x(J) ) + C(J)*( x - x(J) )**2 +
// %          D(J) * ( x - x(J) )**3 for x(J) <= x < x(J + 1) 
// syms('OK','FLAG','N','I','X','A','AA','NAME','INP','F','M','H','XA')
// syms('XL','XU','XZ','C','J','B','D','OUP','x','s');
 funcprot(0);
 ieee(2);
 format(25);
 clc;
 TRUE=1;
 FALSE=0;
 printf('This is the natural cubic spline interpolation.\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Choice of input method:\n');
     printf('1. Input entry by entry from keyboard\n');
     printf('2. Input data from a text file\n');
     printf('3. Generate data using a function F with nodes entered ');
     printf('from keyboard\n');
     printf('4. Generate data using a function F with nodes from ');
     printf('a text file\n');
     printf('Choose 1, 2, 3, or 4 please\n');
     FLAG = input(' ');
     if FLAG >= 1 & FLAG <= 4 
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
             X = zeros(1,N+1);
             A = zeros(1,N+1);
             for I = 0:N 
                 printf('Input X(%d) and F(X(%d)) ', I, I);
                 printf('on separate lines.\n');
                 X(I+1) = input(' ');
                 A(I+1) = input(' ');
             end
         else printf('Number must be a positive integer\n');
         end
     end
 end
 if FLAG == 2 
     printf('Has a text file been created with the data in one ');
     printf('column ?\n');
     printf('Enter Y or N\n');
     AA = input(' ','s');
     if AA == 'Y' | AA == 'y' 
         printf('Input the file name in the form - ');
         printf('drive:\\name.ext\n');
         printf('For example: E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         OK = FALSE;
         while OK == FALSE 
             printf('Input n\n');
             N = input(' ');
             if N > 0
                 X = zeros(1,N+1);
                 A = zeros(1,N+1);
                 for I = 0:N
                     X(I+1) = fscanf(INP, '%f');
                     A(I+1) = fscanf(INP, '%f');
                 end
                 mclose(INP);
                 OK = TRUE;
             else 
                 printf('Number must be a positive integer\n');
             end
         end
     else
         printf('Please create the input file in two column ');
         printf('form with the\n');
         printf('X values and F(X) values in the corresponding columns.\n');
         printf('The program will end so the input file can be created.\n');
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
             X = zeros(1,N+1);
             A = zeros(1,N+1);
             for I = 0:N 
                 printf('Input X(%d)\n', I);
                 X(I+1) = input(' ');
                 A(I+1) = F(X(I+1));
             end
             OK = TRUE;
         else
             printf('Number must be a positive integer\n');
         end
     end
 end
 if FLAG == 4 
     printf('Has the text file with X-values been created?\n');
     printf('Enter Y or N\n');
     AA = input(' ','s');
     if AA == 'Y' | AA == 'y' 
         printf('Input the file name in the form - ');
         printf('drive:\\name.ext\n');
         printf('For example:   E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         printf('Input the function F(x) in terms of x\n');
         printf('For example: y=3*x^3-2*x^2+1\n');
         s = input(' ');
         F = inline(s,'x');
         OK = FALSE;
         while OK == FALSE 
             printf('Input n\n');
             N = input(' ');
             if N > 0
                 OK = TRUE;
                 X = zeros(1,N+1);
                 A = zeros(1,N+1);
                 for I = 0:N
                     X(I+1) = fscanf(INP, '%f');
                     A(I+1) = F(X(I+1));
                 end
                 mclose(INP);
             else printf('Number must be a positive integer\n');
             end
         end
     else 
         printf('The program will end so the input file can be created\n');
         OK = FALSE;
     end
 end
 if OK == TRUE 
     M = N - 1;
//% STEP 1
     H = zeros(1,M+1);
     for I = 0:M
         H(I+1) = X(I+2) - X(I+1);
     end
//% STEP 2
//% Use XA in place of ALPHA
     XA = zeros(1,M+1);
     for I = 1:M
         XA(I+1) = 3.0*(A(I+2)*H(I)-A(I+1)*(X(I+2)-X(I))+A(I)*H(I+1))/(H(I+1)*H(I));
     end
//% STEP 3
//% STEPs 3, 4, 5 and part of 6 solve the tridiagonal system using 
//% Crout reduction.
//% use XL, XU, XZ in place of L, MU, Z resp.
     XL = zeros(1,N+1);
     XU = zeros(1,N+1);
     XZ = zeros(1,N+1);
     XL(1) = 1;
     XU(1) = 0;
     XZ(1) = 0;
//% STEP 4
     for I = 1:M
         XL(I+1) = 2*(X(I+2)-X(I))-H(I)*XU(I);
         XU(I+1) = H(I+1)/XL(I+1);
         XZ(I+1) = (XA(I+1)-H(I)*XZ(I))/XL(I+1);
     end
//% STEP 5
     XL(N+1) = 1;
     XZ(N+1) = 0;
     B = zeros(1,N+1);
     C = zeros(1,N+1);
     D = zeros(1,N+1);
     C(N+1) = XZ(N+1);
//% STEP 6
     for I = 0:M
         J = M-I;
         C(J+1) = XZ(J+1)-XU(J+1)*C(J+2);
         B(J+1) = (A(J+2)-A(J+1))/H(J+1) - H(J+1) * (C(J+2) + 2.0 * C(J+1)) / 3.0;
         D(J+1) = (C(J+2) - C(J+1)) / (3.0 * H(J+1));
     end
//% STEP 7
     printf('Select output destination\n');
     printf('1. Screen\n');
     printf('2. Text file\n');
     printf('Enter 1 or 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Input the file name in the form - drive:\\name.ext\n');
         printf('For example:   C:\\OUTPUT.TXT\n');
         NAME = input(' ','s');
         OUP = file('open',NAME,'unknown');
     else 
         OUP = 1;
     end
     if OUP==1 then
         printf('NATURAL CUBIC SPLINE INTERPOLATION\n\n');
         printf('The numbers X(0),...,X(N) are:\n');
     else
         text1='NATURAL CUBIC SPLINE INTERPOLATION\n\n';
         text2='The numbers X(0),...,X(N) are:\n'
         write(OUP,text1);
         write(OUP,text2);
     end
//     printf('NATURAL CUBIC SPLINE INTERPOLATION\n\n');
//     printf('The numbers X(0), ..., X(N) are:\n');
     for I = 0:N
         if OUP==1 then
             printf(' %11.8f', X(I+1));
         else
             text3='-----------------------';
             write(OUP,text3);
             write(OUP,X(I+1));
         end
//         printf(' %11.8f', X(I+1));
     end
     if OUP==1 then
         printf('\n\nThe coefficients of the spline on the subintervals '); 
         printf('are:\n');
         printf('for I = 0, ..., N-1\n');
         printf('          A(I)                   B(I)                    C(I)                  D(I)\n');
     else
         text4='\n\nThe coefficients of the spline on the subintervals ';
         text5='are:\n';
         text6='for I = 0, ..., N-1\n';
         text7='     A(I)          B(I)           C(I)         D(I)\n';
         write(OUP,text4);
         write(OUP,text5);
         write(OUP,text6);
         write(OUP,text7);
     end
//     printf('\n\nThe coefficients of the spline on the subintervals '); 
//     printf('are:\n');
//     printf('for I = 0, ..., N-1\n');
//     printf('     A(I)          B(I)           C(I)         D(I)\n');
     for I = 0:M
         if OUP==1 then
             printf('%13.8f %13.8f %13.8f %13.8f\n',A(I+1),B(I+1),C(I+1),D(I+1));
         else
             write(OUP,A(I+1));
             write(OUP,B(I+1));
             write(OUP,C(I+1));
             write(OUP,D(I+1));
         end
//         printf('%13.8f %13.8f %13.8f %13.8f \n',A(I+1),B(I+1),C(I+1),D(I+1));
     end
 
// %-------------------------------------------------------------------------
 
     printf('Ingrese el nodo a interpolar\n');
     x = input(' ');
     a=X(1); 
     b=X(N+1);
     while x<a | x>b 
         //%valido si el numero ingresado esta en el intervalo Xo-Xn
          printf('\nEl nodo a interpolar debe estar en el rango Xo-Xn\n');   
          printf('Ingrese el nodo a interpolar\n');
          x = input(' ');
     end
 
     for i=1:N
         if x>X(i) & x<X(i+1)
             s=i;
             i=N;
         end
     end
 
     POL=string(A(s));
     POL=strcat(POL,'+(');
     POL=strcat(POL,string(B(s)));
     POL=strcat(POL,'*(x-');
     POL=strcat(POL,string(X(s)));
     POL=strcat(POL,'))+(');
     POL=strcat(POL,string(C(s)));
     POL=strcat(POL,'*(x-');
     POL=strcat(POL,string(X(s)));
     POL=strcat(POL,')^2)+(');
     POL=strcat(POL,string(D(s)));
     POL=strcat(POL,'*(x-');
     POL=strcat(POL,string(X(s)));
     POL=strcat(POL,')^3)');
  
     r=A(s)+B(s)*(x-X(s))+C(s)*(x-X(s))^2+D(s)*(x-X(s))^3;
     printf('FORMA DEL POLINOMIO DE INTERPOLACION\n');   
     printf('S(%d)(x) = %s \n',s-1,POL);
     printf('\nVALOR INTERPOLADO\n');   
     printf('S(%d)(%.6f) = %13.8f \n',s-1,x,r);    
  //%-------------------------------------------------------------------------
     if OUP ~= 1
         file('close',OUP);
         printf('Output file %s created successfully \n',NAME);
     end
 end
