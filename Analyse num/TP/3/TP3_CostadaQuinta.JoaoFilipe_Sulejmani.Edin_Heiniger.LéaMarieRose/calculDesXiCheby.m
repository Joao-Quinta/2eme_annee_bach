% Joao Costa, Edin Sulejmani, Lea Heiniger
function xiChebyflip = calculDesXiCheby(n)
    for i = 0:n
        xiChebyflip(1,i+1) = cos(((2*i+1)/(2*n+2))*pi);
    end
end