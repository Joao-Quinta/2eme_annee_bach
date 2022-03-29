% Joao Costa, Edin Sulejmani, Lea Heiniger

function [L,U] = LUNoPivot(A)
% LUNOPIVOT computes LU factorization of A without pivoting
% [L,U] = LUNoPivot(A) computes the LU factorization of A using
% Gaussian elimination without pivoting. L is a unit lower triangular
% matrix and U is an upper triangular matrix.

%A = [[4, -3, 1];[0.5, 3, -1];[0, 1, 0]];

U = A;
n = length(A);
L = eye(n);
k = 1;
while k < n+1
    p = U(k,k);
    i = k+1;
    while i < n+1
        q  = U(i,k);
        U(i,k) = 0;
        L(i,k) = q/p;
        j = k+1;
        while j < n+1
            U(i,j)=U(i,j)-U(k,j)*(q/p);
            j = j +1
        end
        i = i +1
    end
    k = k +1
end
end