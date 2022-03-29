% Joao Costa, Edin Sulejmani, Lea Heiniger

n=2;
k=10^2; %%%faire varier
A=matgen(n,k);

Xexa=randn(n,1); %x exacte pris aleatoirement
b=A.*Xexa; % on calcule b

Xchap_Cra=Cramer2x2(A,b); % calcul de x avec la methode de cramer pour les matrices 2x2
erreur_Cra=err(Xchap_Cra,Xexa) 
residus_Cra=res(A,b,Xchap_Cra,Xexa)

[L,U,P,p]=LUPivot(A);
Xchap_Gauss=(L.*U)\(P.*b); % calcul de x avec la methode de gauss
erreur_Gauss=err(Xchap_Gauss,Xexa) 
residus_Gauss=res(A,b,Xchap_Gauss,Xexa)

Xchap_bslash=A\b; % calcul de x avec la fonction \
erreur_bslash=err(Xchap_bslash,Xexa) 
residus_bslash=res(A,b,Xchap_bslash,Xexa)



function y=err(Xchap,Xexa) % erreur forward
y=(norm(Xchap-Xexa)/norm(Xexa));
end

function y=res(A,b,Xchap,Xexa) % norme des residus
y=(norm(A.*Xchap-b)/(norm(A)*norm(Xexa)+norm(b)));
end