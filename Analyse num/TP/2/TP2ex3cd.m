% Joao Costa, Edin Sulejmani, Lea Heiniger

n=10; 
data=PointsEquidistants(n);

x=[-1*pi:0.1:pi];
fx=f(x);
Px=pnx(x,data);

xi=data(1,:);
yi=data(2,:);

hold on
plot(x,fx,'black') % affiche f(x) en noir
plot(x,Px,'r--') % affiche pn(x) en rouge traitill??
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


%exo 3.d) alors il faudrait appeller la fonction differences_divisees avec data1=(xi;yi) et data2=(xi;zi), on aura donc 2 vecteurs, c1 et c2 respectivement.
%ensuite on construit deux polynomes differents, hi et ki, on pourra ensuite contruire p2n+1

%Bonus : pour calculer pn+1(x) si on a d?j? pn(x), on utilise la formule
%suivate:
%pn+1(x)= (xn+1 -x)/(xn+1 - x0) * pn(x) + (x-x0)/(xn+1 -x0) * qn(x)
%o? qn(x)= y[x1]+ dy[x1,x2]*(x-x1)+ ... +
%d^ny[x1,...,xn+1]*(x-x1)...(x-xn)

%d=delta