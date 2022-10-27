// Derechos (C) 2015 - Corporation - UES
// Autor : J Mauricio Coto 
// Fecha de Creación: 03-10-2018
// Materia : Analisis Numerico, UES
// Nota: Apoyarse con la Ayuda ? de Scilab
// Limpia Comandos 
clc;
// Define una funcion con deff() investigarla
deff('y=f(x)','y=x.^5-3*x.^4+10*x-8');// modificar la funcion y

// define un rango de x en estudio con paso de 0.1, entre 0.5 y 3
x=0.5:0.1:2;//El estudiante debe ampliar o reducir este Rango 0.5 y 3

//Graficar
plot(x,f(x))

// Cuadricula de fondo para el grafico 
xgrid(5)
//Examinar el menu del Grafico:File ,Tool y Edit,Mazimixar la Grafica
//Investigar comandos deff, plot, xgrid, clear y cambiar parametros como
//Color del grafico y del grid o tamaño, Encabezado del grafico

// investigar la funcion fsolve
[raiz,raizenfunc,info]=fsolve(2,f);
    disp(raiz,"Raiz encontrada :")
    disp(raizenfunc,"Aproximacion a Cero:")
    disp(info);
