% Joao Costa, Edin Sulejmani, Lea Heiniger
dPuisance=[-16 -8 -4 0];

hold on
for i=1 :length(dPuisance)
    Pd=polynomesPertWilkinson(dPuisance(i));
    d=10^dPuisance(i)% delta
    r=(roots(Pd))'
    plot(real(r),imag(r),'o'); %bleu: -16, orange: -8, jaune:-4 , violet: 0
    
    % on va calculer la sensitivite des racines
    cond=[];
    for i=1:length(r)
        cond(i)=1
        for j=1: length(r)
            if j~=i
                cond(i)=abs(cond(i)*(i/(j-i)));        
            end 
        end
    end
    condition=cond
end
hold off

