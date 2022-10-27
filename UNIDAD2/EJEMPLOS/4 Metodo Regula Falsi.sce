// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// METODO DE LA REGULA FALSI
clc;clear; 
 TRUE = 1;
 FALSE = 0; NO=380;TOL = 0.00001;
 printf('\n - Metodo de la Regula Falsi -');
 printf('\n Digite la funcion y = f(x)\n');
deff('y=F(x)',input('Digite la funcion en terminos de y=f(x):-->',"s"));
// deff('y=F(x)','y=x.^5-3*x.^4+10*x-8');
OK = FALSE;
P0 = input('Digite extremo izquierdo del intervalo:--> ');
P1 = input('Digite extremo derecho   del intervalo:--> ');
// STEP 1
 I = 0;
 OK = TRUE;
 Q0 = F(P0);
 Q1 = F(P1);
 printf('    K       Ck                F(Ck)');
 printf('\n    ___________________________________ ');
// STEP 2
 while I <= NO & OK == TRUE
    // STEP 3
    // compute P(I)
    P = P1-Q1*(P1-P0)/(Q1-Q0);
    Q = F(P);
    printf('\n %4d %16.12f %16.12f',I,P,Q)
// STEP 4
 if abs(P-P1) < TOL 
    printf('\n\n  Solucion Aproximada P=%12.8f',P);
    printf(' con F(P) = %12.8f\n',Q);
    printf('* Numero de iteraciones =%3d',I);
    printf('  Tolerancia =%15.8e\n',TOL);
    OK = FALSE;
 else
    // STEP 5
    I = I+1;
    // STEP 6
 if Q*Q1 < 0 
    P0 = P1;
    Q0 = Q1;
 end
// STEP 7
    P1 = P;
    Q1 = Q;
 end
 end 
 if OK == TRUE 
    printf('\nIteration number %3d',NO);
    printf(' gave approximation %12.8f\n',P);
    printf('F(P) = %12.8f not within tolerance: %15.8e\n',Q,TOL);
 end
 


