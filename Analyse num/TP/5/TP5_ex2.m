% Joao Costa, Edin Sulejmani, Lea Heiniger

%% a)

[c4,b4]=GaussCoeficients(4)

[c5,b5]=GaussCoeficients(5)

%% b)

a=0;
b=1;

f1= @(x) 4/(1+x^2);
fi= @(x) cos(x);
f2=@(x) 4*sqrt(1-x^2);

Tol=linspace(10^(-7),10^(-4),5000);


global N 
Fe1=[]; Fe2=[]; Err1=[]; Err2=[];

for i=1:length(Tol) % on fait varier la tolerance
    tol=Tol(i);
    
    N=1;
    [y1,fe1]=Integrate(f1,a,b,tol);
    Fe1(i)=fe1;
    y1

    N=1; 
    [y2,fe2]=Integrate(f2,a,b,tol);
    Fe2(i)=fe2;
    y2

    Err1(i)=abs(pi-y1);
    Err2(i)=abs(pi-y2);
    
end

semilogy(Fe1,Err1,'rx',Fe2,Err2,'bo');
legend('f(x)=4/(1+x^2)','f(x)=4*sqrt(1-x^2)');
xlabel('nombre d evaluations de f');
ylabel('erreur');
