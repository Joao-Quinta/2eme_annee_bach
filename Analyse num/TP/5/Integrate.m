% Joao Costa, Edin Sulejmani, Lea Heiniger

function [y,fe]=Integrate(f,a,b,tol)

    if and(eps<=tol,tol<=10^(-4)) % on verifie que la tolerance soit raisonable
        
        % On commence par calculer Is
        m=1/2*(a+b);
        x=randi([0,1],1,5); % matrice de 5 nombres aleatoirs entre 0 et 1
        fx=[];
        for i=1:5
         fx(i)=f(x(i)); % on construit un vecteur contenant les f(xi)
        end
        Is=(b-a)/8*(f(a)+f(b)+f(m)+sum(fx));
        
        abstol=abs(Is)*tol; % tolerance absolue
        
        [y,fe]=Adapt(f,a,b,abstol); % On apelle la fonction Adapt
        
    else
      "erreur:la tolerance relative n'est pas raisonable"
    end
    
return;
end