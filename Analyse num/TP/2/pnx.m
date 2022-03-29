% Joao Costa, Edin Sulejmani, Lea Heiniger

function res=pnx(X,data)
c=differences_divisees(data);%appel diff divises avc input du user
xpp=data(1,:);%prend les x de input
res=ones(length(X),1);%vecteur de length(x) lignes, res sera un vecteur de taille ?gal au input X
t=1;
while t<(length(X)+1)
    Xp=ones(1,length(c));%ligne de length(c) colonnes
    z=2;
    while z<length(c)
        Xp(z)=(Xp(z-1))*(X(t)-xpp(z-1));
        %tout val z, est ?gal ? la val z-1 * x(t) - xpp(z-1)
        %x=x(t), et xpp (z-1)= xi, c'est donc (x-xi)* les calculs
        %precendents (x-x0)...(x-xi-1)
        z=z+1;
    end
    res(t)=c*(Xp.');
    t=t+1;
end
end