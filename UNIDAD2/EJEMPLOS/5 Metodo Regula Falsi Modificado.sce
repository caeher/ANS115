// METODO REGULA FALSI MODIFICADO

clc;clear;
tic();
funcprot(0);
ieee(2);
printf("\n * METODO REGULA FALSI MODIFICADO *");
ak=input('Digite el limite inferior del intervalo: ');
bk=input('Digite el limite superior del intervalo: ');
deff('y=f(x)',input('Digite la ecuacion y=f(x): ',"s"));
epsc=input("Digite el valor de eps (valor cercano a cero): ");
iterations=input('Digite el valor del maximo numero de iteraciones');
time1=toc();
while iterations <= 0
 iterations=input('Digite el valor del maximo numero de iteraciones');   
end
indicador=0;
limites=[]; // contiene los 4 limites que forman los tres posibles interval os [ak,t1] [t1,t2] [t2,bk], donde t1=Min(ck,m) y t2=Max(ck,m)
dif=[];
for i=1:iterations do
 ck=ak-((f(ak)*(bk-ak))/(f(bk)-f(ak)));
 printf('\n%2i %25.20f %25.20f',i,ck,f(ck));
 if abs(f(ck)) <= epsc then //condicion del metodo de regula falsi original
  //la aproximacion cumple el criterio de la tolerancia
  indicador=1;
  break;   
 end
 m=(ak+bk)/2;
 t1=min(ck,m); //t1 es un limite intermedio ak<t1<t2
 t2=max(ck,m); //t2 es un limite intermedio t1<t2<bk
 limites(1:4)=[ak t1 t2 bk]; //vector con los limites que forman los 3 in  tervalos
 n=0; //contador del numero de diferencias en el arreglo dif
 for j=1:3 do
  if f(limites(j))*f(limites(j+1)) < 0 then 
   n=n+1;
   dif(n)=abs(limites(j+1)-limites(j)); //dif(i) = |ls-li|
  end       
 end
 mejor=min(dif); //el mejor intervalo es el mas pequeño de todos los inte  rvalos que cumplen que f(limite_inferior)*f(limite_superior) < 0  
 for j=1:3 do
  if abs(limites(j+1)-limites(j)) == mejor then
   ak=limites(j);
   bk=limites(j+1);   
  end       
 end
end  
time2=toc();
printf("\n\nLa raiz encontrada fue : %f",ck);
if indicador == 0 then
 printf("\n\nLa aproximacion no cumple el criterio de la tolerancia");   
end
printf("\n\nSe necesitaron %i iteraciones",i);
printf("\nel metodo tardo %f segundos en encontrar la raiz",time2-time1);  
printf("\ntiempo total de ejecucion del programa: %f segundos",toc());   
