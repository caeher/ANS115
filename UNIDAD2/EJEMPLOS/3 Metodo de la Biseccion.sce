// Universidad de El Salvador
// Asignatura ANALISIS NUMERICO
// Método de Bisección
// Ejecutar segun el ejercicio pag 51 Richard Burde
clc;clear;
cont=0;
format(25);
deff('y=f(x)',input('ingrese la ecuación en el formato y=f(x)           :-->',"s"));
//deff('y=f(x)','y=x.^3+4*x.^2-10')
//deff('y=f(x)','y=sqrt(x)-cos(x)')
a=input('Ingrese el extremo izquierdo del intervalo de definición de f  :-->');
b=input('Ingrese el extremo derecho del intervalo de definición de f    :-->');
if a>b then
    c=a;
    a=b;
    b=c;
end;
if f(a)*f(b)>=0 then
    printf('El Método no es Aplicable');
    return;
end;
tol=input('Ingrese el valor de la tolerancia');
maxit=input('Ingrese el número máximo de iteraciones');
i=1;
FA=f(a);
printf('\n K            X                      F(x)')
printf('\n__________________________________________________')
while (i<=maxit)
    p=a+(b-a)/2;
    cont=cont+1;
    printf('\n%2i %25.20f %25.20f',cont,p,f(p));
    FP=f(p);
    if ((FP==0)|((b-a)/2<tol)) then
        //cont=cont+1;
        printf('\n\nEl valor encontrado de la raíz es:%24.20f en la iteracion **%i** ',p,cont);
        printf("\nLa funcion evaluada en p es:  %25.20f",FP);
        
        return;
    end;
    i=i+1;
    if FA*FP>0 then
        a=p;
        FA=FP;
    else
        b=p;
    end
end

printf('el Método fracasó');
return;
