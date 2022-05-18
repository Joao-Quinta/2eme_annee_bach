% Joao Costa, Edin Sulejmani, Lea Heiniger

syms x 
n= 14;
%listeEqui =linspace(-1,1,n+1);
FX = sin(x);
GX = 1/(1+x^2);
DX = exp(x);
y = linspace(-1,1,15);
%On reverse la liste de Cheby pour avoir les n?gatifs aux d?buts de la
%liste

plot_b1_Equi_DX(1,:)=calculDeb1b2(DX,x,n,1);%exp x Equi
plot_b2_Cheby_DX(1,:) = calculDeb1b2(DX,x,n,0);%exp x Cheby
plot_b1_Equi_FX(1,:)=calculDeb1b2(FX,x,n,1);%f x Equi
plot_b2_Cheby_FX(1,:) = calculDeb1b2(FX,x,n,0);%f x Cheby
plot_b1_Equi_GX(1,:)=calculDeb1b2(GX,x,n,1);%g x Equi
plot_b2_Cheby_GX(1,:) = calculDeb1b2(GX,x,n,0);

val=14;
vaF=Fget_plot_y_EC(val);
vaG=Gget_plot_y_EC(val);
vaE=Eget_plot_y_EC(val);

X=[3:val];

figure%1st

semilogy(X,vaE(1,:),'r*')
hold on;
grid on
title('f=exp(x) Points: Equi')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|')
set(gca, 'XTick', [3:1:14])
plot(X,vaE(2,:),'bo')
plot(X,plot_b1_Equi_DX)
hold off;

figure%2nd

semilogy(X,vaE(3,:),'r*')
hold on;
grid on
title('f=exp(x) Points: Chevy')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [3:1:14])
plot(X,vaE(4,:),'bo')
plot(X,plot_b2_Cheby_DX)
hold off;

figure%3rd

semilogy(X,vaF(1,:),'r*')
hold on;
grid on
title('f=sin(x) Points: Equi')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [3:1:14])
plot(X,vaF(2,:),'bo')
plot(X,plot_b1_Equi_FX)
hold off;

figure%4th

semilogy(X,vaF(3,:),'r*')
hold on;
grid on
title('f=sin(x) Points: Chevy')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [3:1:14])
plot(X,vaF(4,:),'bo')
plot(X,plot_b2_Cheby_FX)
hold off;

figure%5th

semilogy(X,vaG(1,:),'r*')
hold on;
grid on
title('f=1/1+x^2(x) Points: Equi')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [3:1:14])
plot(X,vaE(2,:),'bo')
plot(X,plot_b2_Cheby_GX)
hold off;

figure%6th

semilogy(X,vaG(3,:),'r*')
hold on;
grid on
title('f=1/1+x^2(x) Points: Chevy')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [3:1:14])
plot(X,vaE(4,:),'bo')
plot(X,plot_b2_Cheby_GX)
hold off;






























%xiChebyflip = [];
%nos points x de Cheby garder dans une matrice xiChebyflip(1,n)
function xiChebyflip = calculDesXiCheby(n)
    for i = 0:n
        xiChebyflip(1,i+1) = cos(((2*i+1)/(2*n+2))*pi);
    end
end
%pour -0.5 0.5 on calcul premiere deriv? pour -0.5 et 2eme d?riv? pour 0.5
%fonction qui va calculer b1oub2(n) pour les points equidistants et
%chebychev
function b1b2nFXGX= calculDeb1b2(fonctionAderive,x,n,listeXequiOUcheby)
    %notre intervalle entre a et b
    a = -1;
    b = 1;
    %on est dans le cas ou on a des points ?quidistants
    if listeXequiOUcheby == 1 
        listeXequiOUcheby = linspace(-1,1,n+1);
        %on calcule les d?riv?s de 0?n 
        for i = 3:n
            matderiveFX = niemeDerive(fonctionAderive,x,0);
            fonctionAderive = matderiveFX;
            %on calcule les F(x) equidistant pour la i+1-?me d?riv? de
            %fonctionAderivee, soit f(x)=sin(x) soit i=0 on calcule deriv?e
            %i+1 = cos(x) et on calcul les points f(cos(x)) pour les points
            %equidistants qu'on stock dans matfxEqui
            matfxEqui = FxGxEqui(matderiveFX,listeXequiOUcheby);
            %on calcule b1 de la formule du cours avec matfxEqui =
            %f^(i+1)(x) -> la d?rivee i+1 de f et apres applique f(x) voir
            %formule cours
            b1b2nFXGX(1,i-2) = (max(abs(matfxEqui)))*(1/(4*((i-1)+1)))*(((b-a)/(i-1))^((i-1)+1));
        end
    else 
        listeXequiOUcheby = fliplr(calculDesXiCheby(n));
        for i = 3:n
            matderiveFXcheby = niemeDerive(fonctionAderive,x,0);
            fonctionAderive = matderiveFXcheby;
            matfxCheby = FxGxEqui(matderiveFXcheby,listeXequiOUcheby);
            b1b2nFXGX(1,i-2) = (max(abs(matfxCheby)))*(((b-a)^(i+1))/((2^(2*i+1))*(factorial(i+1))));
        end
    end

end



function FxGxEquiCheby = FxGxEqui(FxGx,listeXEquiCheby)
    fCompteurEqui = 0;
    %notre fonction f(x) pour les points ?quidistants 
    for x = drange(listeXEquiCheby)
        FxGxEquiCheby(1,fCompteurEqui+1) = subs(FxGx);
        fCompteurEqui = fCompteurEqui + 1;
    end
end




function derive = niemeDerive(Fx,x,n) 
    derive = diff(Fx,x,n+1);
end



function y=InterpolationLagrange2(x,data)
    X=data(1,:);
    Y=data(2,:);
    i=1; P=zeros(1,length(x));
    while i<=length(x) %evalue Pn pour les differntes valeurs de x
        L=PolLagrange(x(i),X);%calcule les polynomes de lagrange et les stock dans un vecteur
        P(1,i)=sum(prod([Y;L])'); % effectue le produit li*yi et somme le tout| les differentes evaluationsde Pn sont stock??es dasn un vecteur
        i=i+1;
    end
    y=P;
end

function y=PolLagrange(xev,X)%calcule les polynomes de lagrange et les stock dans un vecteur
    i=1;j=1; l=1; n=length(X); L=zeros(1,n);
    while i<= n
        while j<= n
            if j~=i 
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




