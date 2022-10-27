// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica
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
// syms('OK', 'FLAG', 'N', 'I', 'X', 'Q', 'A', 'NAME', 'INP','OUP', 'J');
// syms('s','x');
funcprot(0);
 ieee(2);
 format(25);
 clc;
 TRUE = 1;
 FALSE = 0;
 printf('Forma del polinomio de interpolación de NEWTON\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Elija el método de entrada:\n');
     printf('1. Ingresar entrada por medio del teclado\n');
     printf('2. Ingresar datos desde un archivo de texto\n');
     printf('3. Generar datos unsando una función F\n');
     printf('Escoja 1, 2, o 3 por favor\n');
     FLAG = input(' ');
     if FLAG == 1 | FLAG == 2 | FLAG == 3 
         OK = TRUE;
     end
 end
 if FLAG == 1 
     OK = FALSE;
     while OK == FALSE 
         printf('Ingrese n\n');
         N = input(' ');
         if N > 0 
             OK = TRUE;
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Ingrese X(%d) y F(X(%d)) ', I, I);
                 printf('en líneas separadas\n');
                 X(I+1) = input(' ');
                 Q(I+1,1) = input(' ');
             end
         else 
             printf('El número debe ser un entero positivo\n');
         end
     end
 end
 if FLAG == 2 
     printf('¿Ha creado con los datos una columna en un archivo de texto?\n');
     printf('Digite Y o N\n');
     A = input(' ','s');
     if A == 'Y' | A == 'y' 
         printf('Ingrese el nombre del archivo en la forma - ');
         printf('drive:\\name.txt\n');
         printf('por ejemplo:   E:\\DATA.txt\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         OK = FALSE;
         while OK == FALSE 
             printf('Ingrese n\n'); 
             N = input(' ');
             if N > 0                   
                 X = zeros(N+1);
                 Q = zeros(N+1,N+1);
                 for I = 0:N
                      X(I+1) = fscanf(INP,'%f');
                    Q(I+1,1) = fscanf(INP,'%f');
                 end
                 mclose(INP);
                 OK = TRUE;
             else
                 printf('El número debe ser un entero positivo\n')
             end
         end
     else
         printf('Por favor crear la entrada del archivo en UNA columna ');
         printf('Formada con los valores de X y F(X)\n');
         printf('los valores de F(X) deben ir despues de cada X correspondiente.\n');
         printf('El programa terminará para que el archivo ');
         printf('se puede crear.\n');
         OK = FALSE;
     end
 end
 if FLAG == 3 
     printf('Ingrese la funcion F(x) en terminos de x\n');
     printf('Por ejemplo: y=3*x^3-2*x^2+1\n');
     s = input(' ','s');
     deff('y=F(x)',s);
     OK = FALSE;
     while OK == FALSE 
         printf('Ingrese n\n');
         N = input(' ');
         if N > 0 
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Ingrese X(%d)\n', I);
                 X(I+1) = input(' ');
                 Q(I+1,1) = F(X(I+1));
             end
             OK = TRUE;
         else
             printf('El número debe ser un entero positivo\n');
         end
     end
 end
 if OK == TRUE 
     printf('Seleccione el tipo de salida\n');
     printf('1. Pantalla\n');
     printf('2. Archivo de texto\n');
     printf('Ingrese 1 o 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Ingrese el nombre del archivo de la forma - drive:\\name.ext\n');
         printf('Por ejemplo:   E:\\SALIDA.TXT\n');
         NAME = input(' ','s');
         OUP = file('open',NAME,'unknown');
         text1='NEWTONS INTERPOLATION POLYNOMIAL\n\n'
         write(OUP,text1);
     else
         OUP = 1;
     end
     if OUP==1 then
         printf('INTERPOLACION POLINOMIAL DE NEWTON\n\n');
     else
         text2='INTERPOLACION POLINOMIAL DE NEWTON\n\n';
         write(OUP,text2); 
     end
//     fprintf(OUP, 'INTERPOLACION POLINOMIAL DE NEWTON\n\n');
     //% STEP 1
     for I = 1:N
         for J = 1:I
             Q(I+1,J+1) = (Q(I+1,J) - Q(I,J)) / (X(I+1) - X(I-J+1));
         end
     end
     //% STEP 2
     if OUP==1 then
         printf('Input data follows:\n');
     else
         text3='Input data follows:\n';
         write(OUP,text3); 
     end
//     fprintf(OUP, 'Los datos de entrada son:\n');      
//     %esta parte es la que he agregado--------------------------------
     for I = 0:N
        //%fprintf(OUP, '%12.8f\n', Q(I+1,I+1));
     if OUP==1 then
         printf('X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));
     else
         text4='------------------------------------';
         //text4='X(%d) = %12.8f F(X(%d)) = %12.8f\n';
         write(OUP,text4);
         write(OUP,I);
         write(OUP,X(I+1));
//         write(OUP,I);
         write(OUP,Q(I+1,1));     
     end
//        fprintf(OUP,'X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));
        //%esto le modifique-------
     end
    //%imprimiendo todas las diferencias divididas calculadas
     if OUP==1 then
         printf('********* MATRIZ ********\n');
     else
         text5='********* MATRIZ ********\n';
         write(OUP,text5); 
     end

//     fprintf(OUP, '********* MATRIZ ********\n');
     for I = 1:N+1
         for J = 1:I
            
                 if OUP==1 then
                     printf('%12.8f ', Q(I,J));
                 else
                     //text6='%12.8f ';
                     //write(OUP,text6);
                     write(OUP,Q(I,J)); 
                 end
            
            //fprintf(OUP, '%12.8f ', Q(I,J));
         end
         if OUP==1 then
                     printf('\n');
         else
                     text7='-.-.-.-.-.-.-.-.-.-.-';
                     write(OUP,text7);
         end
//         fprintf(OUP, '\n');
     end
     //% fin de la impresión
     if OUP ~= 1 
        file('close',OUP);
        printf('Output file %s created successfully\n',NAME);
     end
 end

