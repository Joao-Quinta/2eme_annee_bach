% Joao Costa, Edin Sulejmani, Lea Heiniger
    
        %%%A)
    %%1)ici, on calcule d abbord la vrai valeur itegrale pour 2 fonctions
    %%2)en suite en utilisant la methode de simpson et la methode de trapeze
%(definies en fin de fichier), pour cahqu une des fonctions.
    %%3) pour calculer ceci, on calcule en fait l erreur : erreur = abs(vrai
%valeur - valeur calcule)
    %%4) par contre on le calcule avc un nombre different de n (d ou le graphe), selon les deux methodes plus de n => un
%calcul plus precis, ce qu'on verifie avc nos resultats
    %%5) on decouvre par contre que la methode de simpson, qui etait sense etre
%plus precise que celle du trapeze, est en fait moins precise que la
%methode du trapeze pour un certain type de fonctions.

        %%%B)
    %%6)ce qui nous mene au point B), ou on calcule justement des fonctions
    %ou la methode du trapeze deviens juste aussi interessante que celle de simpson, voir plus, on le voit dans
    %les graphiques.


%%% exercice 1
close all
clear all
%interval n
n = 2:2:52;
%% initialisation de valeurs pour ex1.a

% fonction (1) exp(x^2(1 ? x)^2)
fonction1 = @(x)exp(x.^2-2*(x.^3)+x.^4); 
%int?gral "exact" de exp(x^2(1 ? x)^2)
integral_res1(1,1) = integral(fonction1,0,1);

% fonction (2) exp(-x^2)
fonction2 = @(x)exp(-x.^2);
%int?gral "exact" de exp(-x^2)
integral_res2(1,1) = integral(fonction2,0,1);

%% fonctions et int?grales pour ex1.b)
%initialisation de la valeur k
k=1;

% fonction (3) sin(2kpix)
fonction3 = @(x)sin(2*k*pi*x)
%integral "exacte" pour sin(2kpix)
integral_res3(1,1) = integral(fonction3,0,1);

% fonction (4) cos(2kpix)
fonction4 = @(x)cos(2*k*pi*x)
%integral "exacte" pour cos(2kpix)
integral_res4(1,1) = integral(fonction4,0,1);


%% initialisation des matrices erreur pour rapidit?

erreur_trap1 = zeros(1,length(n));
erreur_trap2 = zeros(1,length(n));
erreur_simpson1 = zeros(1,length(n));
erreur_simpson2 = zeros(1,length(n));
erreur_trap3= zeros(1,length(n));
erreur_trap4 = zeros(1,length(n));
erreur_simpson3 = zeros(1,length(n));
erreur_simpson4 = zeros(1,length(n));

%% boucle calcul erreur

i = 1;
while i < length(n)+1
    %erreur trap/simpson pour ex1.a)
    erreur_trap1(1,i) = abs(integral_res1(1,1)-trap(fonction1,0,1,n(i)));
    erreur_trap2(1,i) = abs(integral_res2(1,1)-trap(fonction2,0,1,n(i)));
    erreur_simpson1(1,i) = abs(integral_res1(1,1)-simpson(fonction1,0,1,n(i)));
    erreur_simpson2(1,i) = abs(integral_res2(1,1)-simpson(fonction2,0,1,n(i)));
    
    %erreur trap/simpson pour ex 1.b) sin(2k?x) et cos(2k?x)
    erreur_trap3(1,i) = abs(integral_res3(1,1)-trap(fonction3,0,1,n(i)))
    erreur_trap4(1,i) = abs(integral_res4(1,1)-trap(fonction4,0,1,n(i)))    
    erreur_simpson3(1,i) = abs(integral_res3(1,1)-simpson(fonction3,0,1,n(i)));
    erreur_simpson4(1,i) = abs(integral_res4(1,1)-simpson(fonction4,0,1,n(i)));
    i = i + 1;
end

%% affichage images 

%graphe de exp(x^2(1 ? x)^2)
semilogy(n,erreur_trap1(1,:),'r+',n,erreur_simpson1(1,:),'bo');
legend('Trap','Simpson');
xlabel('n');
ylabel('absolute error');
title('periodic fonction: exp(x.^2(1-x).^2))');


figure;

%graphe de exp(-x^2)

semilogy(n,erreur_trap2(1,:),'r+',n,erreur_simpson2(1,:),'bo');
legend('Trap','Simpson');
xlabel('n');
ylabel('absolute error');
title('Non periodic function: exp(-x.^2)');

figure

%graphe de sin(2kpix)

semilogy(n,erreur_trap3(1,:),'r+',n,erreur_simpson3(1,:),'bo');
legend('Trap','Simpson');
xlabel('n');
ylabel('absolute error');
title('sin(2kpix)');

figure

%graphe de cos(2kpix)

semilogy(n,erreur_trap4(1,:),'r+',n,erreur_simpson4(1,:),'bo');
legend('Trap','Simpson');
xlabel('n');
ylabel('absolute error');
title('cos(2kpix)');

%% Methode trap & simpson
function Tn = trap(fonction,a,b,n)
    %def h et x comme en cours
    %n intervalles entre a et b
    h = (b-a)/n; 
    x = a:h:b;
    res_somme = 0;
    i = 2;
    while i < n+1
        res_somme = res_somme + fonction(x(i));
        i = i + 1;
    end
    Tn = (1/2)*h*(fonction(a)+fonction(b))+h*res_somme;
end

function Sn = simpson(fonction,a,b,n)
    h = (b - a)/n;
    s = fonction(a)+fonction(b);
    %boucle pour les impaires
    for i = 1:2:n-1
        s = s + 4*fonction(a+i*h);
    end
    %boucle pour les pairs
    for i = 2:2:n-2
        s = s + 2*fonction(a+i*h);
    end
    Sn = h/3 * s
end
 