% Joao Costa, Edin Sulejmani, Lea Heiniger
function Pd=polynomesPertWilkinson(dPuisance)
    Pd=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
    for i=1 : 20
       p=[10^dPuisance 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -i]; %i-eme polynome a multiplier
       Pd=conv(p, Pd); 
    end
end