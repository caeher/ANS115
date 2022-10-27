// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// Metodo de Muller
clc;
ieee(2);
format(25);
// f(x) = 0 necesita tres ountos de aproximacion x0,x1,x2
// ENTRADA:  x0,x1,x2; tolerancia TOL; maximo numero interaciones maxit.
// SALIDA : mensaje de aproximacion de p o de que fallo el metodo.
TRUE = 1;
FALSE = 0;
F = zeros(1,4);
X = zeros(1,4);
H = zeros(1,3);
DEL1 = zeros(1,2);
printf("This is Mullers Method.\n");
printf("Input the Polynomial P(x)\n");
printf("For example: to input x^3+3*x^2-2*x+4 enter \n");
printf(" [ 4 -2 3 1 ] los Coeficientes \n");
CP = input(" ");
P=poly(CP,'x','coeff')
OK = TRUE;
N = degree(P)+1;
if N==2 then
  r = -horner(P,N)/horner(P,(N-1));
  printf("Polynomial is linear: root is %11.8f\n",r);
  OK = FALSE;
end;
if OK == TRUE then
  OK = FALSE;
  while OK == FALSE
    TOL = input("Input tolerance  ");
    if TOL <= 0 then
      printf("Tolerance must be positive\n");
    else
      OK = TRUE;
    end;
  end;
  OK = FALSE;
  while OK == FALSE
    M = input("Input maximum number of iterations - no decimal point  ");
    if M <= 0 then
      printf("Must be positive integer\n");
    else
      OK = TRUE;
    end;
  end;
  X(1) = input("Input the first  of three starting values  ");
  X(2) = input("Input the second of three starting values  ");
  X(3) = input("Input the third  of three starting values  ");
end;
if OK == TRUE then
  printf("Select output destination\n");
  printf("1. Screen and text file\n");
  printf("2. Text file\n");
  FLAG = input("Enter 1 ó 2  ");
  if FLAG == 2 then
    printf("Input the file name in the form - drive:\\name.ext\n");
    printf("For example:   A:\\OUTPUT.TXT\n");
    NAME = input(" ","s");
    OUP = file('open',NAME,'unknown');
//  else
//    printf("Input the file name in the form - drive:\\name.ext\n");
//    printf("For example:   A:\\OUTPUT.DTA\n");
//    NAME = input(" ","s");
//    OUP = file('open',NAME,'unknown');
  end;
  printf("* METODO MÜLLERS *\n");
  text1="METODo MÜLLERS ";
  write(OUP,text1);
  printf("The output is\n iter.,  pte.real x(i), pte.imag. x(i), pte.real f(x(i)) pte.imag. f(x(i))\n\n");
  text2="The output is iteration i, approximation x(i), f(x(i))\n\n";
  write(OUP,text2);
  F(1) =horner(P,X(1));
  F(2) =horner(P,X(2));
  F(3) =horner(P,X(3));
  // STEP 1
  H(1) = X(2)-X(1);
  H (2)= X(3)-X(2);
  DEL1(1) = (F(2)-F(1))/H(1);
  DEL1(2)=(F(3)-F(2))/H(2);
  DEL = (DEL1(2)-DEL1(1))/(H(2)+H(1));
  I = 3;
  // STEP 2
  while I <= M & OK == TRUE
    // STEP 3
    B = DEL1(2)+H(2)*DEL;
    D = B*B-(4*F(3))*DEL;
    // test to see if straight line
    if abs(DEL)<=1.000000000D-20 then
      // straight line - test if horizontal line
      if abs(DEL1(2))<=1.000000000D-20 then
        printf("Horizontal Line\n");
        OK = FALSE;
      else
        // straight line but not horizontal
        X(4) =(F(3)-DEL1(2)*X(3))/DEL1(2);
        H(3) = (X(4)-X(3));
      end;
    else
      // not a straight line
      D = sqrt(D);
      // STEP 4
      E = B+D;
      if abs(B-D)>abs(E) then
        E = B-D;
      end;
      // STEP 5
      H(3) = -(2*F(3))/E;
      X(4) = (X(3)+H(3));
    end;
    if OK == TRUE then
      F(4) =horner(P,X(4));
      printf("%4d %16.12f %16.12f %16.12f %16.12f\n",I,X(4),imag(X(4)),F(4),imag(F(4)));
      write(OUP,I);
      write(OUP,real(X(4)));
      write(OUP,imag(X(4)));
      write(OUP,real(F(4)));
      write(OUP,imag(F(4)));
    end;
    // STEP 6
    if (abs(H(3))) < TOL then
      // Procedure completed successfully. 
      printf("\nMethod Succeeds\n");
      text4="\nMethod Succeeds\n";
      write(OUP,text4);
      printf("Approximation is within %.10e\n",TOL);
      write(OUP,TOL);
      printf("in %4d iterations\n",I);
      write(OUP,I);
      OK = FALSE;
    else
      // STEP 7
      for J = 1:2
        H(J) = H(J+1);
        X(J) = X(J+1);
        F(J) = F(J+1);
      end;
      X(3) = X(4);
      F(3) = F(4);
      DEL1(1) = DEL1(2);
      DEL1(2) = (F(3)-F(2))/H(2);
      DEL = (DEL1(2)-DEL1(1))/(H(2)+H(1));
    end;
    I = I+1;
  end;
  // STEP 8
  if I > M & OK == TRUE then
    printf("Method Failed\n");
    text5="Method Failed";
    write(OUP,text5);
  end;
    file('close',OUP);
    printf("Output file %s created sucessfully\n",NAME);
end;
