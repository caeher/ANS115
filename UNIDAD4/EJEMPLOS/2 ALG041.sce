// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema :4.	Derivación e Integración Numérica
// SIMPSON'S COMPOSITE ALGORITHM 4.1
// To approximate I = integral ( ( f(x) dx ) ) from a to b:
// INPUT:   endpoints a, b; even positive integer n.
//
// OUTPUT:  approximation XI to I.
 clc;
 funcprot(0);
 ieee(2);
 format(25);
 TRUE = 1;
 FALSE = 0;
 printf('This is Simpsons Method.\n\n');
 //printf('Input the function F(x) in terms of x\n');
 //printf('For example: cos(x)\n');
 deff('y=F(x)',input('Digite la funcion en el formato y=F(x), Por ejemplo y=sin(x) ',"s"));
 OK = FALSE;
 while OK == FALSE 
 printf('Input lower limit of integration and ');
 printf('upper limit of integration\n');
 printf('on separate lines\n');
 A = input(' ');
 B = input(' ');
 if A > B 
 printf('Lower limit must be less than upper limit\n');
 else
 OK = TRUE;
 end
 end 
 OK = FALSE;
 while OK == FALSE 
 printf('Input an even positive integer N.\n');
 N = input(' ');
 if N > 0 & modulo(N,2) == 0 
 OK = TRUE;
 else
 printf('Input must be even and positive\n');
 end
 end
 if OK == TRUE 
// STEP 1
 H = (B-A)/N;
// fprintf(1,'El valor de H es:%12.8f\n',H);
// STEP 2
 XI0 = F(A) + F(B);
// summation of f(x(2*I-1))
 XI1 = 0.0;
// summation of f(x(2*I))
 XI2 = 0.0;
// STEP 3
 NN = N - 1;
 for I = 1:NN
// STEP 4
 X = A + I * H;
// fprintf(1,'Nodo:%12.8f\n',X);
// STEP 5
 if modulo(I,2) == 0  
 XI2 = XI2 + F(X);
 else
 XI1 = XI1 + F(X);      
 end
 end
// STEP 6
 XI = (XI0 + 2.0 * XI2 + 4.0 * XI1) * H / 3.0;
// STEP 7
 printf('\nThe integral of F from %12.8f to %12.8f is\n', A, B);
 printf('%12.8f\n', XI);
 end
