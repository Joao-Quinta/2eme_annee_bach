% Joao Costa, Edin Sulejmani, Lea Heiniger

%A = [[4, -3, 1];[0.5, 3, -1];[0, 1, 0]];
%B = [[1,2,3]',[4,5,6]',[7,8,9]'];


%matrices de taille 100
n=100;
%k qui change 
k = [2,6,10,18];
taille = length(k);
res_moyenne = zeros(1,taille);
i = 1;

while i < length(k) + 1
    %on gerene la matrice nxn conditionne a 10^k(i)
    A = matgen(n,10^k(i));
    %on genere x exact
    Xexa = randn(n,1);
    %on calcule B exacte
    Bexa = A * Xexa;
    
    %on calcule x avec la fonction multi_inverse
    Xmulti = multiplication_inverse(A,Bexa);
    
    %on calcule la difference
    Xerreur = abs(Xexa) - abs(Xmulti);
    
    %on met moyenne de l erreru dans res_moyenne
    res_moyenne(1,i) = mean(mean(Xerreur));
    
    i = i + 1;
end
res_moyenne