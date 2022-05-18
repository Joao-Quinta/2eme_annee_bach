% Joao Costa, Edin Sulejmani, Lea Heiniger

n = 10 ; % nombre d'iterations

M = [1 5 10];

for i = 1 : length(M)
    A = poly([10^M(i) 10^-M(i)]);
    % A = [a2 a1 a0]
    % On initialise respectivement x0 = x1 puis x0 = x2
    
    %xo  = (-A(2) + sqrt(A(2)^2 - 4*A(1)*A(3)))/2*A(1);
    
    a = (-A(2) + sqrt(A(2)^2 - 4*A(1)*A(3)))/2*A(1);
    xo = A(3)/(A(1)*a);

    
    for s = 1 : n
       x1 = xo - polyval(A,xo)/ (2*A(1)*xo + A(2));
       xo = x1;
    end
    
    x1 % On affiche le resultat apres les n iterations du programme
    
end


