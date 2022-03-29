% Joao Costa, Edin Sulejmani, Lea Heiniger

xi=linspace(0,1,5); %xi entre 0 et 1

yi=f(xi);
zi=ones(1,length(xi)); % zi=[1,1,1,1,1]

data=[xi;yi];
datan=[xi;yi;zi];

x=linspace(0,1,100);

P=InterpolationLagrange(x,data);

Pn=Hermite(x,datan);

hold on
plot(xi,yi,'blacko')%(xi,yi)
plot(x,Pn,'b') % Hermite
plot(x,P,'r')% lagrange
hold off


function y=f(x)
    y=3*x.^2-4;
end
