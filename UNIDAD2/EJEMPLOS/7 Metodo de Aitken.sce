// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// Metodo delta cuadrado de Aitken

N=input('Digite la cantidad de valores a generar: ');   
deff('y=Pn(n)',input('Digite la sucesion en el formato y=Pn(n)',"s"));
printf("\n  Metodo de Aitken ");
i=1;
while i <= N do
 P1=Pn(i);
 P2=Pn(i+1);
 P3=Pn(i+2);
 R(i)=P1-((P2-P1)^2/(P3-2*P2+P1));
 printf("\nR(%i)= %f %f",i,P1,R(i));
 i=i+1;   
end
