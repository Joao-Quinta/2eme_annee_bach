% Joao Costa, Edin Sulejmani, Lea Heiniger
function y = polyeval(a,x)
taille_rep = length(x);
poly_rep = zeros (1,taille_rep);
i = 1;
while i < taille_rep + 1
    j = 1;
    poly = 0;
    while j < length (a) + 1
        poly = poly + ((x(i)^(j-1))*a(j));
        j = j+1;
    end
    poly_rep(i) = poly;
    i=i+1;
end
y = poly_rep;
end