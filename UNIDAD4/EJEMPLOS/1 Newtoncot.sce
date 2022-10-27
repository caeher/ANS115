// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : 4.Derivación e Integración Numérica
//
//ENTRADAS: tipo de formula (abierta o cerrada), n, x0, xn y fx.
//SALIDAS: r (aproximacion).
clc;
funcprot(0);
ieee(2);
format(25);
printf('\nAPROXIMACION DE INTEGRALES MEDIANTE NEWTON-COTES.\n');
printf('Recuerde que:\nEn las formulas cerradas,\n   si n=1: Regla trapezoidal,\n   si n=2: De Simpson,\n   si n=3: Regla de tres octavos de Simpson.');
printf('\nEn las formulas abiertas,\n   si n=0: Regla del punto medio.\n\n');
OK = 0;
while OK == 0
    printf('Ingrese el tipo de formula\n1. Cerrada\n2. Abierta\n');
    tipoFormula = input(' ');
    if tipoFormula == 1 | tipoFormula == 2
        OK = 1;
    else
        printf('ERROR: Ingrese nuevamente.\n');
    end
end
if tipoFormula == 1
    OK = 0;
    while OK == 0
        printf('Ingrese n (entre 1 y 4):\n');
        n = input(' ');
        if n == 1 | n == 2 | n == 3 | n == 4
            OK = 1;
        else
            printf('ERROR: Ingrese nuevamente.\n');
        end
    end
else
    OK = 0;
    while OK == 0
        printf('Ingrese n (entre 0 y 3):\n');
        n = input(' ');
        if  n == 0 | n == 1 | n == 2 | n == 3
            OK = 1;
        else
            printf('ERROR: Ingrese nuevamente.\n');
        end
    end
end
if tipoFormula == 1
    printf('Ingrese x0:\n');
else
    printf('Ingrese x-1:\n');
//x0 = input(' ');
end
x0 = input(' ');
if tipoFormula == 1
    printf('Ingrese x%d:\n', n);
else
    printf('Ingrese x%d:\n', n+1);
end
xn = input(' ');
//printf('Ingrese f(x) en terminos de x:\n');
//printf('Por ejemplo: sin(x)\n');

deff('y=f(x)',input('Digite la funcion en el formato y=f(x), Por ejemplo: y=sin(x)',"s"));
//f = inline(funcion,'x');
if tipoFormula == 1
    h=(xn-x0)/n;
    if n == 1
        r = (h/2)*(f(x0)+f(xn));
    end
    if n == 2
        r = (h/3)*(f(x0)+4*f(x0+h)+f(xn));
    end
    if n == 3
        r = ((3*h)/8)*(f(x0)+3*f(x0+h)+3*f(x0+2*h)+f(xn));
    end
    if n == 4
        r = ((2*h)/45)*(7*f(x0)+32*f(x0+h)+12*f(x0+2*h)+32*f(x0+3*h)+7*f(xn));
    end
else
    h=(xn-x0)/(n+2);
    if n == 0
        r = 2*h*f(x0+h);
    end
    if n == 1
        r = ((3*h)/2)*(f(x0+h)+f(xn-h));
    end
    if n == 2
        r = ((4*h)/3)*(2*f(x0+h)-f(x0+2*h)+2*f(xn-h));
    end
    if n == 3
        r = ((5*h)/24)*(11*f(x0+h)+f(x0+2*h)+f(xn-2*h)+11*f(xn-h));
    end
end
err = abs(double(intg(x0,xn,f))- r);
printf('\nSeleccione el tipo de salida\n');
printf('1. En pantalla\n');
printf('2. En archivo de texto\n');
printf('3. En pantalla y archivo de texto\n');
opcion = input(' ');
//imprime en archivo o en pantalla
if opcion == 1 | opcion == 2
    if opcion == 2
        printf('Ingrese el nombre del archivo de la forma: drive:\\name.ext\n');
        printf('Por ejemplo:   A:\\Output.dta\n');
        nombre = input(' ',"s");
        salida = mopen(nombre,'wt');
    end
    printf('\n');
    if opcion == 1
        printf('*** Aproximaciones con algunas formulas abiertas y cerradas de Newton-Cotes ***\n\n');
    else
        mputl('*** Aproximaciones con algunas formulas abiertas y cerradas de Newton-Cotes ***\n\n',salida);
    end
    
    if tipoFormula == 1
        if opcion == 1
            printf('Formula cerrada con n = %d\n', n);
        else
            mfprintf(salida,'Formula cerrada con n = %d\n', n);
        end
    else
        if opcion == 1
            printf('Formula abierta con n = %d\n', n);
        else
            mfprintf(salida,'Formula abierta con n = %d\n', n);
        end 
    end
    if opcion == 1
        printf('Aproximaci�n = %.10e\n', r);
        printf('Error = %.10e\n', err);
    else
        mfprintf(salida,'Aproximaci�n = %.10e\n', r);
        mfprintf(salida,'Error = %.10e\n', err);
    end
    if opcion ~= 1
        mclose(salida);
        printf('Archivo %s creado exitosamente\n',nombre);
    end
//imprime en archivo y en pantalla
else
    printf('Ingrese el nombre del archivo de la forma: drive:\\name.ext\n');
    printf('Por ejemplo:   A:\\Output.dta\n');
    nombre = input(' ',"s");
    salida = mopen(nombre,'wt');
    //impresion en pantalla
    printf('\n*** Resultados de aproximaciones mediante Newton-Cotes ***\n\n');
    if tipoFormula == 1
        printf('Formula cerrada con n = %d\n', n); 
    else
        printf('Formula abierta con n = %d\n', n); 
    end
    printf('Aproximacion = %.10e\n', r);
    printf('Error = %.10e\n', err);
    //impresion en archivo
    mfprintf(salida,'\n*** Resultados de aproximaciones mediante Newton-Cotes ***\n\n');
    if tipoFormula == 1
        mfprintf(salida,'Formula cerrada con n = %d\n', n); 
    else
        mfprintf(salida,'Formula abierta con n = %d\n', n); 
    end
    mfprintf(salida,'Aproximacion = %.10e\n', r);
    mfprintf(salida,'Error = %.10e\n', err);
    mclose(salida);
    printf('Archivo %s creado exitosamente\n',nombre);
end
