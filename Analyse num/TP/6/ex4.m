% Joao Costa, Edin Sulejmani, Lea Heiniger

%x = A\B solves the system of linear equations A*x = B.



%% Initialisation des variables de l'?nonc?
n = 100;
L = 1;
h = L/n;
x = linspace(0,1,n-1);
%cr?e matrice A tridiagonal 2 en diagonal et -1 autour
A = full(gallery('tridiag',n-1,-1,2,-1));
%A = conv2(eye(9), [3 -1 2 -1 3],'same');

%multiplie par 1/h^2 comme dans l'?nonc?
A_ = (1/(h^2))*A

%% On cr?e F(x) = -2, vecteur avec que des -2 

for i = 1:n-1
   F(i,1)= -2;
end    

%F = [-2;-2;-2;-2;-2;-2;-2;-2;-2]

% X est l'inconnue dans A_*X = F, utilise "\" pour obtenir la r?ponse
X = A_\F
%Y = luA\F
[L_Exact,U_Exact] = lu(X)
Y = L_Exact*U_Exact

difference_exact_LU = [X - Y]
%% On plot x et X = A_\F
hold on
semilogy(x,Y,'bo');
semilogy(x,X);







