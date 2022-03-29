% Costa da Quinta, Joao Filipe
% Problem Set 7
% Problem 3


%% (a)
disp('Q(X) = a')
KL_div_A = KLDiv(unifP,aQ)


%% (b)
disp('Q(X) = b')
KL_div_b = KLDiv(unifP,bQ)


%%
unifP = [1/8,1/8,1/8,1/8,1/8,1/8,1/8,1/8];   %p(x) unif sur [1,8]
aQ = [0.03,0.07,0.1,0.2,0.25,0.2,0.1,0.05];  %q(x) (a)
bQ = [0.1,0,0,0.4,0,0,0.3,0.2];              %q(x) (b)
%% function 

function D_KL=KLDiv(p,q)
    D_KL=0;
    n=length(p);

    for i=1:n
        %si p(x) = 0 => (p(1,i)*log2(p(1,i)/q(1,i))) = 0 => D_KL=D_KL + 0;
        if p(1,i)==0
           D_KL=D_KL + 0;
        %division par 0 q(x) = 0 => log2(p(1,i)/q(1,i)) -> division par 0 
        elseif q(1,i)==0
           D_KL=Inf;
           break;
        else
           D_KL=D_KL + (p(1,i)*log2(p(1,i)/q(1,i)));
        end          
    end
end