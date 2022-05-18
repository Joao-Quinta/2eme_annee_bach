% Joao Costa, Edin Sulejmani, Lea Heiniger


%d?finit une liste ?quidistante entre [-1,1] avec 50 ?l?ments
listeEqui =linspace(-1,1,51);
n = 50;
h = 2/n
xiCheby = [];
%nos points x de Cheby garder dans une matrice xiCheby(1,n)
for i = 0:n
    xiCheby(1,i+1) = cos(((2*i+1)/(2*n+2))*pi);
end
WiEqui = [];
WiCheby = [];
%nos poids wi pour les points ?quidistants avec la formule de l'ex2.a
for i = 0:n 
    WiEqui(1,i+1) = (-1)^(n-i)/((((h)^n)*factorial(n-i)*factorial(i)));
end
%nos poids wi pour les points de Cheby avec la formule de l'ex2.a
for i = 0:n;
    Thetai = ((2*i + 1)*pi)/(2*n +2);
    WiCheby(1,i+1) = ((-1)^i*2^n*sin(Thetai))/(n+1);
end
%nos poids wi pour les points ?quidistants avec la formule du cours wi =
%1/prod(xi - xj) 
WiEqui2= zeros(n,1);
LdeX = 1;
for l = 0:n
    for m = 0:n
        if l ~= m
            LdeX = LdeX*(listeEqui(l+1) - listeEqui(m+1));
        end
    end
    WiEqui2(l+1) = 1/LdeX;
    LdeX = 1;
end
%on compare et on peut v?rifier num?riquement que les 2 formules sont
%?gales
compare_Equi = [transpose(WiEqui), WiEqui2]
%nos poids wi pour les points de Cheby avec la formule du cours wi =
%1/prod(xi - xj) 
WiCheby2 = zeros(n,1);
LdeXCheby = 1;
for t = 0:n
    for s = 0:n
        if t ~= s
            LdeXCheby = LdeXCheby*(xiCheby(t+1) - xiCheby(s+1));
        end
    end
    WiCheby2(t+1) = 1/LdeXCheby;
    LdeXCheby = 1;
end
%on compare et on peut v?rifier num?riquement que les 2 formules sont
%?gales
comapre_Cheby = [transpose(WiCheby), WiCheby2]
