% Joao Costa, Edin Sulejmani, Lea Heiniger

function c=differences_divisee(data)
X=data(1,:);%ligne 1 de input
Y=data(2,:);%ligne 2 de input
c=[];%ca sera la liste/matrice avc le resultat
cp=[];%liste de val calcul? par la fonction, ce calcul depend de cpp
cpp=Y;%on lance la boucle avc cpp=Y
c(1,1)=Y(1,1);%premiere valeur de c, ou c0=y0
p=1;%longueur de c
while p < length(X)%condition d arret, quand C est aussi grand que le nb de points, on aura fini
    k=1;%ca sera un compteur pour la prochaine boucle
    while k < length(cpp)%cette boucle va calculer cp, len(cp)+1=len(cpp) 
        cp (1,k)= (cpp(k+1)-cpp(k))/(X(k+p)-X(k));%? la kieme valeur de cp on assossie : cpp(k+1)-cpp(k) ->c'est le numerateur de la diff divise.
        %et X(k) est en fait xi, qui incremente a chaque fois, p=len(c), en fait la longueur de la liste c = la distance des x dans le denominateur 
        k=k+1;%on incremente k
    end
    c(1,p+1)=cp(1,1);%la prochaine valeur de c sera forcement la premiere valeur de cp qu on vient de calculer
    cpp=cp;%cpp devient cp, 
    cp=[];%et on reconstruit cp depuis cpp (ancien cp)
    p=p+1;%vu que p correspond a la longueur de c, et que ca vient de gagner un point, on l incremente, 
end
