% Joao Costa, Edin Sulejmani, Lea Heiniger

M = [1 5 10];
for i = 1 : length(M)
  A = [];
  
  A = poly([10^M(i) 10^-M(i)]); % Pour obtenir les coefficients de (x-10^m)(x-10^-m) A = [a2 a1 a0] 
  
  %on affiche les x1 et x2 obtenus pour les differents m
  m=M(i)
  x1 = (-A(2) + sqrt(A(2)^2 - 4*A(1)*A(3)))/2*A(1) 
  x2 = (-A(2) - sqrt(A(2)^2 - 4*A(1)*A(3)))/2*A(1)  

  
end
% On constate que pour m = 10, la deuxieme solution nous donne 0 alors
% qu'on devrait obtenir 10^-10.

% x1 a les bonnes valeurs on ne va donc pas changer la formule.

% Pour x2, l'erreur vient certainement de la soustraction (les deux nombres
% sont tres proches). Pour eviter ca, on va utiliser le formule de Viete
% x2= a0/(a2*x1):

a = (-A(2) + sqrt(A(2)^2 - 4*A(1)*A(3)))/2*A(1);
x2exact = A(3)/(A(1)*a)

% Cette fois on obtient la bonne valeur
  





