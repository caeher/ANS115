// Universidad de El Salvador
// Fecha de Creación: 03-11-2018
// Materia: Analisis Numerico
clc;clear
deff('y=f(x)','y=x.^5-3*x.^4+10*x-8')
//*************
eps0 = 1.0e-12
tol=0.00001  // pruebe cambiar la tolerancia
//*************
x0= 0.5
x = x0
h = 0.01
x1 = x0 + h
f0 = f(x0)
f1 = f(x1)
printf('\n K         Xk           F(Xk)')
printf('\n____________________________________')
printf('\n %i %12.6f %15.8f',0,x0,f0)
printf('\n %i %12.6f %15.8f',1,x1,f1)
for k=2:30
    den = f1-f0
    if abs(den) <= eps0
        ind = 0
        return
    end
    d2 = f1*(x1-x0)/den
    x2 = x1 - d2
    f2 = f(x2)
    printf('\n %i %12.6f %15.10f',k,x2,f2)
    if abs(f2) <= tol | abs(d2) <= tol
       printf('\n\n * La raíz es: %17.12f',x2);
       return
    end
    x0 = x1, f0 = f1
    x1 = x2, f1 = f2
end

