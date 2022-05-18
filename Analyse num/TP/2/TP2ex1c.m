% Joao Costa, Edin Sulejmani, Lea Heiniger

n=6; 
data=PointsEquidistants(n);

x=[-1*pi:0.01:pi]; % x
fx=f(x); % f(x)
Px=LagrangeBarycentrique(x,data); % Pn(x)

xi=data(1,:);
yi=data(2,:);

hold on
plot(x,fx,'black') % affiche f(x) en noir
plot(x,Px,'r--') % affiche pn(x) en rouge traitillé
plot(xi,yi,'bo') %affiche les xi sous la forme de ronds bleu
hold off

function y=f(x) % fonction a interpoler
    y=exp(x/4).*sin(2.*x); % .* car on multiplie des matrices
end



function y=PointsEquidistants(n) %calcule n+1 points equidistants et leur coordonee y 
    X=zeros(1,n+1); Y=zeros(1,n+1);i=0;
    while i<=n
        X(1,i+1)= -1*pi+(2*pi/n)*i; % calcule xi
        Y(1,i+1)= f(X(1,i+1)); %clacule yi
        i=i+1;   
    end
    y=[X;Y]; % stock les xi et yi dans une matrice 
end