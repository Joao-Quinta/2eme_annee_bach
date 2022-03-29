% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=InterpolationLagrange(x,data)
    %on separe data en deux listes, une qui cotient les xi et une autre les yi
    X=data(1,:);
    Y=data(2,:);
    i=1; P=zeros(1,length(x));
    while i<=length(x) %evalue Pn pour les differntes valeurs de x
        L=PolLagrange(x(i),X);%calcule les polynomes de lagrange et les stock dans un vecteur
        P(1,i)=sum(prod([Y;L])'); % effectue le produit li*yi et somme le tout| les differentes evaluationsde Pn sont stockées dasn un vecteur
        i=i+1;
    end
    y=P;
end




function y=PolLagrange(xev,X)%calcule les polynomes de lagrange et les stock dans un vecteur
    i=1;j=1; l=1; n=length(X); L=zeros(1,n);
    while i<= n
        while j<= n
            if j~=i % j pas egal a i
                l=l*(xev-X(j))/(X(i)-X(j)); %calcule li
            end
            j=j+1;
        end
        L(1,i)=l; %stocke les li succecifs dans une matrice
        j=1;
        l=1;
        i=i+1;

    end
    y=L;
end


