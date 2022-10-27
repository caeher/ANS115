// Universidad de El Salvador
// Mateia : Analisis Numerico
// METODO DE NEWTON
//f(x) = y=x.^5-3*x.^4+10*x-8
clc;clear;
// defininir funciones
deff('y=f(x)','y=x.^5-3*x.^4+10*x-8')
deff('yder =fder(x)','yder=5*x^4-12*x^3+10')
disp("* Metodo de Newton");
format('v',16)
dif=1.0; a=0.0;
tolerancia=00001;
a=input('Digite el valor inicial:');

iter=0;
while dif >= 0.00001
  aant = a
  a = a - (f(a)/fder(a))
  disp(a)
  dif =abs(aant-a)
  iter=iter + 1 ;
end
disp("Iteraciones:");
disp(iter);
// G R A F I C A
x=0:.2:3;
y=f(x);
plot2d(x,y)
xgrid(5)
