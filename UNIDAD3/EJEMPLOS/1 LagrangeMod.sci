// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica - Metodo Lagrange
// LAGRANGEMOD 
// approx a point-defined function using the Lagrange polynomial interpolation
clc;
ieee(2);
format(25);
funcprot(0);
TRUE = 1;
FALSE = 0;
printf('Este es el Metodo de Lagrange MODIFICADO.\n\n');
OK = FALSE;
while OK == FALSE 
     printf('Input el número de nodos a ingresar:');
     N = input(' ');
     N=N-1;
     if N > 0 
            OK = TRUE;
            X = zeros(N+1);
            Q = zeros(N+1,N+1);
            for I = 0:N
                printf('Input X(%d) and F(X(%d)) ', I, I);
                printf('on separate lines');
                X(I+1) = input(' ');
                Q(I+1,1) = input(' ');
            end
      else 
            printf('Number must be a positive integer');
      end
end
if OK == TRUE 
    printf('Seleccione el destino de la salida\n');
    printf('1. Monitor\n');
    printf('2. Archivo de Texto\n');
    printf('Digite 1 o 2\n');
    FLAG = input(' ');
    if FLAG == 2
        printf('Introduzca el nombre del archivo - drive:\\nombre.ext\n');
        printf('Por ejemplo:   A:\\SALIDA.TXT\n');
        NAME = input(' ','s'); 
        OUP = file('open',NAME,'unknown');
    else
        OUP = 1;
    end
end    
pointx=X;
pointy=Q;
printf('Input el nodo de interpolación: x\n');
x = input(' ');
n=length(pointx);
L=ones(n,length(x));
   for i=1:n
      for j=1:n
         if (i~=j)
            L(i,:)=L(i,:).*(x-pointx(j))/(pointx(i)-pointx(j));
         end
      end
   end
y=0;
  for i=1:n
      y=y+pointy(i)*L(i,:);
  end
if OUP == 1 then
    printf('Input data follows:\n');
else
    text1='Input data follows:\n'
    write(OUP,text1)
end
for I = 0:N
    if OUP == 1 then
       printf('X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));
    else
       text2='X(%d) = %12.8f F(X(%d)) = %12.8f\n'
       write(OUP,text2)
       write(OUP,I);
       write(OUP,X(I+1));
       write(OUP,I);
       write(OUP,Q(I+1,1));
    end
end
if OUP == 1 then
printf('El valor de interpolación es :\n');
else
    text2='El valor de interpolación es :'
    write(OUP,text2)
end
if OUP == 1 then
printf('%12.8f\n', y);
else
    write(OUP,y)
end
if OUP ~= 1 
   file('close',OUP);
   printf('Output file %s created successfully\n',NAME);
end
