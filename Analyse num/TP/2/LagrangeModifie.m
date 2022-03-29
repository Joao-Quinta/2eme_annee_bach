% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=LagrangeModifie(x,data)
    %on separe data en deux listes, une qui cotient les xi et une autre les yi
    X=data(1,:);
    Y=data(2,:);
    i=1; P=zeros(1,length(x));
    while i<=length(x)%evalue Pn pour les differntes valeurs de x
        W=Wi(x(i),X);% calcule les wi pour les differentes valeurs de x
        L=Lx(x(i),X);%calcule l(x) pour les differentes valeurs de x
        P(1,i)=L*sum(prod([Y;W])');% evalue les differents Pn(x) et les stock dans une matrice
        i=i+1;
    end
    y=P;
end


function y=Wi(xev,X) %calcule les wi/(x-xi)
 i=1;j=1; w=1; n=length(X); W=zeros(1,n);
    while i<= n
        while j<= n
            if j~=i % j pas egal a i
                w=w*(X(i)-X(j));
            end
            j=j+1;
        end
        W(1,i)=(w^(-1))/(xev-X(i)); %eleve le produit a la puisance -1 , le divise par x-xi et l'ajoute a la matrice
        j=1;
        w=1;
        i=i+1;

    end
    y=W;
end

function y=Lx(xev,X)%calcule l(x)
    i=1; l=1; n=length(X);
    while i<=n
        l=l*(xev-X(i));
        i=i+1;
    end
    y=l; 
end


