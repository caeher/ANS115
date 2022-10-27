// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema :4.	Derivación e Integración Numérica
 // ADAPTIVE QUADRATURE ALGORITM  4.3 %    
 // To approximate I = integral ( ( f(x) dx ) ) from a to b to within
 // a given tolerance TOL:
 // INPUT:    endpoints a, b; tolerance TOL; limit N to number of levels
 //
 // OUTPUT:   approximation APP or message that N is exceeded.
 clc;
 funcprot(0);
 ieee(2);
 format(25);
 TRUE = 1;
 FALSE = 0;
 printf('This is Adaptive Quadrature with Simpsons Method.\n\n');
 //printf('Input the function F(x) in terms of x\n');
 //printf('For example: cos(x)\n');
 deff('y=F(x)',input('Digite la funcion en el formato y=F(x), Por ejemplo y=sin(x) ',"s"));
 OK = FALSE;
 while OK == FALSE 
 printf('Input lower limit of integration and ');
 printf('upper limit of integration\n');
 printf('on separate lines\n');
 AA = input(' ');
 BB = input(' ');
 if AA > BB
 printf('Lower limit must be less than upper limit\n');
 else
 OK = TRUE;
 end
 end 
 OK = FALSE;
 while OK == FALSE 
 printf('Input tolerance.\n');
 EPS = input(' ');
 if EPS > 0 
 OK = TRUE;
 else
 printf('Tolerance must be positive.\n');
 end
 end
 OK = FALSE;
 while OK == FALSE 
 printf('Input the maximum number of levels.\n');
 N = input(' ');
 if N > 0 
 OK = TRUE;
 else
 printf('Number must be positive\n');
 end
 end
 if OK == TRUE 
 CNT = 0;
 OK = TRUE;
 // STEP 1
 APP = 0;
 I = 1;
 TOL = zeros(1,N);
 A = zeros(1,N);
 H = zeros(1,N);
 FA = zeros(1,N);
 FC = zeros(1,N);
 FB = zeros(1,N);
 S = zeros(1,N);
 L = zeros(1,N);
 FD = zeros(1,N);
 FE = zeros(1,N);
 V = zeros(1,7);
 TOL(I) = 10*EPS;
 A(I) = AA;
 H(I) = 0.5*(BB-AA);
 FA(I) = F(AA);
 CNT = CNT+1;
 FC(I) = F((AA+H(I)));
 CNT = CNT+1;
 FB(I) = F(BB);
 CNT = CNT+1;
 // Approximation from Simpson's method for entire interval.
 S(I) = H(I)*(FA(I)+4*FC(I)+FB(I))/3;
 L(I) = 1;
 // STEP 2
 while I > 0 & OK == TRUE 
 // STEP 3
 FD = F((A(I)+0.5*H(I)));
 CNT = CNT+1;
 FE = F((A(I)+1.5*H(I)));
 CNT = CNT+1;
 // Approximations from Simpson's method for halves of intervals
 S1 = H(I)*(FA(I)+4*FD+FC(I))/6;
 S2 = H(I)*(FC(I)+4*FE+FB(I))/6;
 // Save data at this level
 V(1) = A(I);
 V(2) = FA(I);
 V(3) = FC(I);
 V(4) = FB(I);
 V(5) = H(I);
 V(6) = TOL(I);
 V(7) = S(I);
 LEV = L(I);
 // STEP 4
 // Delete the level
 I = I-1;
 // STEP 5
 if abs(S1+S2-V(7)) < V(6) 
 APP = APP+(S1+S2);
 else
 if LEV >= N 
 OK = FALSE;
 // procedure fails
 else
 // Add one level
 // Data for right half subinterval
 I = I+1;
 A(I) = V(1)+V(5);
 FA(I) = V(3);
 FC(I) = FE;
 FB(I) = V(4);
 H(I) = 0.5*V(5);
 TOL(I) = 0.5*V(6);
 S(I) = S2;
 L(I) = LEV+1;
 // Data for left half subinterval
 I = I+1;
 A(I) = V(1);
 FA(I) = V(2);
 FC(I) = FD;
 FB(I) = V(3);
 H(I) = H(I-1);
 TOL(I) = TOL(I-1);
 S(I) = S1;
 L(I) = L(I-1);
 end
 end
 end
 if OK == FALSE 
 printf('Level exceeded.  Method did not produce an\n');
 printf('accurate approximation.\n');
 else
 printf('\nThe integral of F from %12.8f to %12.8f is\n', AA, BB);
 printf('%12.8f to within %14.8e\n', APP, EPS);
 printf('The number of function evaluations is: %d\n', CNT); 
 end
 end
