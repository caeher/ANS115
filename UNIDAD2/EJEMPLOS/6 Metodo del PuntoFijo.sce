// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// Metodo del Punto Fijo
tic();clc;
ieee(2);
x0=input('Digite la aproximacion inicial a la raiz: ');
eps=input('Digite la tolerancia:');
deff('y=fx(x)',input('Digite la ecuacion en el formato y=G(x)',"s"));
maxit=input('Digite el numero maximo de iteraciones:');
t1=toc();
xk=x0;
indic=0;
 printf('\n     - Metodo del Puto Fijo -');
 printf('\n    K       Ck                G(Ck)');
 printf('\n    ___________________________________ ')
for i=1:maxit do
 xa=xk;
 xk=fx(xk);
 printf('\n %4d %16.12f %16.12f',i,xa,xk);
 if abs(xk-xa) <=eps then
  indic=1;
  break;
 end      
end
t2=toc();
printf("\n\nLa raiz encontrada fue: %16.10f",xk);
if indic == 0 then
 printf("\nel metodo no converge al valor de la raiz, puede que el valor sea incorrecto");
end
printf("\npara encontrar la raiz se necesitaron %i iteraciones",i);   
printf("\nel metodo tardo %f segundos en encontrar la raiz",t2-t1);  
printf("\ntiempo total de ejecucion del programa: %f segundos",toc());    
