% Joao Costa, Edin Sulejmani, Lea Heiniger

function matrice=F1_F2_get_plot_y_C(n)
%cb de points on fait pour calcul poly
%n plus grand
y=100;
chebyPoints=calculDesXiCheby(n);%les n points Cheby pour poly(x,data)
F1plotYChebyLa=zeros(1,12);%liste pour lagrange cheby F
F2plotYChebyLa=zeros(1,12);%liste pour barycentrique cheby F
p=1;%le coompteur commence a 3, pas 1 
while p<y+1%pour faire de 3 a 14
    F1ChebyPointsPolyX=calculDesXiCheby(p);% on cree p points entre -1 et 1 lagrange
    F1ChebyPointsPolyY=zeros(1,length(F1ChebyPointsPolyX));%on cree une liste de 0 bonne taille, faut recreer a chaque fois car boucle
    F2ChebyPointsPolX=calculDesXiCheby(p);% on cree p points entre -1 et 1 cheby
    F2ChebyPointsPolyY=zeros(1,length(F2ChebyPointsPolX));%on cree une liste de 0 bonne taille, faut recreer a chaque fois car boucle
    q=1;
    while q<length(F1ChebyPointsPolyX)+1
        F1ChebyPointsPolyY(1,q)=(abs(F1ChebyPointsPolyX(1,q)));% on fait exp(x) a ces p points equi
        F2ChebyPointsPolyY(1,q)=(abs(sin(5*F2ChebyPointsPolX(1,q)))^3);
        q=q+1;
    end
    F1dataCheby=(zeros(2,length(F1ChebyPointsPolyX)));%on reecree data aussi
    F1dataCheby(1,:)=F1ChebyPointsPolyX;%premiere ligne les X 
    F1dataCheby(2,:)=F1ChebyPointsPolyY;%deuxieme ligne les Y 
    F2dataCheby=(zeros(2,length(F2ChebyPointsPolX)));
    F2dataCheby(1,:)=F2ChebyPointsPolX;
    F2dataCheby(2,:)=F2ChebyPointsPolyY;
    z=1;
    %F1resInterpolationEquiLa=zeros(1,length(equiPoints));%on definit des listes avc reulstats pour lagrange 
    %F1resInterpolationEquiBa=zeros(1,length(equiPoints));%et barycentrique, ils ont length de n (nb de points)
    F1resInterpolationChebyLa=zeros(1,length(chebyPoints));
    F2resInterpolationChebyLa=zeros(1,length(chebyPoints));
    z=1;
    while z < length(chebyPoints)
        %FresInterpolationEquiLa(1,z)=abs((InterpolationLagrange(equiPoints(1,z),FdataEqui))-sin(equiPoints(1,z)));%on calcule le Pn Lagrage pour tout point X - f(x)
        %FresInterpolationEquiBa(1,z)=abs((LagrangeBarycentrique(equiPoints(1,z),FdataEqui))-sin(equiPoints(1,z)));%on calcule le Pn Bary pour tout point X - f(x)
        F1resInterpolationChebyLa(1,z)=abs((InterpolationLagrange(chebyPoints(1,z),F1dataCheby))-(abs(chebyPoints(1,z))));
        F2resInterpolationChebyLa(1,z)=abs((InterpolationLagrange(chebyPoints(1,z),F2dataCheby))-(abs(sin(5*(chebyPoints(1,z))))^3));
        z=z+1;
    end
    %FplotYEquiLa(1,p-2)=max(FresInterpolationEquiLa);%max val des 1000 appels
    %FplotYEquiBa(1,p-2)=max(FresInterpolationEquiBa);%max val des 1000 appels
    F1plotYChebyLa(1,p)=max(F1resInterpolationChebyLa);
    F2plotYChebyLa(1,p)=max(F2resInterpolationChebyLa);
    p=p+1;
end
matrice=[];
matrice(1,:)=F1plotYChebyLa;%premiere ligne: plotY points chevy F1
matrice(2,:)=F2plotYChebyLa;%2eme ligne: plotY points chevy F2
%matrice(3,:)=FplotYChebyLa;%3eme ligne: plotY points cheby poly lagrange
%matrice(4,:)=FplotYChebyBa;%4eme ligne: plotY points cheby poly barycentrique
end
