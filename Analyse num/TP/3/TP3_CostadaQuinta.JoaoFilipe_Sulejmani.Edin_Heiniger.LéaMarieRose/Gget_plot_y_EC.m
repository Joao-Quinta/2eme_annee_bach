% Joao Costa, Edin Sulejmani, Lea Heiniger

function matrice=Gget_plot_y_EC(y)
n=1000;%cb de points on Gait pour calcul poly
equiPoints=linspace(-1,1,n);%les n points Equi pour poly(x,data)
chebyPoints=calculDesXiCheby(n);%les n points Cheby pour poly(x,data)
GplotYEquiLa=zeros(1,12);%liste pour lagrange lagrange G
GplotYEquiBa=zeros(1,12);%liste pour barycentrique Equi G
GplotYChebyLa=zeros(1,12);%liste pour lagrange cheby G
GplotYChebyBa=zeros(1,12);%liste pour barycentrique cheby G
p=3;%le coompteur commence a 3, pas 1 
while p<y+1%pour Gaire de 3 a 14
    GequiPointsPolyX=linspace(-1,1,p+1);% on cree p points entre -1 et 1 lagrange
    GequiPointsPolyY=zeros(1,length(GequiPointsPolyX));%on cree une liste de 0 bonne taille, Gaut recreer a chaque Gois car boucle
    GchebyPointsPolX=calculDesXiCheby(p);% on cree p points entre -1 et 1 cheby
    GchebyPointsPolyY=zeros(1,length(GchebyPointsPolX));%on cree une liste de 0 bonne taille, Gaut recreer a chaque Gois car boucle
    q=1;
    while q<length(GequiPointsPolyX)+1
        GequiPointsPolyY(1,q)=1/(1+((GequiPointsPolyX(1,q))^2));% on Gait exp(x) a ces p points equi
        q=q+1;
    end
    u=1;
    while u<length(GchebyPointsPolX)+1
        GchebyPointsPolyY(1,u)=1/(1+((GchebyPointsPolX(1,u))^2));% on Gait exp(x) a ces p points cheby
        u=u+1;
    end
    GdataEqui=(zeros(2,length(GequiPointsPolyX)));%on reecree data aussi
    GdataEqui(1,:)=GequiPointsPolyX;%premiere ligne les X 
    GdataEqui(2,:)=GequiPointsPolyY;%deuxieme ligne les Y 
    GdataCheby=(zeros(2,length(GchebyPointsPolX)));
    GdataCheby(1,:)=GchebyPointsPolX;
    GdataCheby(2,:)=GchebyPointsPolyY;
    z=1;
    GresInterpolationEquiLa=zeros(1,length(equiPoints));%on deGinit des listes avc reulstats pour lagrange 
    GresInterpolationEquiBa=zeros(1,length(equiPoints));%et barycentrique, ils ont length de n (nb de points)
    GresInterpolationChebyLa=zeros(1,length(chebyPoints));
    GresInterpolationChebyBa=zeros(1,length(chebyPoints));
    while z < length(equiPoints)
        GresInterpolationEquiLa(1,z)=abs((InterpolationLagrange(equiPoints(1,z),GdataEqui))-(1/(1+((equiPoints(1,z))^2))));%on calcule le Pn Lagrage pour tout point X - G(x)
        GresInterpolationEquiBa(1,z)=abs((LagrangeBarycentrique(equiPoints(1,z),GdataEqui))-(1/(1+((equiPoints(1,z))^2))));%on calcule le Pn Bary pour tout point X - G(x)
        GresInterpolationChebyLa(1,z)=abs((InterpolationLagrange(chebyPoints(1,z),GdataCheby))-(1/(1+((chebyPoints(1,z))^2))));
        GresInterpolationChebyBa(1,z)=abs((LagrangeBarycentrique(chebyPoints(1,z),GdataCheby))-(1/(1+((chebyPoints(1,z))^2))));
        z=z+1;
    end
    GplotYEquiLa(1,p-2)=max(GresInterpolationEquiLa);%max val des 1000 appels
    GplotYEquiBa(1,p-2)=max(GresInterpolationEquiBa);%max val des 1000 appels
    GplotYChebyLa(1,p-2)=max(GresInterpolationChebyLa);
    GplotYChebyBa(1,p-2)=max(GresInterpolationChebyBa);
    p=p+1;
end
matrice=[];
matrice(1,:)=GplotYEquiLa;%premiere ligne: plotY points Equi poly lagrange
matrice(2,:)=GplotYEquiBa;%2eme ligne: plotY points Equi poly barycentrique
matrice(3,:)=GplotYChebyLa;%3eme ligne: plotY points cheby poly lagrange
matrice(4,:)=GplotYChebyBa;%4eme ligne: plotY points cheby poly barycentrique
end