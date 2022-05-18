% Joao Costa, Edin Sulejmani, Lea Heiniger

%% exo 1.4
A_1_4_a = [[1,5,2];[0,0,8];[2,4,1]];
b = [9,8,9];
[L,U,P,p] = LUPivot(A_1_4_a)
[Lexa,Uexa,pexa] = lu(A_1_4_a)


i = 1;
j = 1;
n = [8, 10, 12];
nb = length(n);
res_1_4_b = zeros(nb,1);
it = 1;
while it < nb
    A_1_4_b = [[j/n(it)]]^n(it);
    %[L,U,p] = LUPivot(A_1_4_b);
    %[Lexa,Uexa,pexa] = lu(A_1_4_b);
    res_1_4_b(it,1) = A_1_4_b;
    it = it + 1;
end
res_1_4_b
    

%% exo 1.5
%calcul erreur avec 10 matrices A aleatoires

nb_mat = 10;
res = zeros(nb_mat,2);
Xerreur_res = zeros(nb_mat,1);
n = 4;
i = 1;
while i < nb_mat + 1
    
    %dif entre U et L calcules et exactes pour 10 matrices 3x3 aleatoires
    A = randn(n,n);
    [L,U,P,p] = LUPivot(A);
    [Lexa,Uexa] = lu(A);
    Lerreur = abs(L) - abs(Lexa);
    res(i,1) = mean(mean(Lerreur));
    Uerreur = abs(U) - abs(Uexa);
    res(i,2) = mean(mean(Uerreur));
    
    
    %point 5 analyse de resultats
    Bexa = randn(n,1);
    
    Xexa = A\Bexa;
    Xcalcule = (L*U)\P*Bexa;
    Xerreur = abs(Xexa) - abs(Xcalcule);
    Xerreur_res(i,1) = mean(Xerreur);
    
    i = i + 1;
end
res
mean(res)
Xerreur_res
mean(Xerreur_res)
