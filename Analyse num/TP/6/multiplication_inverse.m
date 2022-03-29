% Joao Costa, Edin Sulejmani, Lea Heiniger

function X = multiplication_inverse(A,B)
%on prend inverse de A
A_inv = inv(A);

%x aura la meme taille que B
x = B;

%ca donen les dimentions de B, 
[k1,k2] = size(B);

%k2 correspond au nombre de vecteurs, k1 a la taille des vecteurs
i = 1;
while i < k2 + 1
    x(1:k1,i) = A_inv * B(1:k1,i);
    i = i + 1;
end
X = x;
end
