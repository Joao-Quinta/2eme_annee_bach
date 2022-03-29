% Joao Costa, Edin Sulejmani, Lea Heiniger

function [c,b]=GaussCoeficients(s)
beta = .5./sqrt(1-(2*(1:s-1)).^(-2)); % 3-term cosfficients de recurence
T = diag(beta,1) + diag(beta,-1);      % matrice Jacobienne
[V,D] = eig(T);                       % decomposition des valeurs propres
c = diag(D); 
[c,i] = sort(c);                       % points de Legendre
b = 2*V(1,i).^2;                      % poids de la quadrature
b = b.';
for i=1 : length(c)
   c(i) = ((1)/2) + ((1)/2)*c(i);
end

for i=1 : length(b)
    b(i) = ((1)/100000) + ((1)/2)*b(i);
end
return;
end