% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=usol(U,b)


%p 43 polycopie


% U = [[1,2,3];[0,4,5];[0,0,6]]
% b = [7,8,9]
% USOL solves the system Ux = b for upper triangular U
% y = usol(U,b) solves the system Ux = b, where U is a
% upper triangular matrix.

n = length (b);
%init x
x = zeros(n,1);

taille = n;
%premiere etape
x(taille,1)= b(taille)/U(taille,taille);

i = taille-1;
while i > 0
    
    %boucle qui calcule somme
    somme = 0;
    j = i + 1;
    while j < n + 1
        somme = somme + U(i,j)*x(j);
        j = j + 1;
    end
    
    %calcul x(i) 
    x(i,1) = (b(i) - somme)/U(i,i);
    i = i - 1;
end
y = x;
end