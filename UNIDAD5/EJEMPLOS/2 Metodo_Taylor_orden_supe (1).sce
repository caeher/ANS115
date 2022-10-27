// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema 5:Técnicas de Solución de Ecuaciones Diferenciales 
//-------Metodo de taylor de orden superior-------------
clc;
funcprot(0);
TRUE = 1;
FALSE= 0;
printf('Este es el metodo de Taylor de Orden Superior');
deff('[F,Q]=f(t,y)',input('Ingrese la funcion F(t,y) en terminos de (t,y) Ejemplo F= y+t :->','s'));
//*****************************************************************************
OK= FALSE;
while OK== FALSE
    printf('Ingrese los puntos del extremo t en lineas separadas \n');
    A= input('Ingrese A:->');
    B= input('Ingrese B:->');
    if A>= B then
        printf('Punto izquierdo debe ser menor que el extremo derecho\n')
    else
        OK=TRUE
    end
end
//*****************************************************************************
printf('Ingrese la condicion inicial Wo\n');
ALPHA = input('');

OK= FALSE;
while OK==FALSE
    printf('Ingrese un entero positivo N (numero de subintervalos)\n');
    printf('para poder calcular el paso h.\n');
    //H=(B-A)/N
    N= input('');
    if N<=0 then
        printf('\nEl numero debe ser un entero positivo\n');
    else
        OK= TRUE;
    end
end
//*****************************************************************************
OK=FALSE;
while OK== FALSE
    printf('\n\nIngrese un entero positivo n (# de orden de taylor)\n');
    printf('Este programa solo calcula para orden 2, 3 y 4 \n')
    ORDEN = input('');
    if ORDEN<2 | ORDEN>4 then
        printf('El numero debe ser un entero positivo entre 2 y 3');
    else
        OK=TRUE;
    end
end
//*****************************************************************************
// PASO 1 CALCULANDO EL PASO h
H= (B-A)/N;
t= zeros(1,N);// Se reserva espacio para llenar el vector con las iteraciones
              //y el extremo izquierdo A
w=zeros(1,N);
t(1,1)= A;
w(1,1)=ALPHA //Wo inicial

//****************************************************************************
//PASO 2 se llena el vector t para las siguiente evaluaciones
for I=1:N
    t(1,I+1)=A+H*I;
end
    
//*****************************************************************************
//PASO 3
if ORDEN ==2 then
    printf('\n\nIngrese la primera derivada F(t,w)\n');
    printf('ANTES DE CONTINUAR CALCULE BIEN LA PRIMERA DERIVADA DE F\n');
    printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
    deff('[DF,Q]=FP1(t,w)',input('por ejemplo: DF= -t^2+1    ->','s'));
    TLR=zeros(1,N);
    for I=1:N
        //Calculando el segundo polinomio de Taylor
        //TLR = f + (H/2)*FP1
        TLR(1,I)=f( t(1,I) , w(1,I)) + (H/2)*FP1(t(1,I),w(1,I));
        //Calculando las w(i) de manera recurrente
        w(1,I+1)=w(1,I)+H*TLR(1,I);
    end
else
    if ORDEN == 3 then
       printf('\n\nIngrese la primera derivada F(t,w)\n');
       printf('ANTES DE CONTINUAR CALCULE BIEN LA PRIMERA DERIVADA DE F\n');
       printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
       deff('[DF,Q]=FP1(t,w)',input('por ejemplo: DF= -t^2+1','s'));
       printf('\n\nIngrese la segunda derivada F(t,w)\n');
       printf('ANTES DE CONTINUAR CALCULE BIEN LA SEGUNDA DERIVADA DE F\n');
       printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
       deff('[TF,Q1]=FP2(t,w)',input('por ejemplo: TF= -t^2+1','s'));
       
       TLR=zeros(1,N);
       for I=1:N
           //Calculando el tercer polinomio de taylor
           //TLR = f + (H/2)*FP1 + (H^2/6)*FP2
           TLR(1,I)= f( t(1,I),w(1,I))  +  (H/2)*FP1(t(1,I),w(1,I))  +  (H^2/6)*FP2(t(1,I),w(1,I));
           w(1,I+1)= w(1,I)+H*TLR(1,I)
       end
   else
       printf('\n\nIngrese la primera derivada F(t,w)\n');
       printf('ANTES DE CONTINUAR CALCULE BIEN LA PRIMERA DERIVADA DE F\n');
       printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
       deff('[DF,Q]=FP1(t,w)',input('por ejemplo: DF= -t^2+1','s'));
       printf('\n\nIngrese la segunda derivada F(t,w)\n');
       printf('ANTES DE CONTINUAR CALCULE BIEN LA SEGUNDA DERIVADA DE F\n');
       printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
       deff('[TF,Q]=FP2(t,w)',input('por ejemplo: TF= -t^2+1','s'));
       printf('\n\nIngrese la tercera derivada F(t,w)\n');
       printf('ANTES DE CONTINUAR CALCULE BIEN LA TERCERA DERIVADA DE F\n');
       printf('RECUERDE que la funcion tiene que estar en terminos de t y w\n')
       deff('[CF,Q]=FP3(t,w)',input('por ejemplo: CF= -t^2+1','s'));
       
       TLR=zeros(1,N);
       for I=1:N
           //Calculando el tercer polinomio de taylor
           //TLR = f + (H/2)*FP1 + (H^2/6)*FP2 + (H^3/24)*FP3
           TLR(1,I)= f( t(1,I),w(1,I))  +  (H/2)*FP1(t(1,I),w(1,I))  +  (H^2/6)*FP2(t(1,I),w(1,I))  +  (H^3/24)*FP3(t(1,I),w(1,I));
           w(1,I+1)= w(1,I)+H*TLR(1,I)
       end
    end
end
//***********************************************************************
printf('\n\n Metodo de TAYTLOR DE ORDEN SUPERIOR DE ORDEN %d\n',ORDEN);
printf('    t    w\n');
for I=1:(N+1)
    printf('    %5.3f    %11.7f\n',t(1,I),w(1,I))   
 end

 plot(t,w)   

