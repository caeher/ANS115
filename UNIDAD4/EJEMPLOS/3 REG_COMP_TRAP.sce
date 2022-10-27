// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : 4.Derivación e Integración Numérica
// ALGORITMO DEL TRAPECIO COMPUESTO 4.1MOD
// Traducido por: Oscar Moreira
// Para aproximar I = integral ( ( f(x) dx ) ) de 'a' a 'b':
// Entrada:   LOS PUNTOS a, b;  Y TAMBIEN UN ENTERO POSITIVO N.
//
// SALIDA:  approximacion XI hasta I.
 clc;
 funcprot(0);
 ieee(2);
 format(25);
 TRUE = 1;
 FALSE = 0;
 printf('Esta es la regla compuesta del Trapecio.\n\n');
 //printf(1,'Ingrese la funcion F(x) en terminos de x\n');
 //printf(1,'Por ejemplo: cos(x)\n');
 deff('y=F(x)',input('Digite la funcion en el formato y=F(x), Por ejemplo y=sin(x) ',"s"));
 OK = FALSE;
 while OK == FALSE 
    printf('Ingrese el limite inferior de integracion y ');
    printf('el limite superior de integracion\n');
    printf('en lineas separadas\n');
    A = input(' ');
    B = input(' ');
    if A > B 
        printf('El limite inferior debe de ser menor que el limite superior\n');
    else
        OK = TRUE;
    end
 end 
 OK = FALSE;
 while OK == FALSE 
    printf('Ingrese un numero entero positivo N.\n');
    N = input(' ');
    if N > 0 
        OK = TRUE;
    else
        printf('La entrada tiene que ser un entero positivo\n');
    end
 end
 if OK == TRUE 
    // PASO 1
    H = (B-A)/N;
    // PASO 2
     XI0 = F(A) + F(B);
    // suma de f(x(2*I-1))
    XI1 = 0.0;
   
    // PASO 3
    NN = N - 1;
    for I = 1:NN
        // PASO 4
        X = A + I * H;
        XI1 = XI1 + F(X);      
    end
    // PASO 5
    XI = (XI0 + 2.0 * XI1) * H / 2.0;
    // PASO 6
    printf('\nEL integral de F de %12.8f a %12.8f es\n', A, B);
    printf('%12.8f\n', XI);
 end
