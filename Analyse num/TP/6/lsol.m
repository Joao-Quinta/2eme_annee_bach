% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=lsol(U,b)


%p 43 polycopie


%U = [[1,0,0];[2,3,0];[4,5,6]]
%b = [7,8,9]
% USOL solves the system Ux = b for upper triangular U
% y = usol(U,b) solves the system Ux = b, where U is a
% upper triangular matrix.

n = length (b);
%init x
x = zeros(n,1);

taille = 1;
%premiere etape
x(taille,1)   = b(taille)/U(taille,taille);

i = taille+1;
while i < n + 1
    
    %boucle qui calcule somme
    somme = 0;
    j = 1;
    while j < i
        somme = somme + U(i,j)*x(j);
        j = j + 1;
    end
    
    %calcul x(i) 
    x(i,1) = (b(i) - somme)/U(i,i);
    i = i + 1;
end
y = x;
end