% Joao Costa, Edin Sulejmani, Lea Heiniger

function P=Hermite(xev,data)
    X=extand(data(1,:));% liste etendue de la premiere ligne de data
    b=DifferencesDiviseeModif(data);
    
    P=b(1,1);
    i=2;n=length(b);
    while i<=n
        j=1;
        x=1;
        while j<i %parcourt X pour calculer (x-x0)^2*...*(x-xi)
            x=x.*(xev-X(1,j));
            j=j+1;
        end     
        P=P+b(1,i)*x; % multiplie x par le coefficient bi correspondant
        i=i+1;
    end  
end

function Y=extand(X) % permet d'etendre la liste X=[x0,x1,...,xn] en [x0,x0,x1,x1,...,xn]
    n=length(X); Y=zeros(1,2*n-1); i=1; j=1;
    while j<2*n
        Y(1,j)= X(1,i);
        Y(1,j+1)= X(1,i);
        i=i+1;% indice dans la liste de base
        j=j+2;% indice dans la nouvelle liste
    end
end




function b=DifferencesDiviseeModif(data)
    %on separe data en trois listes qu'on etend, une qui contient les xi,
    %une les yi et une troisieme les zi
    X=extand(data(1,:));
    Y=extand(data(2,:));
    Z=extand(data(3,:));
    
    b=[];% liste qui contiendra les coefficients bi
    bp=[];
    bpp=Y;
    
    b(1,1)=Y(1,1);%premiere valeur de b, ou b0=y0
    
    p=1;%longueur de b
    while p < length(X)
       k=1;
       while k < length(bpp)
          % pour calculer les d^2y[xi,xj] on doit verifier si i=j et si
          % c'est le cas on retourne zi. sinon on procede normalement.
          if p==1 
              if X(k)==X(k+1) % i=j
                  bp(1,k)=Z(1,k);
              else
                  bp (1,k)= (bpp(k+1)-bpp(k))/(X(k+p)-X(k));  
              end
          
          %pour les autre bi on procede normalement
          else
            bp(1,k)= (bpp(k+1)-bpp(k))/(X(k+p)-X(k));
         
          end
          k=k+1;

       end
       b(1,p+1)=bp(1,1);
       bpp=bp; 
       bp=[];
       p=p+1;
    end
end   
