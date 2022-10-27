// UNIVERSIDAD DE EL SALVADOR 
// Materia: Analisis Numerico 
// Tema : Interpolacion Numerica
//% Diferencias Divididas de Newton
//% Genera y evalua el polinomio de interpolacion a traves del metodo de 
//% diferencias divididas progresivas, regresivas y centradas
//% A diferencia de la version anterior, mojica_dif_div2 cuenta con las
//% mas optimas validaciones necesarias para el buen funcionamiento del
//% mismo.
// syms('OK', 'FLAG', 'N', 'I', 'X', 'Q', 'A', 'NAME', 'INP','OUP', 'J');
// syms('s','x','QR','dir','QC','Xr', 'VAR1');
 TRUE = 1;
 FALSE = 0; 
 printf('Polinomio de interpolacion de NEWTON\n');
 OK = FALSE;
 while OK == FALSE 
     printf('Elija el metodo de entrada:\n');
     printf('  1. Ingresar entrada por medio del teclado\n');
     printf('  2. Ingresar datos desde un archivo de texto\n');
     printf('  3. Generar datos unsando una funcion F\n\n');
     printf('metodo de entrada: ');
     FLAG = input(' ','s');
     if isempty(regexp(FLAG,'[^123]','ONCE')) == 1 & strcmp(FLAG,'')~=1
         if eval(FLAG) > 0 & eval(FLAG) < 4
             OK = TRUE;
         end
     end
 end
 if strcmp(FLAG,'1') == 1
     OK = FALSE;
     while OK == FALSE 
         printf('\nIngrese n: ');
         N = input(' ','s');
         if isempty(regexp(N,'\D','ONCE')) == 1 & strcmp(N,'')~=1
             if eval(N) > 0
                 OK = TRUE;
             end
         end
         if OK ==TRUE
             N=eval(N);
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('Ingrese X(%d): ',I);
                 VAR1 = input(' ','s');                 
                 OK = FALSE;
                 while OK == FALSE
                     if isempty(regexp(VAR1,'[^0123456789.-]','ONCE')) == 0 | strcmp(VAR1,'') == 1 | strcmp(VAR1,'-') == 1
                         printf('\nTiene que ser un numero\n');
                         printf('Ingrese X(%d): ', I);
                         VAR1 = input(' ','s');
                     else
                         X(I+1)=eval(VAR1);
                         OK = TRUE;                         
                     end
                 end
                 printf('Ingrese F(X(%d)): ',I);
                 VAR1 = input(' ','s');                 
                 OK = FALSE;
                 while OK == FALSE
                     if isempty(regexp(VAR1,'[^0123456789.-]','ONCE')) == 0 | strcmp(VAR1,'') == 1 | strcmp(VAR1,'-') == 1
                         printf('\nTiene que ser un numero\n');
                         printf('Ingrese F(X(%d)): ', I);
                         VAR1 = input(' ','s');
                     else
                         Q(I+1,1)=eval(VAR1);
                         OK = TRUE;                         
                     end
                 end
             end
             QR=flipud(Q);             
         else             
            printf('Tiene que ser entero positivo.\n');
         end
     end
 end
 if strcmp(FLAG,'2') == 1     
         printf('\nIngrese el nombre del archivo en la forma - ');
         printf('drive:\\name.ext\n');
         printf('por ejemplo:   E:\\DATA.TXT\n');
         NAME = input(' ','s');
         INP = mopen(NAME,'rb');
         if INP == -1
             printf('\n\nNo se pudo abrir el archivo %s\n',NAME);
             printf('Puede ser que el archivo no exista o este dañado\n');
             printf('Corra otra vez el script\n');
             OK = FALSE;
         else
             OK = FALSE;         
             while OK == FALSE 
                 printf('Ingrese n: ');
                 N = input(' ','s');
                 if isempty(regexp(N,'\D','ONCE')) == 1 & strcmp(N,'')~=1
                     if eval(N) > 0
                         OK = TRUE;
                     end
                 end
                 if OK ==TRUE
                     N=eval(N);              
                     X = zeros(N+1);
                     Q = zeros(N+1,N+1);
                     for I = 0:N
                         X(I+1) = fscanf(INP, '%f',1);
                         Q(I+1,1) = fscanf(INP, '%f',1);
                     end
                     QR=flipud(Q);
                     fclose(INP);
                     OK = TRUE;
                 else    
                     printf('Tiene que ser entero positivo.\n');
                 end
             end     
         end
 end
 if strcmp(FLAG,'3') == 1
     printf('Ingrese la funcion F(x) en terminos de x\n');
     printf('Por ejemplo: y=3*x^3-2*x^2+1\n');
     s = input(' ');
     deff('y=F(x)',s);
     OK = FALSE;
     while OK == FALSE 
         printf('Ingrese n: ');
         N = input(' ','s');
         if isempty(regexp(N,'\D','ONCE')) == 1 & strcmp(N,'')~=1
             if eval(N) > 0
                 OK = TRUE;
             end
         end
         if OK ==TRUE
             N=eval(N);
             X = zeros(N+1);
             Q = zeros(N+1,N+1);
             for I = 0:N
                 printf('\nIngrese X(%d): ', I);
                 VAR1 = input(' ','s');
                 OK = FALSE;
                 while OK == FALSE
                     if isempty(regexp(VAR1,'[^0123456789.-]','ONCE')) == 0 | strcmp(VAR1,'') == 1 | strcmp(VAR1,'-') == 1
                         printf('\nTiene que ser un numero\n');
                         printf('Ingrese X(%d): ', I);
                         VAR1 = input(' ','s');
                     else
                         X(I+1)=eval(VAR1);
                         OK = TRUE;                         
                     end
                 end
                 Q(I+1,1) = F(X(I+1));
             end
             QR=flipud(Q);
             OK = TRUE;
         else
            printf('Tiene que ser entero positivo.\n');
         end
     end
 end
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if OK == TRUE
     printf('\n\nDESEA INTERPOLAR UN NODO?\n'); 
     printf('Digite Y o N: ');
     A = input(' ','s'); 
     if strcmp(A,'Y') == 1 | strcmp(A,'y') == 1
         OK = FALSE;
         printf('\nNodo a interpolar: ');
         NODE = input(' ','s');
         while OK == FALSE
             if isempty(regexp(NODE,'[^0123456789.-]','ONCE')) == 1 & strcmp(NODE,'')~=1 & strcmp(NODE,'-')~=1
                 if X(N+1)>X(1)
                     if (eval(NODE)<X(1) | eval(NODE)>X(N+1))
                             printf('\nEl nodo debe estar dentro del intervalo [ %s , %s ]\n',num2str(X(1)),num2str(X(N+1)));
                             printf('Nodo a interpolar: ');
                             NODE = input(' ','s');
                     else
                            OK=TRUE;
                     end
                 else
                     if (eval(NODE)>X(1) | eval(NODE)<X(N+1))
                         printf('\nEl nodo debe estar dentro del intervalo [ %s , %s ]\n',num2str(X(N+1)),num2str(X(1)));
                         printf('Nodo a interpolar: ');
                         NODE = input(' ','s');             
                     else
                            OK=TRUE;
                     end
                 end
             else
                 printf('\nTiene que ser un numero\n');
                 printf('Nodo a interpolar: ');
                 NODE = input(' ','s');
             end
         end                  
     else    
         printf('NO PROBLEM!!\n');
         NODE='null';
     end
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 end
 if OK == TRUE 
     printf('\n\nSeleccione el tipo de salida\n');
     printf('  1. Pantalla\n');
     printf('  2. Archivo de texto\n');
     printf('Ingrese 1 o 2: ');
     FLAG = input(' ','s');
     if strcmp(FLAG,'2')==1
         printf('Ingrese el nombre del archivo de la forma - drive:\\name.ext\n');
         printf('Por ejemplo:   A:\\SALIDA.DTA\n');
         NAME = input(' ','s');
         OUP = fopen(NAME,'wt');
     else
        OUP = 1;
     end
     printf( '\n\nINTERPOLACION POLINOMIAL DE NEWTON\n\n');
    % STEP 1
     for I = 1:N
         for J = 1:I
             Q(I+1,J+1) = (Q(I+1,J) - Q(I,J)) / (X(I+1) - X(I-J+1));
         end
     end
    % STEP 2
     printf( 'Los datos de entrada son:\n');      
//     %esta parte es la que he agregado--------------------------------
     for I = 0:N        
        printf('X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));
    end
    %imprimiendo todas las diferencias divididas calculadas
    %printf( '********* MATRIZ ********\n');
    for I = 1:N+1
        for J = 1:I
            printf( '%12.8f ', Q(I,J));       
        end
        printf( '\n');
    end
    OK=FALSE;
    while OK == FALSE
        printf('\nQue metodo desea ocupar?\n');
        printf(' 1 -> DIFERENCIAS DIVIDIDAS PROGRESIVAS\n');
        printf(' 2 -> DIFERENCIAS DIVIDIDAS REGRESIVAS\n');
        printf(' 3 -> DIFERENCIAS DIVIDIDAS CENTRADAS\n');
        printf(' 4 -> Todos los anteriores\n');
        printf(' Metodo a ocupar: ');
        dir = input(' ','s');
        if strcmp(dir,'1') == 1 | strcmp(dir,'2') == 1 | strcmp(dir,'3') == 1 | strcmp(dir,'4') == 1 
        OK = TRUE;
        dir=eval(dir);
        end
    end
    if dir == 1 | dir == 4
        printf('\n\n------>DIFERENCIAS DIVIDIDAS PROGRESIVAS\n');
        %progresiva(Q,X,N,NODE,OUP);
        syms('x','POL');
        i=0;
        h=X(2)-X(1);
        for I = 2:N+1        
                if strcmp(num2str(X(I)-X(I-1)),num2str(h))~=1                
                    i=1;            
                end            
        end
        if i~=1
            s='(x-';
            s=strcat(s,num2str(X(1)));
            s=strcat(s,')/');
            s=strcat(s,num2str(h));   
            POL=num2str(Q(1,1));
            for I = 2:N+1
                for J = 1:I                        
                    if(I==J)                                                   
                            if(sign(Q(I,J))==1 | sign(Q(I,J))==0)
                                POL=strcat(POL,'+');
                            end                            
                                if I==2                                
                                    POL=strcat(POL,num2str(Q(I,J)));
                                    POL=strcat(POL,'*s*');
                                    POL=strcat(POL,'h');
                                else
                                    POL=strcat(POL,num2str(Q(I,J)));                                
                                    POL=strcat(POL,'*s*');
                                    for i = 1:I-2
                                        POL=strcat(POL,'(s-');
                                        POL=strcat(POL,num2str(i));
                                        POL=strcat(POL,')*');                                                                        
                                    end   
                                    POL=strcat(POL,'h^');
                                    POL=strcat(POL,num2str(I-1));
                                end

                    end               
                end
            end        
            printf('\nPARA PUNTOS EQUIDISTANTES\n');        
            printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
            printf('  P(%d)(x) = %s \n',N,POL);
            printf('  h= %s \n',num2str(h));        
            printf('  s= %s \n',s);        
            if strcmp(NODE,'null')==0
                x=eval(NODE);
                s=eval(s);
                printf('  s= %s \n',num2str(s));
                printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                   
                printf(  'P(%d)(%f) = %12.12f \n',N,eval(NODE),eval(POL));
            end        
        else
            printf('\n  NO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
            printf('  PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
        end        
        syms('AUX');    
        for I = 1:N+1
            for J = 1:I        
                if(I==J) 
                    if(I==1) 
                        POL=num2str(Q(I,J));                                    
                        AUX='';
                    else                               
                        if(Q(I,J)>=0)
                            POL=strcat(POL,'+');
                            POL=strcat(POL,num2str(Q(I,J)));                           
                        else    
                            POL=strcat(POL,num2str(Q(I,J)));                           
                        end                    
                        AUX=strcat(AUX,'*(x-(');
                        AUX=strcat(AUX,num2str(X(I-1)));
                        AUX=strcat(AUX,'))');                                                                
                        POL=strcat(POL,AUX);                                                

                    end
                end
            end
        end      
        printf('\nPARA PUNTOS NO EQUIDISTANTES\n');                
        printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
        printf('  P(%d)(x) = %s \n',N,POL);
        if strcmp(NODE,'null')==0
           printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',eval(NODE));   
            x=eval(NODE);    
            POL=inline(POL);
            printf('  P(%d)(%f) = %12.12f \n',N,eval(NODE),POL(x));
        end
    end
    if dir == 2 | dir == 4
        printf('\n------>DIFERENCIAS DIVIDIDAS REGRESIVAS\n');
        X=flipud(X);
        for I = 1:N
            for J = 1:I
                 QR(I+1,J+1) = (QR(I+1,J) - QR(I,J)) / (X(I+1) - X(I-J+1));
             end
        end            
        %regresiva(QR,X,N,NODE,OUP);
        
        syms('x','POL');
        i=0;
        h=X(1)-X(2);       
        for I = 2:N+1        
                if strcmp(num2str(X(I-1)-X(I)),num2str(h))~=1
                    i=1;                
                end
        end
        if i~=1
            s='(x-';
            s=strcat(s,num2str(X(1)));
            s=strcat(s,')/');
            s=strcat(s,num2str(h));   
            POL=num2str(QR(1,1));
            for I = 2:N+1
                for J = 1:I                        
                    if(I==J)                                                   
                            if(sign(QR(I,J))==1 | sign(QR(I,J))==0)
                                POL=strcat(POL,'+');
                            end                            
                                if I==2                                
                                    POL=strcat(POL,num2str(QR(I,J)));
                                    POL=strcat(POL,'*s*');
                                    POL=strcat(POL,'h');
                                else
                                    POL=strcat(POL,num2str(QR(I,J)));                                
                                    POL=strcat(POL,'*s*');
                                    for i = 1:I-2
                                        POL=strcat(POL,'(s+');
                                        POL=strcat(POL,num2str(i));
                                        POL=strcat(POL,')*');                                                                        
                                    end   
                                    POL=strcat(POL,'h^');
                                    POL=strcat(POL,num2str(I-1));
                                end

                    end               
                end
            end     
            printf('\nPARA PUNTOS EQUIDISTANTES\n');        
            printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
            printf('  P(%d)(x) = %s \n',N,POL);
            printf('  h= %s \n',num2str(h));        
            printf('  s= %s \n',s);        
            if strcmp(NODE,'null')==0
                x=eval(NODE);             
                s=eval(s);
                printf('  s= %s \n',num2str(s));            
                printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                           
                printf('  P(%d)(%f) = %12.12f \n',N,eval(NODE),eval(POL));
            end
            z=1;
        else
            printf('\nNO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
            printf('PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
        end    
        syms('AUX');    
        for I = 1:N+1
            for J = 1:I        
                if(I==J) 
                    if(I==1) 
                        POL=num2str(QR(I,J));                                    
                        AUX='';
                    else                               
                        if(QR(I,J)>=0)
                            POL=strcat(POL,'+');
                            POL=strcat(POL,num2str(QR(I,J)));                           
                        else    
                            POL=strcat(POL,num2str(QR(I,J)));                           
                        end  
                        %aqui se concatenan los factores con AUX                    
                        AUX=strcat(AUX,'*(x-(');
                        AUX=strcat(AUX,num2str(X(I-1)));
                        AUX=strcat(AUX,'))');                                                                
                        POL=strcat(POL,AUX);                                                
                        
                    end
                end
            end
        end      
        printf('\nPARA PUNTOS NO EQUIDISTANTES\n');                
        printf('EL POLINOMIO QUEDA DE LAS SIGUIENTE FORMA\n');   
        printf('  P(%d)(x) = %s \n',N,POL);
        if strcmp(NODE,'null')==0
           printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',eval(NODE));   
            x=eval(NODE);    
            POL=inline(POL);
            printf('  P(%d)(%f) = %12.12f \n',N,eval(NODE),POL(x));
        end
        X=flipud(X);
    end
    
    if dir == 3 | dir == 4
        printf('\n------> DIFERENCIAS DIVIDIDAS CENTRADAS\n');
        if strcmp(NODE,'null')==0 & N > 1
            syms('flagx','max','I2','N2');
            if mod(N+1,2)==0 %si hay un numero par de nodos
                if abs(eval(NODE)-X(1)) > abs(eval(NODE)-X(N+1))
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
                printf('ya que es el nodo mas lejano al nodo de interpolacion %6.2f\n',eval(NODE));
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
            printf( '********* MATRIZ ********\n');
            for I = 1:N2+1
                for J = 1:I
                    printf( '%12.8f ', QC(I,J));       
                end
                printf( '\n');
            end         
            syms('POL','AUX','AUX1','AUX2','AUX4','j','k','JV','IV','x');
            i=0;
            h=Xr(2)-Xr(1);   
            AUX='';
            AUX2='';
            for I = 2:N2+1        
                    if strcmp(num2str(Xr(I)-Xr(I-1)),num2str(h))~=1        
                        i=1;                
                    end
            end
            if i~= 1
                if N2 >= 2     %requisito minimo para generar el polinomio 
                    i=N2/2+1;
                    s='(x-';
                    s=strcat(s,num2str(Xr(i)));
                    s=strcat(s,')/');
                    s=strcat(s,num2str(h));          
                    k=1;
                    j=2;
                    JV=1;        
                    IV=i;
                    for I=i:N2+1
                        for J=1:N2+1
                            if IV==i  
                                POL=num2str(QC(IV,JV));
                                POL=strcat(POL,'+(s*h/2)*(');
                                POL=strcat(POL,num2str(QC(IV,JV+1)));
                                POL=strcat(POL,'+');
                                POL=strcat(POL,num2str(QC(IV+1,JV+1)));
                                POL=strcat(POL,')');                    
                                JV=JV+2;                
                                IV=IV+1; 
                            else                
                                if JV<=N2+1    
                                    POL=strcat(POL,'+s^2*');
                                    if j ~=2
                                        AUX2=strcat(AUX2,'(s^2-');
                                        AUX2=strcat(AUX2,num2str(k^2));
                                        k=k+1;
                                        AUX2=strcat(AUX2,')*');
                                        POL=strcat(POL,AUX2);
                                    end
                                    POL=strcat(POL,'h^');
                                    POL=strcat(POL,num2str(j));
                                    j=j+1;
                                    POL=strcat(POL,'*(');
                                    POL=strcat(POL,num2str(QC(IV,JV)));
                                    POL=strcat(POL,')');                       
                                    if IV < N2+1
                                        POL=strcat(POL,'+(s*');
                                        AUX=strcat(AUX,'(s^2-');
                                        AUX=strcat(AUX,num2str(k^2));
                                        AUX=strcat(AUX,')*');
                                        POL=strcat(POL,AUX);
                                        POL=strcat(POL,'h^');
                                        POL=strcat(POL,num2str(j));                        
                                        j=j+1;
                                        POL=strcat(POL,')/2*(');
                                        POL=strcat(POL,num2str(QC(IV,JV+1)));
                                        POL=strcat(POL,'+');
                                        POL=strcat(POL,num2str(QC(IV+1,JV+1)));
                                        POL=strcat(POL,')');                            
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
                    printf('  h= %s \n',num2str(h));        
                    printf('  s= %s \n',s);        
                    x=eval(NODE);
                    s=eval(s);
                    printf('  s= %s \n',num2str(s));
                    printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',x);                   
                    printf('  P(%d)(%f) = %12.12f \n',N2,eval(NODE),eval(POL));                   
                else
                end
            else
                printf('\nNO SE PUEDE CALCULAR EL POLINOMIO PARA PUNTOS EQUIDISTANTES\n');
                printf('PORQUE LOS NODOS NO SON EQUIDISTANTES\n');
            end
            i=N2/2+1;
            AUX1='+(x-';
            AUX1=strcat(AUX1,num2str(Xr(i)));
            AUX1=strcat(AUX1,')/2*');
            AUX2='+(x-';
            AUX2=strcat(AUX2,num2str(Xr(i)));
            AUX2=strcat(AUX2,')^2*');
            AUX='';
            JV=1;        
            IV=i;
            j=1;
            for I=i:N2+1
                for J=1:N2+1
                    if IV==i      
                        POL=num2str(QC(IV,JV));
                        POL=strcat(POL,AUX1);
                        POL=strcat(POL,'(');
                        POL=strcat(POL,num2str(QC(IV,JV+1)));
                        POL=strcat(POL,'+');
                        POL=strcat(POL,num2str(QC(IV+1,JV+1)));
                        POL=strcat(POL,')');           
                        JV=JV+2;                
                        IV=IV+1; 
                    else                
                        if JV<=N2+1
                            POL=strcat(POL,AUX2);                                
                            POL=strcat(POL,num2str(QC(IV,JV)));                                
                            if IV < N2+1
                                POL=strcat(POL,AUX1);
                                AUX4='(x-';
                                AUX4=strcat(AUX4,num2str(Xr(i-j)));
                                AUX4=strcat(AUX4,')');
                                AUX=strcat(AUX4,AUX);
                                AUX4=strcat('*(x-',num2str(Xr(i+j)));
                                AUX4=strcat(AUX4,')*');
                                AUX=strcat(AUX,AUX4);                   
                                j=j+1;
                                POL=strcat(POL,AUX);
                                POL=strcat(POL,'(');
                                POL=strcat(POL,num2str(QC(IV,JV+1)));
                                POL=strcat(POL,'+');
                                POL=strcat(POL,num2str(QC(IV+1,JV+1)));
                                POL=strcat(POL,')');                    
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
            printf('EL VALOR DEL POLINOMIO EN x= %f es:\n',eval(NODE));   
            x=eval(NODE);    
            POL=inline(POL);
            printf('  P(%d)(%f) = %12.12f \n',N2,eval(NODE),POL(x));  
        else
            printf('\n\nPara el calculo del polinomio con el metodo de diferencias divididas centradas\n');
            printf('el grado del polinomio tiene que ser mayor que 1 y\n');
            printf('se necesita conocer el nodo de interpolacion\n');
        end
    end
    if OUP ~= 1
        fclose(OUP);
    end
 end
