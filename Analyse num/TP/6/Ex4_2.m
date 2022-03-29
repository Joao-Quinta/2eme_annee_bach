% Joao Costa, Edin Sulejmani, Lea Heiniger

clear all
clc

%% Initialisation variables de l'?nonc?
n = 10;
%bord max de l'intervalle ici [0,L_intervalle]=[0,1]
L_intervalle = 1;
h = L_intervalle/n;
x = linspace(0,1,n-1)
%A = [[4, -3, 0];[0.5, 3, -1];[0, 1, 1]];
A = full(gallery('tridiag',n-1,-1,2,-1));
A_ = (1/(h^2))*A;

%% Calcul du temps moyen apr?s modification de fonction LUNoPIVOT
NbrTestDe_Algorithm = 0;
%on teste l'algorithme 20 fois
while NbrTestDe_Algorithm < 20 
    tic
    [L,U]= LUNoPivot_tridiago(A_)
    toc
    elapsedTime = toc;
    moyenneTime(1,NbrTestDe_Algorithm+1) = elapsedTime;
    NbrTestDe_Algorithm = NbrTestDe_Algorithm + 1;
end
%on fait la moyenne sur les 20 tests
moyenne = sum(moyenneTime)/length(moyenneTime)

%on test l'algorithme sans les if pour comparer le gain de temps
NbrTestDe_Algorithm = 0;
while NbrTestDe_Algorithm < 20 
    tic
    [L_no_if,U_no_if]= LUNoPivot(A_)
    toc
    elapsedTime_no_if = toc;
    moyenneTime_no_if(1,NbrTestDe_Algorithm+1) = elapsedTime_no_if;
    NbrTestDe_Algorithm = NbrTestDe_Algorithm + 1;
end
moyenne_no_if = sum(moyenneTime_no_if)/length(moyenneTime_no_if)
%% comparaison Resultat
%utilise lu(A) de matlab pour comparer
[L_exact,U_exact] = lu(A_)

resultat_L = [L-L_exact]
resultat_U = [U-U_exact]
%% Fonction LUNoPivot pour syst?me d??quations tridiagonal

function [L,U] = LUNoPivot_tridiago(A)
% LUNOPIVOT computes LU factorization of A without pivoting
% [L,U] = LUNoPivot(A) computes the LU factorization of A using
% Gaussian elimination without pivoting. L is a unit lower triangular
% matrix and U is an upper triangular matrix.



U = A;
length_A = length(A);
L = eye(length_A);
k = 1;
%on parcourt chaque ?l?ment de la matrice qui n'est pas 0
while k < length_A+1
    %p = ?l?ment de la diagonale
    p = U(k,k);
    i = k+1;
    while i < length_A+1
        %%%%%%%%cas ou l'?l?ment dans la ligne i et colonne k == 0, on ne le
        %calcule pas
        if U(i,k) == 0
            break
        end
        q  = U(i,k);
        U(i,k) = 0;
        L(i,k) = q/p;
        j = k+1;
        while j < length_A+1
            %%%%%%%%%cas ou l'?l?ment de la ligne k et colonne j == 0, on ne le
            %calcule pas 
            if U(k,j)==0
                break
            end
            U(i,j)=U(i,j)-U(k,j)*(q/p);
            %terterter = U(i,j)
            
            j = j +1 
        end
        i = i +1
    end
    k = k +1
end
end

%% Fonction LUNoPivot de l'ex 1.3

function [L,U] = LUNoPivot(A)
% LUNOPIVOT computes LU factorization of A without pivoting
% [L,U] = LUNoPivot(A) computes the LU factorization of A using
% Gaussian elimination without pivoting. L is a unit lower triangular
% matrix and U is an upper triangular matrix.
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
            %terterter = U(i,j)
            
            j = j +1 
        end
        i = i +1
    end
    k = k +1
end
end
