% Joao Costa, Edin Sulejmani, Lea Heiniger

function matrice=Fget_plot_y_EC(y)
n=1000;%cb de points on fait pour calcul poly
%n plus grand
equiPoints=linspace(-1,1,n);%les n points Equi pour poly(x,data)
chebyPoints=calculDesXiCheby(n);%les n points Cheby pour poly(x,data)
FplotYEquiLa=zeros(1,12);%liste pour lagrange lagrange F
FplotYEquiBa=zeros(1,12);%liste pour barycentrique Equi F
FplotYChebyLa=zeros(1,12);%liste pour lagrange cheby F
FplotYChebyBa=zeros(1,12);%liste pour barycentrique cheby F
p=3;%le coompteur commence a 3, pas 1 
while p<y+1%pour faire de 3 a 14
    FequiPointsPolyX=linspace(-1,1,p+1);% on cree p points entre -1 et 1 lagrange
    FequiPointsPolyY=zeros(1,length(FequiPointsPolyX));%on cree une liste de 0 bonne taille, faut recreer a chaque fois car boucle
    FchebyPointsPolX=calculDesXiCheby(p);% on cree p points entre -1 et 1 cheby
    FchebyPointsPolyY=zeros(1,length(FchebyPointsPolX));%on cree une liste de 0 bonne taille, faut recreer a chaque fois car boucle
    q=1;
    while q<length(FequiPointsPolyX)+1
        FequiPointsPolyY(1,q)=sin(FequiPointsPolyX(1,q));% on fait exp(x) a ces p points equi
        q=q+1;
    end
    u=1;
    while u<length(FchebyPointsPolX)+1
        FchebyPointsPolyY(1,u)=sin(FchebyPointsPolX(1,u));% on fait exp(x) a ces p points cheby
        u=u+1;
    end
    FdataEqui=(zeros(2,length(FequiPointsPolyX)));%on reecree data aussi
    FdataEqui(1,:)=FequiPointsPolyX;%premiere ligne les X 
    FdataEqui(2,:)=FequiPointsPolyY;%deuxieme ligne les Y 
    FdataCheby=(zeros(2,length(FchebyPointsPolX)));
    FdataCheby(1,:)=FchebyPointsPolX;
    FdataCheby(2,:)=FchebyPointsPolyY;
    z=1;
    FresInterpolationEquiLa=zeros(1,length(equiPoints));%on definit des listes avc reulstats pour lagrange 
    FresInterpolationEquiBa=zeros(1,length(equiPoints));%et barycentrique, ils ont length de n (nb de points)
    FresInterpolationChebyLa=zeros(1,length(chebyPoints));
    FresInterpolationChebyBa=zeros(1,length(chebyPoints));
    while z < length(equiPoints)
        FresInterpolationEquiLa(1,z)=abs((InterpolationLagrange(equiPoints(1,z),FdataEqui))-sin(equiPoints(1,z)));%on calcule le Pn Lagrage pour tout point X - f(x)
        FresInterpolationEquiBa(1,z)=abs((LagrangeBarycentrique(equiPoints(1,z),FdataEqui))-sin(equiPoints(1,z)));%on calcule le Pn Bary pour tout point X - f(x)
        FresInterpolationChebyLa(1,z)=abs((InterpolationLagrange(chebyPoints(1,z),FdataCheby))-sin(chebyPoints(1,z)));
        FresInterpolationChebyBa(1,z)=abs((LagrangeBarycentrique(chebyPoints(1,z),FdataCheby))-sin(chebyPoints(1,z)));
        z=z+1;
    end
    FplotYEquiLa(1,p-2)=max(FresInterpolationEquiLa);%max val des 1000 appels
    FplotYEquiBa(1,p-2)=max(FresInterpolationEquiBa);%max val des 1000 appels
    FplotYChebyLa(1,p-2)=max(FresInterpolationChebyLa);
    FplotYChebyBa(1,p-2)=max(FresInterpolationChebyBa);
    p=p+1;
end
matrice=[];
matrice(1,:)=FplotYEquiLa;%premiere ligne: plotY points Equi poly lagrange
matrice(2,:)=FplotYEquiBa;%2eme ligne: plotY points Equi poly barycentrique
matrice(3,:)=FplotYChebyLa;%3eme ligne: plotY points cheby poly lagrange
matrice(4,:)=FplotYChebyBa;%4eme ligne: plotY points cheby poly barycentrique
end
