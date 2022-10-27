// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica
// Diferencias Divididas de Newton
clc;
format(25);
ieee(2);
funcprot(0);

 TRUE = 1;
 FALSE = 0; 
 printf('Polinomio de interpolacion de NEWTON\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Elija el metodo de entrada:\n');
     printf('  1. Ingresar entrada por medio del teclado\n');
     printf('  2. Ingresar datos desde un archivo de texto\n');
     printf('  3. Generar datos unsando una funcion F\n');
     printf('  4. Salir de la Aplicacion\n\n');
     printf('metodo de entrada: ');
     FLAG = input(' ');
     
         if FLAG > 0 & FLAG < 5
             OK = TRUE;
         end
     //end
 end
 if FLAG== 1
     OK = FALSE;
     while OK == FALSE 
         printf('\n Ingrese n: ');
         N = input(' ');
                  
             if N > 0
                 OK = TRUE;
             end
         end
         if OK ==TRUE
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Ingrese X(%d): ',I);
                 VAR1 = input(' ');                 
                 OK = FALSE;
                 while OK == FALSE
                         X(I+1)=VAR1;
                         OK = TRUE;                         
                   end
                 
                 printf('Ingrese F(X(%d)): ',I);
                 VAR1 = input(' ');                 
                 OK = FALSE;
                 while OK == FALSE
                   
                    
                         Q(I+1,1)=VAR1;
                         OK = TRUE;                         
                     
                 end
             end
             QR=Q($:-1:1,:); 
                         
         else             
            printf('Tiene que ser entero positivo.\n');
         end
     end
 
 if FLAG== 2     
         printf('\nIngrese el nombre del archivo en la forma - ');
         printf('drive:\\name.ext\n');
         printf('por ejemplo:   A:\\DATA.DTA\n');
         NAME = input(' ','s');
            [fd,err]=mopen(NAME,'rb');
            
         if err == -1
             printf('\n\nNo se pudo abrir el archivo %s\n',NAME);
             printf('Puede ser que el archivo no exista o este dañado\n');
             printf('Corra otra vez el script\n');
             OK = FALSE;
         else
             OK = FALSE;         
             while OK == FALSE 
                 printf('Ingrese n: ');
                 N = input(' ');
                
                     if N > 0
                         OK = TRUE;
                     end
                 
                 if OK ==TRUE            
                     X = zeros(N+1);
                     Q = zeros(N+1,N+1);
                     for I = 0:N
                         X(I+1) = mfscanf(fd, '%f');
                         Q(I+1,1) = mfscanf(fd, '%f');
                     end
                     QR=Q($:-1:1,:);
                     mclose(fd);
                     OK = TRUE;
                 else    
                     printf('Tiene que ser entero positivo.\n');
                 end
             end     
         end
 end
 if FLAG== 3
     deff('y=F(x)',input('Ingrese la funcion F(x) en terminos de x, Por ejemplo: y=cos(x)',"s"));

     OK = FALSE;
     while OK == FALSE 
         printf('Ingrese n: ');
         N = input(' ');
         
             if N > 0
                 OK = TRUE;
             end
         
         if OK ==TRUE
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('\nIngrese X(%d): ', I);
                 VAR1 = input(' ');
                 OK = FALSE;
                 while OK == FALSE
                     
                     
                         X(I+1)=VAR1;
                         OK = TRUE;                         
                     
                 end
                 Q(I+1,1) = F(X(I+1));
             end
              QR=Q($:-1:1,:);
             OK = TRUE;
         else
            printf('Tiene que ser entero positivo.\n');
         end
     end
 end

 if FLAG==4  then
     abort;
 end

 if OK == TRUE
     printf('\n\nDESEA INTERPOLAR UN NODO?\n'); 
     printf('Digite Y o N: ');
     A = input(' ','s'); 
     if A=='Y' | A=='y'
         OK = FALSE;
         printf('\nNodo a interpolar: ');
         NODE = input(' ');
         while OK == FALSE
            if( NODE > -1000 | NODE<1000 ) 
                 if X(N+1)>X(1)
                     if (NODE<X(1) | NODE>X(N+1))
                             printf('\nEl nodo debe estar dentro del intervalo [ %f , %f ]\n',(X(1)),(X(N+1)));
                             printf('Nodo a interpolar: ');
                             NODE = input(' ','s');
                     else
                            OK=TRUE;
                     end
                 else
                     if (NODE>X(1) | NODE<X(N+1))
                         printf('\nEl nodo debe estar dentro del intervalo [ %f , %f ]\n',(X(N+1)),(X(1)));
                         printf('Nodo a interpolar: ');
                         NODE = input(' ','s');             
                     else
                            OK=TRUE;
                     end
                 end
             else
                 printf('\nTiene que ser un numero\n');
                 printf('Nodo a interpolar: ');
                 NODE = input(' ');
             
         end                  
    end
  else    
    printf('no hay problema \n');
   NODE='null';
 end
 if OK == TRUE 
     printf('\nSeleccione el tipo de salida\n');
     printf('  1. Pantalla\n');
     printf('  2. Archivo de texto\n');
     printf('Ingrese 1 o 2: ');
     FLAG = input(' ');
     if FLAG==2
         printf('Ingrese el nombre del archivo de la forma - drive:\\name.ext\n');
         printf('Por ejemplo:   A:\\SALIDA.DTA\n');
         NAME = input(' ','s');
         [fd,err]= mopen('NAME','wt');
     else
        OUP = 1;
     end
     
     //fprintf(err,'\n\nINTERPOLACION POLINOMIAL DE NEWTON\n\n');--------------------
     printf("\n\nINTERPOLACION POLINOMIAL DE NEWTON\n\n");
    //STEP 1
     for I = 1:N
         for J = 1:I
             Q(I+1,J+1) = (Q(I+1,J) - Q(I,J)) / (X(I+1) - X(I-J+1));
         end
     end
    // STEP 2
     printf("Los datos de entrada son:\n");     
     //esta parte es la que he agregado--------------------------------
     for I = 0:N        
       printf("X(%d) = %12.8f F(X(%d)) = %12.8f\n",I,X(I+1),I,Q(I+1,1));
    end
   
    //'********* MATRIZ *********;
    for I = 1:N+1
        for J = 1:I
           printf("%12.8f",Q(I,J));       
        end
       //------------------------------------------------------
        printf("\n");
    end
    OK=FALSE;
    while OK == FALSE
        printf('\nQue metodo desea ocupar?\n');
        printf(' 1 -> DIFERENCIAS DIVIDIDAS PROGRESIVAS\n');
        printf(' 2 -> DIFERENCIAS DIVIDIDAS REGRESIVAS\n');
        printf(' 3 -> DIFERENCIAS DIVIDIDAS CENTRADAS\n');
        printf(' 4 -> Todos los anteriores\n');
        printf(' Metodo a ocupar: ');
        op = input(' ');
        if op>0 & op<5
        OK = TRUE;
        
        end
    end
    if op == 1 | op == 4
        //fprintf(fd,'\n\n------>DIFERENCIAS DIVIDIDAS PROGRESIVAS\n');--------------------
        printf('\n\n------>DIFERENCIAS DIVIDIDAS PROGRESIVAS\n');
        //progresiva(Q,X,N,NODE,OUP);
       
        i=0;
        h=X(2)-X(1);
        for I = 2:N+1        
                if (X(I)-X(I-1))==h               
                    i=1;            
                end            
        end
        if i==1
            s='(x-';
            s=strcat([s,string(X(1))]);
            s=strcat([s,')/']);
            s=strcat([s,string(h)]);   
            POL=string(Q(1,1));
            for I = 2:N+1
                for J = 1:I                        
                    if(I==J)                                                   
                            if(sign(Q(I,J))==1 | sign(Q(I,J))==0)
                                POL=strcat([POL,'+']);
                            end                            
                                if I==2                                
                                    POL=strcat([POL,string(Q(I,J))]);
                                    POL=strcat([POL,'*s*']);
                                    POL=strcat([POL,'h']);
                                else
                                    POL=strcat([POL,string(Q(I,J))]);                                
                                    POL=strcat([POL,'*s*']);
                                    for i = 1:I-2
                                        POL=strcat([POL,'(s-']);
                                        POL=strcat([POL,string(i)]);
                                        POL=strcat([POL,')*']);                                                                        
                                    end   
                                    POL=strcat([POL,'h^']);
                                    POL=strcat([POL,string(I-1)]);
                                end

                    end               
                end
            end        
            printf('\nPARA PUNTOS EQUIDISTANTES\n');        
            printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
            printf('  P(%d)(x) = %s \n',N,POL);
            printf('  h= %s \n',string(h));        
            printf('  s= %s \n',s);        
                x=evstr(NODE);
                s=evstr(s);
                printf('  s= %s \n',string(s));
                printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                   
               printf('  P(%d)(%f) = %12.12f \n',N,evstr(NODE),evstr(POL))
            end        
        else
            printf('\n  NO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
            printf('  PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
        end        
           
        for I = 1:N+1
            for J = 1:I        
                if(I==J) 
                    if(I==1) 
                        POL=string(Q(I,J));                                    
                        AUX='';
                    else                               
                        if(Q(I,J)>=0)
                            POL=strcat([POL,'+']);
                            POL=strcat([POL,string(Q(I,J))]);                           
                        else    
                            POL=strcat([POL,string(Q(I,J))]);                           
                        end                    
                        AUX=strcat([AUX,'*(x-(']);
                        AUX=strcat([AUX,string(X(I-1))]);
                        AUX=strcat([AUX,'))']);                                                                
                        POL=strcat([POL,AUX]);                                                

                    end
                end
            end
        end      
        printf('\nPARA PUNTOS NO EQUIDISTANTES\n');                
        printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
        printf('  P(%d)(x) = %s \n',N,POL);
          if string(NODE)~= 'null'
        printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',evstr(NODE));   
            x=evstr(NODE);    
            POL=strcat(['y=',POL]);
            deff('y=PO(x)',POL); 
            printf('  P(%d)(%f) = %12.12f \n',N,evstr(NODE),PO(x));
        end
   end
    
    if op== 2 | op == 4
        printf('\n------>DIFERENCIAS DIVIDIDAS REGRESIVAS\n');
        X=X($:-1:1,:);
        for I = 1:N
            for J = 1:I
                 QR(I+1,J+1) = (QR(I+1,J) - QR(I,J)) / (X(I+1) - X(I-J+1));
             end
        end            
        //regresiva(QR,X,N,NODE,OUP);
        
        i=0;
        h=X(1)-X(2);       
        for I = 2:N+1        
                if (X(I-1)-X(I))==(h)
                    i=1;                
                end
        end
        if i==1
            s='(x-';
            s=strcat([s,string(X(1))]);
            s=strcat([s,')/']);
            s=strcat([s,string(h)]);   
            POL=string(QR(1,1));
            for I = 2:N+1
                for J = 1:I                        
                    if(I==J)                                                   
                            if(sign(QR(I,J))==1 | sign(QR(I,J))==0)
                                POL=strcat([POL,'+']);
                            end                            
                                if I==2                                
                                    POL=strcat([POL,string(QR(I,J))]);
                                    POL=strcat([POL,'*s*']);
                                    POL=strcat([POL,'h']);
                                else
                                    POL=strcat([POL,string(QR(I,J))]);                                
                                    POL=strcat([POL,'*s*']);
                                    for i = 1:I-2
                                        POL=strcat([POL,'(s+']);
                                        POL=strcat([POL,string(i)]);
                                        POL=strcat([POL,')*']);                                                                        
                                    end   
                                    POL=strcat([POL,'h^']);
                                    POL=strcat([POL,string(I-1)]);
                                end

                    end               
                end
            end     
            printf('\nPARA PUNTOS EQUIDISTANTES\n');        
            printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
            printf('  P(%d)(x) = %s \n',N,POL);
            printf('  h= %s \n',string(h));        
            if string (NODE)~='null'
            printf('  s= %s \n',s);        
                x=evstr(NODE);             
                s=evstr(s);
                printf('  s= %s \n',string(s));            
                printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                           
                printf('  P(%d)(%f) = %12.12f \n',N,evstr(NODE),evstr(POL));
            end
            z=1;
        else
            printf('\nNO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
            printf('PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
        end    
          
        for I = 1:N+1
            for J = 1:I        
                if(I==J) 
                    if(I==1) 
                        POL=string([QR(I,J)]);                                    
                        AUX='';
                    else                               
                        if(QR(I,J)>=0)
                            POL=strcat([POL,'+']);
                            POL=strcat([POL,string(QR(I,J))]);                           
                        else    
                            POL=strcat([POL,string(QR(I,J))]);                           
                        end  
                        //aqui se concatenan los factores con AUX                    
                        AUX=strcat([AUX,'*(x-(']);
                        AUX=strcat([AUX,string(X(I-1))]);
                        AUX=strcat([AUX,'))']);                                                                
                        POL=strcat([POL,AUX]);                                                
                        
                    end
                end
            end
        end      
        printf('\nPARA PUNTOS NO EQUIDISTANTES\n');                
        printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
        printf('  P(%d)(x) = %s \n',N,POL);
        if string(NODE)~='null'
        printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',evstr(NODE));   
            x=evstr(NODE);    
            POL=strcat(['y=',POL]);
            deff('y=PO(x)',POL); 
            printf('  P(%d)(%f) = %12.12f \n',N,evstr(NODE),PO(x));
        end
        X=X($:-1:1,:);
    end

    
    if op== 3 | op == 4
        printf('\n------> DIFERENCIAS DIVIDIDAS CENTRADAS\n');
        if string(NODE)~='null' & N > 1
            N2=N-1;
        
        //Aqui va lo cortado
            if modulo(N+1,2)==0 //si hay un numero par de nodos
                if abs(evstr(NODE)-X(1)) > abs(evstr(NODE)-X(N+1))
                    flagx=1;
                else
                    flagx=N+1;
                end
                Xr=zeros(N);
                QC = zeros(N,N);
                I2=1;
                for I=1:N+1
                    if I ~= flagx
                        Xr(I2)=X(I);
                        QC(I2,1)=Q(I,1);
                        I2=I2+1;
                    end
                end                
                printf('\nse eliminara el nodo X(%d) = %6.2f\n',flagx,X(flagx));
                printf('ya que es el nodo mas lejano al nodo de interpolacion %6.2f\n',evstr(NODE));
                printf('su nuevo grupo de nodos son:\n');                
                N2=N-1;
                for I = 1:N2
                    for J = 1:I
                         QC(I+1,J+1) = (QC(I+1,J) - QC(I,J)) / (Xr(I+1) - Xr(I-J+1));
                     end
                end
            else
                QC=Q;
                Xr=X;
                N2=N;
            end
        
            for I = 0:N2
                printf('X(%d) = %12.8f     F(X(%d)) = %12.8f\n',I-N2/2,Xr(I+1),I-N2/2,QC(I+1,1));
            end            
            printf('********* MATRIZ ********\n');
            for I = 1:N2+1
                for J = 1:I
                    printf( '%12.8f ', QC(I,J));       
                end
                printf( '\n');
            end         
            
            i=0;
            h=Xr(2)-Xr(1);   
            AUX='';
            AUX2='';
            for I = 2:N2+1        
                    if (Xr(I)-Xr(I-1))==(h)        
                        i=1;                
                    end
            end
            if i== 1
                if N2 >= 1     //requisito minimo para generar el polinomio 
                    i=N2/2+1;
                    s='(x-';
                    s=strcat([s,string(Xr(i))]);
                    s=strcat([s,')/']);
                    s=strcat([s,string(h)]);          
                    k=1;
                    j=2;
                    JV=1;        
                    IV=i;
                    for I=i:N2+1
                        for J=1:N2+1
                            if IV==i  
                                POL=string(QC(IV,JV));
                                POL=strcat([POL,'+(s*h/2)*(']);
                                POL=strcat([POL,string(QC(IV,JV+1))]);
                                POL=strcat([POL,'+']);
                                POL=strcat([POL,string(QC(IV+1,JV+1))]);
                                POL=strcat([POL,')']);                    
                                JV=JV+2;                
                                IV=IV+1; 
                            else                
                                if JV<=N2+1    
                                    POL=strcat([POL,'+s^2*']);
                                    if j ~=2
                                        AUX2=strcat([AUX2,'(s^2-']);
                                        AUX2=strcat([AUX2,string(k^2)]);
                                        k=k+1;
                                        AUX2=strcat([AUX2,')*']);
                                        POL=strcat([POL,AUX2]);
                                    end
                                    POL=strcat([POL,'h^']);
                                    POL=strcat([POL,string(j)]);
                                    j=j+1;
                                    POL=strcat([POL,'*(']);
                                    POL=strcat([POL,string(QC(IV,JV))]);
                                    POL=strcat([POL,')']);                       
                                    if IV < N2+1
                                        POL=strcat([POL,'+(s*']);
                                        AUX=strcat([AUX,'(s^2-']);
                                        AUX=strcat([AUX,string(k^2)]);
                                        AUX=strcat([AUX,')*']);
                                        POL=strcat([POL,AUX]);
                                        POL=strcat([POL,'h^']);
                                        POL=strcat([POL,string(j)]);                        
                                        j=j+1;
                                        POL=strcat([POL,')/2*(']);
                                        POL=strcat([POL,string(QC(IV,JV+1))]);
                                        POL=strcat([POL,'+']);
                                        POL=strcat([POL,string(QC(IV+1,JV+1))]);
                                        POL=strcat([POL,')']);                            
                                    end  
                                    IV=IV+1;
                                    JV=JV+2;
                                end                
                            end            
                        end        
                    end                    
                    printf('\nPARA PUNTOS EQUIDISTANTES\n');        
                    printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
                    printf('  P(%d)(x) = %s \n',N2,POL);
                    printf('  h= %s \n',string(h));        
                    printf('  s= %s \n',s);        
                    x=evstr(NODE);
                    s=evstr(s);
                    printf('  s= %s \n',string(s));
                    printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                   
                    printf('  P(%d)(%f) = %12.12f \n',N2,evstr(NODE),evstr(POL));                   
                else
                end
            else
                printf('\nNO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
                printf('PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
            end
            i=N2/2+1;
            AUX1='+(x-';
            AUX1=strcat([AUX1,string(Xr(i))]);
            AUX1=strcat([AUX1,')/2*']);
            AUX2='+(x-';
            AUX2=strcat([AUX2,string(Xr(i))]);
            AUX2=strcat([AUX2,')^2*']);
            AUX='';
            JV=1;        
            IV=i;
            j=1;
            for I=i:N2+1
                for J=1:N2+1
                    if IV==i      
                        POL=string(QC(IV,JV));
                        POL=strcat([POL,AUX1]);
                        POL=strcat([POL,'(']);
                        POL=strcat([POL,string(QC(IV,JV+1))]);
                        POL=strcat([POL,'+']);
                        POL=strcat([POL,string(QC(IV+1,JV+1))]);
                        POL=strcat([POL,')']);           
                        JV=JV+2;                
                        IV=IV+1; 
                    else                
                        if JV<=N2+1
                            POL=strcat([POL,AUX2]);                                
                            POL=strcat([POL,string(QC(IV,JV))]);                                
                            if IV < N2+1
                                POL=strcat([POL,AUX1]);
                                AUX4='(x-';
                                AUX4=strcat([AUX4,string(Xr(i-j))]);
                                AUX4=strcat([AUX4,')']);
                                AUX=strcat([AUX4,AUX]);
                                AUX4=strcat(['*(x-',string(Xr(i+j))]);
                                AUX4=strcat([AUX4,')*']);
                                AUX=strcat([AUX,AUX4]);                   
                                j=j+1;
                                POL=strcat([POL,AUX]);
                                POL=strcat([POL,'(']);
                                POL=strcat([POL,string(QC(IV,JV+1))]);
                                POL=strcat([POL,'+']);
                                POL=strcat([POL,string(QC(IV+1,JV+1))]);
                                POL=strcat([POL,')']);                    
                            end  
                            IV=IV+1;
                            JV=JV+2;
                        end                
                    end            
                end        
            end
            printf('\nPARA PUNTOS NO EQUIDISTANTES\n');                
            printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
            printf('  P(%d)(x) = %s \n',N2,POL);
            printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',evstr(NODE));   
            x=evstr(NODE);  
            
            POL=strcat(['y=',POL]);
            deff('y=PO(x)',POL); 
            printf('  P(%d)(%f) = %12.12f \n',N2,evstr(NODE),PO(x));  
        else
            printf('\n\nPara el calculo del polinomio con el metodo de diferencias divididas centradas\n');
            printf('el grado del polinomio tiene que ser mayor que 1 y\n');
            printf('se necesita conocer el nodo de interpolacion\n');
        end
    end
   
