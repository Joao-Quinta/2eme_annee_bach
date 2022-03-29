% Joao Costa, Edin Sulejmani, Lea Heiniger

n = 50;
i = 0;
xiCheby = [];
%nos points x de Cheby garder dans une matrice xiCheby(1,n)
for i = 0:n
    xiCheby(1,i+1) = cos(((2*i+1)/(2*n+2))*pi);
end
%On reverse la liste de Cheby pour avoir les n?gatifs aux d?buts de la
%liste
xiFLIP = fliplr(xiCheby);
Fx = [];
%on cr?e un compteur qui servira enfaite ? placer ? la position i+1 
%(i=fCompteur) des x de Cheby apr?s calculer f(x) pour chaque x.
fCompteur= 0;
%notre fonction f(x) pour Cheby f(x) = |x| + x/2 ? x2, Fx contient les
%r?sultats pour chaque x apres passage dans la fonction f(x)
for xF_Cheby = drange(xiFLIP)
    Fx(1,fCompteur+1) =  abs(xF_Cheby)+(xF_Cheby/2)-(xF_Cheby)^2;
    fCompteur = fCompteur + 1;
end
fxT = transpose(Fx);
gCompteur = 0;
%notre fonction g(x) pour Cheby g(x) = 1/(1+25x^2), Gx contient les
%r?sultats pour chaque x apres passage dans la fonction g(x)
for xG_Cheby = drange(xiFLIP)
    Gx(1,gCompteur+1) = 1/(1 + 25*xG_Cheby^2);
    gCompteur = gCompteur + 1;
end

%on reprend notre liste ?quidistante de l'ex2.a
listeEqui =linspace(-1,1,51);
fxEqui=[];
fCompteurEqui = 0;
%notre fonction f(x) pour les points ?quidistants f(x) = |x| + x/2 ? x2
for xF_Equi = drange(listeEqui)
    fxEqui(1,fCompteurEqui+1) =  abs(xF_Equi)+(xF_Equi/2)-(xF_Equi)^2;
    fCompteurEqui = fCompteurEqui + 1;
end


gCompteurEqui = 0;
%notre fonction g(x) pour les points ?quidistants g(x) = 1/(1+25x^2)
for xG_Equi = drange(listeEqui)
    gxEqui(1, gCompteurEqui+1) =  1/(1 + 25*xG_Equi^2);
    gCompteurEqui = gCompteurEqui + 1;
end

x = [-1:0.01:1];
%py_F calcule le poly d'interpo avec x comme variable, x > listeEqui pour
%pouvoir visualiser l'erreur du plot, et les points ?quidistants ainsi que
%fx des points ?quidistants prit comme data
py_F = InterpolationLagrange2(x, [listeEqui ; fxEqui]);
%comme py_F mais avec data les x et fx de Cheby
py2_F = InterpolationLagrange2(x,[xiFLIP ; Fx]);
%erreur absolue pour f(x) avec points ?quidistants
erreur_Equi = [abs((abs(x) +(x/2) -x.^2) - py_F)];
%erreur absolue pour f(x) avec points de Cheby
erreur_Cheby = [abs((abs(x) +(x/2) -x.^2) - py2_F)];
%comme py_F mais pour g(x) 
py_G = InterpolationLagrange2(x, [listeEqui ; gxEqui]);
%comme py2_F mais pour g(x)
py2_G = InterpolationLagrange2(x,[xiFLIP ; Gx]);
%erreur absolue pour g(x) avec points ?quidistants
erreur_Equi_G = [abs(1./(1 + 25*x.^2) - py_G)];
%erreur absolue pour g(x) avec points de Cheby
erreur_Cheby_G = [abs(1./(1 + 25*x.^2) - py2_G)];



hold on
%on plot fx avec les x de la liste ?quidistantes, et les noeuds x de Cheby
%n=50 et Fx liste contenant f(x) pour chaque x de Cheby
semilogy(xiFLIP,Fx,'bo')
semilogy(listeEqui,fxEqui)
figure
hold on 
%on plot gx avec les x de la liste ?quidistantes, et les noeuds x de Cheby
%n=50 et Gx liste contenant g(x) pour chaque x de Cheby
semilogy(xiFLIP,Gx,'bo')
semilogy(listeEqui,gxEqui)
figure %d?soler il faut zoomer pour voir le graphe comme dans la figure.2.2
hold on
%on plot f(x) avec les points ?quidistants ainsi que le polynome d'interpo
%de f
%semilogy(x,py2_F) : poly interpo avec les points de Cheby
semilogy(x,py_F,'r--')
semilogy(xiFLIP,Fx)
semilogy(listeEqui,fxEqui,'bo')
figure %d?soler il faut zoomer pour voir le graphe comme dans la figure.2.5
hold on
%on plot g(x) avec les points ?quidistants ainsi que le polynome d'interpo
%de g
%semilogy(x,py2_G) : poly d'interpo avec les points de Cheby
semilogy(x,py_G,'r--')
semilogy(xiFLIP,Gx)
semilogy(listeEqui,gxEqui,'bo')
figure %d?soler il faut zoomer pour voir le graphe comme dans la figure.2.3
hold on

%Erreur plot de |f(x) -pn(x)|
semilogy(x,erreur_Equi,'r+')
semilogy(x,erreur_Cheby,'bx')

figure %d?soler il faut zoomer pour voir le graphe comme dans la figure.2.6
hold on
%Erreur plot de |g(x) -pn(x)|
semilogy(x,erreur_Equi_G,'r+')
semilogy(x,erreur_Cheby_G,'bx')
%fonction d'interpolation de Lagrange utilis?e pour calculer pn(x)
%permettant de calculer l'erreur plot
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








