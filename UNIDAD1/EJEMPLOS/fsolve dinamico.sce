// Copyright (C) - UES,FIA,EISI - 
// Autor : J Mauricio Coto
// Puede usar este programa como modelo para hacer sus propios programas
//
// Fecha de Creación: 03-10-2018
//Probar este programa con sin(x), a = -1 y b=5 y observar, cambiar a y b
clc;
ieee(2);
format(7);
funcprot(0);
// Definimos una funcion con deff()
deff('y=f(x)',input('Digite la ecuacion en el formato y=f(x)',"s"));
a=input('Digite el limite inferior del intervalo: ');
b=input('Digite el limite superior del intervalo: ');

// x es el intervalo en estudio con limites de a y b digitados
x=a:0.01:b; // probar con diferentes valores

// Graficar plot()
plot(x,f(x))
// El estudiante debe realizar varias pruebas con intervalos diferentes
// y funciones diferente y observar si hay Raices de la funcion f(x)=0


