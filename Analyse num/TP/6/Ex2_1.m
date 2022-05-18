% Joao Costa, Edin Sulejmani, Lea Heiniger
%%
%(a)
A3=rand(3);
D3=detLaplace(A3)
d3=det(A3)
err3=abs(D3-d3)

A5=rand(5);
D5=detLaplace(A5)
d5=det(A5)
err5=abs(D5-d5)

A7=rand(7);
D7=detLaplace(A7)
d7=det(A7)
err7=abs(D7-d7)

A9=rand(9);
D9=detLaplace(A9)
d9=det(A9)
err9=abs(D9-d9)

%On peut voir que pour tout n=3,5,7,9 Dn=dn

%%
%(b)

n=100;

A=rand(n);
D=Determinant(A)
d=det(A)
err=abs(D-d)

%%
%(c)

%O(n^4)