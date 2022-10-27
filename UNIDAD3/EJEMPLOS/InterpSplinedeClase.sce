// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica , 
//  GRAFICA CUBICA NATURAL - SUJETO
    clear, clf;
    x = [ -0.5 -0.4 -0.25 0]  
 //   y = [ -0.02475 0.128878 0.3349375 1.101] // Datos Cubico Natural
    y = [ -0.02475 0.07636 0.3349375 1.101]   // Datos Cubico Sujeto
    n = length(x);
   xx = ( -0.5:0.1:0 );
    d = splin(x, y);
   ys = interp(xx, x, y, d);
   xgrid()
   plot(xx,ys,-9) 
   plot(xx,ys,'ro')
   
//plot2d(X,A,-9, strf="000") 
