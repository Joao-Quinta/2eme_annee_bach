% Joao Costa, Edin Sulejmani, Lea Heiniger

function matrice=Eget_plot_y_EC(y)
n=1000;%cb de points on Eait pour calcul poly
%n plus grand
equiPoints=linspace(-1,1,n);%les n points Equi pour poly(x,data)
chebyPoints=calculDesXiCheby(n);%les n points Cheby pour poly(x,data)
EplotYEquiLa=zeros(1,12);%liste pour lagrange lagrange E
EplotYEquiBa=zeros(1,12);%liste pour barycentrique Equi E
EplotYChebyLa=zeros(1,12);%liste pour lagrange cheby E
EplotYChebyBa=zeros(1,12);%liste pour barycentrique cheby E
p=3;%le coompteur commence a 3, pas 1 
while p<y+1%pour Eaire de 3 a 14
    EequiPointsPolyX=linspace(-1,1,p+1);% on cree p points entre -1 et 1 lagrange
    EequiPointsPolyY=zeros(1,length(EequiPointsPolyX));%on cree une liste de 0 bonne taille, Eaut recreer a chaque Eois car boucle
    EchebyPointsPolX=calculDesXiCheby(p);% on cree p points entre -1 et 1 cheby
    EchebyPointsPolyY=zeros(1,length(EchebyPointsPolX));%on cree une liste de 0 bonne taille, Eaut recreer a chaque Eois car boucle
    q=1;
    while q<length(EequiPointsPolyX)+1
        EequiPointsPolyY(1,q)=exp(EequiPointsPolyX(1,q));% on Eait exp(x) a ces p points equi
        q=q+1;
    end
    u=1;
    while u<length(EchebyPointsPolX)+1
        EchebyPointsPolyY(1,u)=exp(EchebyPointsPolX(1,u));% on Eait exp(x) a ces p points cheby
        u=u+1;
    end
    EdataEqui=(zeros(2,length(EequiPointsPolyX)));%on reecree data aussi
    EdataEqui(1,:)=EequiPointsPolyX;%premiere ligne les X 
    EdataEqui(2,:)=EequiPointsPolyY;%deuxieme ligne les Y 
    EdataCheby=(zeros(2,length(EchebyPointsPolX)));
    EdataCheby(1,:)=EchebyPointsPolX;
    EdataCheby(2,:)=EchebyPointsPolyY;
    z=1;
    EresInterpolationEquiLa=zeros(1,length(equiPoints));%on deEinit des listes avc reulstats pour lagrange 
    EresInterpolationEquiBa=zeros(1,length(equiPoints));%et barycentrique, ils ont length de n (nb de points)
    EresInterpolationChebyLa=zeros(1,length(chebyPoints));
    EresInterpolationChebyBa=zeros(1,length(chebyPoints));
    while z < length(equiPoints)
        EresInterpolationEquiLa(1,z)=abs((InterpolationLagrange(equiPoints(1,z),EdataEqui))-exp(equiPoints(1,z)));%on calcule le Pn Lagrage pour tout point X - E(x)
        EresInterpolationEquiBa(1,z)=abs((LagrangeBarycentrique(equiPoints(1,z),EdataEqui))-exp(equiPoints(1,z)));%on calcule le Pn Bary pour tout point X - E(x)
        EresInterpolationChebyLa(1,z)=abs((InterpolationLagrange(chebyPoints(1,z),EdataCheby))-exp(chebyPoints(1,z)));
        EresInterpolationChebyBa(1,z)=abs((LagrangeBarycentrique(chebyPoints(1,z),EdataCheby))-exp(chebyPoints(1,z)));
        z=z+1;
    end
    EplotYEquiLa(1,p-2)=max(EresInterpolationEquiLa);%max val des 1000 appels
    EplotYEquiBa(1,p-2)=max(EresInterpolationEquiBa);%max val des 1000 appels
    EplotYChebyLa(1,p-2)=max(EresInterpolationChebyLa);
    EplotYChebyBa(1,p-2)=max(EresInterpolationChebyBa);
    p=p+1;
end
matrice=[];
matrice(1,:)=EplotYEquiLa;%premiere ligne: plotY points Equi poly lagrange
matrice(2,:)=EplotYEquiBa;%2eme ligne: plotY points Equi poly barycentrique
matrice(3,:)=EplotYChebyLa;%3eme ligne: plotY points cheby poly lagrange
matrice(4,:)=EplotYChebyBa;%4eme ligne: plotY points cheby poly barycentrique
end