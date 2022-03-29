% Joao Costa, Edin Sulejmani, Lea Heiniger

function [y,fe]=Adapt(f,a,b,abstol)
    global N % variable globale
    
    %regle de Simpson
    m=1/2*(a+b);
    I1=(b-a)/6 *(f(a)+4*f(m)+f(b));
    
     %regle de Gauss
    [ci,bi]=GaussCoeficients(5);
    h=(b-a);
    prod=[];
    for i=1:5
        prod(i)=bi(i)*f(a+h*ci(i));
    end
    I2= h*sum(prod);
    
    % On calcul l'erreur
    
    err=abs(I1-I2); 
    
    
    if err<=abstol % si l'erreur est plus petite que la tolerance absolue
        y=I2;
    else 
        % si non on separe l'interval en deux et on applique Adapte aux
        % deux parties
        
        N=N+1; % On incremente le compteur d'appels a Adapte
        y1=Adapt(f,a,m,abstol);
        y2=Adapt(f,m,b,abstol);
        y=y1+y2;
    end
    fe=N*4+1; % nombre d'evaluations de la fonction 
return;
end