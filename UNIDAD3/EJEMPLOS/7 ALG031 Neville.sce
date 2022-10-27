// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico
// Tema : Interpolacion Numerica 
// % NEVILLE'S ITERATED INTERPOLATION ALGORITHM 3.1
// % To evaluate the interpolating polynomial P on the
// % (n+1) distinct numbers x(0), ..., x(n) at the number x
// % for the function f:
// % INPUT:   numbers x(0),..., x(n) as XX(0),...,XX(N);
// %          number x; values of f as the first column of Q
// %          or may be computed if function f is supplied.
// % OUTPUT:  the table Q with P(x) = Q(N+1,N+1).
// syms('TRUE', 'FALSE', 'OK', 'FLAG', 'N', 'I', 'XX', 'Q', 'A', 'NAME');
// syms('INP', 'X', 'D', 'J', 'OUP','x','s');
 clc;
 funcprot(0);
 format(25);
 ieee(2);
 t0=timer()
 TRUE=1;
 FALSE=0;
 printf('This is Nevilles Method.\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Choice of input method:\n');
     printf('1. Input entry by entry from keyboard\n');
     printf('2. Input data from a text file\n');
     printf('3. Generate data using a function F\n');
     printf('Choose 1, 2, or 3 please\n');
     FLAG = input(' ');
     if FLAG == 1 | FLAG == 2 | FLAG == 3 
         OK = TRUE;
     end
 end
 if FLAG == 1 
     OK = FALSE;
     while OK ~= TRUE 
         printf('Input n\n');
         N = input(' ');
         if N > 0 
             OK = TRUE;
             XX = zeros(N+1);
             Q = zeros(N+1,N+1);
             t1=timer();
             for I = 0:N
                 printf('Input X(%d) and F(X(%d)) ', I, I);
                 printf('on separate lines.\n');
                 XX(I+1) = input(' ');
                 Q(I+1,1) = input(' ');
             end
         else
             printf('Number must be a positive integer\n');
         end
     end
 end
 if FLAG == 2 
     printf('Has a text file been created with the data in one column?\n');
     printf('Enter Y or N\n');
     A = input(' ','s');
     if A == 'Y' | A == 'y' 
         printf('Input the file name in the form - ');
         printf('drive:\\name.ext\n');
         printf('For example:   E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         OK = FALSE;
         while OK == FALSE 
             printf('Input N\n');
             N = input(' ');
             if N > 0 
                 XX = zeros(N+1);
                 Q = zeros(N+1,N+1);
                 t2=timer();
                 for I = 0:N
                     XX(I+1) = fscanf(INP, '%f');
                     Q(I+1,1) = fscanf(INP, '%f');
                 end
                 mclose(INP);
                 OK = TRUE;
             else
                 printf('Number must be a positive integer\n');
             end
         end
     else
         printf('Please create the input file in one column ');
         printf('form with the X values followed by F(X) values\n');
         printf('The program will end so the input file can ');
         printf('be created.\n');
         OK = FALSE;
     end
 end
 if FLAG == 3 
     printf('Input the function F(x) in terms of x\n');
     printf('For example: y=3*x^3-2*x^2+1\n');
     s = input(' ');
     deff('y=F(x)',s);
     OK = FALSE;
     while OK == FALSE 
         printf('Input n\n');
         N = input(' ');
         if N > 0 
             XX = zeros(N+1);
             Q = zeros(N+1,N+1);
             t3=timer();
             for I = 0:N
                 printf('Input X(%d)\n', I);
                 XX(I+1) = input(' ');
                 Q(I+1,1) = F(XX(I+1));
             end
             OK = TRUE;
         else
             printf('Number must be a positive integer\n');
         end
     end
 end
 if OK == TRUE 
     printf('Input point at which the polynomial is to be evaluated\n');
     X = input(' ');
 end
 if OK == TRUE 
//% STEP 1
     t4=timer();
     D = zeros(N+1);
     D(1) = X-XX(1);
     for I = 1:N
         D(I+1) = X-XX(I+1);
         for J = 1:I
             Q(I+1,J+1) = (D(I+1)*Q(I,J)-D(I-J+1)*Q(I+1,J))/(D(I+1)-D(I-J+1));
         end
     end
//% STEP 2
     printf('Select output destination\n');
     printf('1. Screen\n');
     printf('2. Text file\n');
     printf('Enter 1 or 2\n');
     FLAG = input(' ');
     if FLAG == 2 
         printf('Input the file name in the form - drive:\\name.ext\n');
         printf('For example:   E:\\OUTPUT.TXT\n');
         NAME = input(' ','s');
         OUP = file('open',NAME,'unknown');
     else
         OUP = 1;
     end
     if OUP==1 then
         printf('NEVILLES METHOD\n');
     else
         text1='NEVILLES METHOD'
         write(OUP,text1);
     end
     if OUP==1 then
         printf('Table for P evaluated at X = %12.8f , follows: \n', X);
     else
         text2='Table for P evaluated at X , follows: ';
         write(OUP,text2)
     end
     if OUP==1 then
         printf('Entries are XX(I), Q(I,0), ..., Q(I,I) ');
     else
         text3='Entries are XX(I), Q(I,0), ..., Q(I,I) ';
         write(OUP,text3)
     end
     if OUP==1 then
         printf('for each I = 0, ..., N where N = %3d\n\n', N);
     else
         text4='for each I = 0, ..., N where N = ';
         write(OUP,text4);
         write(OUP,N)
     end
 //fprintf(OUP, 'NEVILLES METHOD\n');
 //fprintf(OUP, 'Table for P evaluated at X = %12.8f , follows: \n', X);
 //fprintf(OUP, 'Entries are XX(I), Q(I,0), ..., Q(I,I) ');
 //fprintf(OUP, 'for each I = 0, ..., N where N = %3d\n\n', N); 
     for I = 0:N
         if OUP==1 then
             printf('%11.8f ', XX(I+1));
         else
             text5='--------------------';
             write(OUP,text5)
             write(OUP,XX(I+1))
         end
         
         //fprintf(OUP, '%11.8f ', XX(I+1));
         for J = 0:I
             if OUP==1 then
                 printf('%11.8f ', Q(I+1,J+1));
             else
                 text6='--------------------';
                 write(OUP,text6)
                 write(OUP,Q(I+1,J+1)) 
             end
             
             
             //fprintf(OUP, '%11.8f ', Q(I+1,J+1));
         end
         if OUP==1 then
             printf('\n');
         else
             text7='--------------------';
             write(OUP,text7)
         end
         
         
//         fprintf(OUP, '\n');
     end
     t5=timer()
     time=t5;
     if OUP ~= 1 
         if OUP==1 then
             printf('%11.8f ',time);
         else
             text8='--------------------';
             write(OUP,text8)
             //write(OUP,time)
         end
         if OUP==1 then
             printf('el tiempo de máquina es %11.8f \n\n', time);
         else
             text9='----el tiempo fue ------';
             write(OUP,text9);
             write(OUP,time);
         end
         //fprintf(OUP, '%11.8f ',time);
         file('close',OUP);
         printf('Output file %s created successfully\n',NAME);
     end
     
     //fprintf(OUP, 'el tiempo de máquina es %11.8f \n\n', time);
 end
