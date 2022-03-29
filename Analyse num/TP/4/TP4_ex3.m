% Joao Costa, Edin Sulejmani, Lea Heiniger
%% Initilisaition
clc; clf; clear;
n=1000;
x=linspace(2-0.07,2+0.07,n);
%bonus : (enlever comentaire)
%x=x.';
degre=9;
a=[];
for i=1:degre
    a=[a 2];
end
%% calcul polynome avc 1 appel a la fonction (bonus fait)
roots=fliplr(poly(a));
pPolyeval=polyeval(roots,x);
%% calcul erreur
for i=1:length(x)
    somme=0;
    for k=1:degre
        somme=somme+abs(a(k)*(x(i)^k));
    end
    borne_sup(i)=f(x(i))+(2*degre*eps*somme);
    borne_inf(i)=f(x(i))-(2*degre*eps*somme);
end
%% plot poly
figure
hold on
plot(x,f(x),'r','LineWidth',3)
plot(x,pPolyeval,'bl.');
title('Evaluation du polynome')
legend('polynome','polyeval','Location','southeast');
hold off
%% plot erreur
figure
hold on
plot(x,borne_sup,'g--');
plot(x,borne_inf,'bl--');
plot(x,f(x),'r');
title('Evaluation de la limite');
legend('borne sup','borne inf','Location','southeast');
hold off
%% function
function y=f(x)
    y=(x-2).^9;
end