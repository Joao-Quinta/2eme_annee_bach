% Costa da Quinta, Joao Filipe
% Problem Set 7
% Problem 4

%% PARTIE 1
p = 0.1;
q = linspace(0,1);
[div,lowerBound] = KL(p,q);


figure
hold on
plot(q,div,'k')
plot(q,lowerBound,'r')
xlabel('q')
ylabel('D(Px||Qx)')
hold off

%% PARTIE 2 
qb = 0.2;
pb = linspace(0,1);
[divb,lowerBoundb] = KL(qb,pb);


figure
hold on
plot(pb,divb,'k')
plot(pb,lowerBoundb,'r')
xlabel('p')
ylabel('D(Px||Qx)')
hold off

%% FUNCTIONS

function [answer, lowerAnswer] = KL(p,q_tab)
answer = zeros(1,100);
lowerAnswer = zeros(1,100);
    for i=1:length(q_tab)
        q = q_tab(1,i);
        answer(1,i) = (p * log(p/q)) + ((1-p) * log((1-p)/(1-q)));
        lowerAnswer(1,i) = lowerB(p,q);
    end
end

%used by previous function
function b=lowerB(p,q)
    b=2*(p-q)^2*log(exp(1));
end