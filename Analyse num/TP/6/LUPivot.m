% Joao Costa, Edin Sulejmani, Lea Heiniger

function [L,U,P,p] = LUPivot(A)
% LUPIVOT computes LU factorization of A with partial pivoting
% [L,U,p] = LUPivot(A) computes the LU factorization of A with partial
% pivoting. L is a unit lower triangular matrix, U is an upper triangular
% matrix, and p is a vector of permutations where p(i) is the row of A
% from which the i-th pivot is selected. In other words, p is computed such
% that solving A*x = b is equivalent to solving L*U*x = b(p).
%A = [[4, -3, 1];[0.5, 3, -1];[0, 1, 0]];

taille = length(A);
U = A;
L = eye(taille);
P = eye(taille);

i = 1;
while i < taille
    
    %on decouvre val_max pour la colonne avc i >= k
    
    j = i;
    k = i;
    val_max = abs(U(j,k));
    ligne_val_max = j;
    while j < taille
        if U(j,k) > val_max
            val_max = abs(U(j,k));
            ligne_val_max = j;
            j = j + 1;
        else
            j = j + 1;
        end
    end
    
    %si val_max != 0
    
    if val_max ~= 0
        
        %changement ligne U
        ligne_U = U(k, k:taille);
        U(k,k:taille) = U(ligne_val_max, k:taille);
        U(ligne_val_max, k:taille) = ligne_U;
        
        %changement ligne L
        ligne_I = L(k, 1:k-1);
        L(k, 1:k-1) = L(ligne_val_max, 1:k-1);
        L(ligne_val_max, 1:k-1) = ligne_I;
        
        %changement ligne P
        ligne_P = P(k, 1:taille);
        P(k, 1:taille) = P(ligne_val_max, 1:taille);
        P(ligne_val_max, 1:taille) = ligne_P;
        
        
        %boucle changements val
        j = k + 1;
        while j < taille + 1
            L(j, k) = U(j, k) / U(k, k);
            U(j, k:taille) = U(j, k:taille) - (L(j, k) * U(k, k:taille));
            j = j + 1;
        end
    end    
    i = i + 1;
end
p = zeros(length(P),1);
i = 1;
while i < length(P) + 1
    j = 1;
    while j < length(P) + 1
        if P(i,j) == 0
            j = j + 1;
        else
            p(i,1) = j; 
            j = length(P) + 1;
        end
    end
    i = i + 1;
    
    
    
end
end
    