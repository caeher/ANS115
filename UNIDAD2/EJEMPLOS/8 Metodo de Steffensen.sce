// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// Metodo de Steffensen
clc;
tic();
deff('x=g(x)',input('Digite la ecuacion en el formato x=g(x) :',"s"));
maxit=input('Digite el numero maximo de iteraciones: ');
tol=input('Digite el valor de la tolerancia: ');
p0=input('Digite la aproximacion inicial: ');
//si ind = 1 se cumple el criterio de la tolerancia 
//si ind = 0 no se cumple el criterio de la tolerancia
t1=toc();
i=1;
printf("\n Metodo de Steffensen ");
while i <= maxit 
 p1=g(p0);
 p2=g(p1);
 p=p0-(((p1-p0)^2)/(p2-2*p1+p0));
 printf("\n %i %f",i,p);
 if abs(p-p0) < tol then
   printf("\nEl valor aproximado de la raiz es: %f",p);
   printf("\nel metodo tardo %f segundos en encontrar la raiz",toc()-t1);  
   printf("\ntiempo total de ejecucion del programa: %f segundos",toc());
   return;
 end
 i=i+1;
 p0=p;
end
printf("\nEl metodo fallo");
