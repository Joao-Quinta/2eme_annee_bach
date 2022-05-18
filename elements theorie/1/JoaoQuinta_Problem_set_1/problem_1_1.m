% Joao Quinta

clear all

m = 0;
v = 1;
test = 0.01;


%verification 1)
N = 1000;
x = GenUniGaus(N,m,v);
res1 = [0,0];

res1(1,1) = abs(m-(sum(x)/N));
x1 = x - m; %inutil car m = 0
x1 = x1 .* x1;
res1(1,2) = abs(v-(sqrt(sum(x1)/N)))



%verification 2)
N = 100000;
x = GenUniGaus(N,m,v);
res2 = [0,0];

res2(1,1) = abs(m-(sum(x)/N));
x1 = x - m; %inutil car m = 0
x1 = x1 .* x1;
res2(1,2) = abs(v-(sqrt(sum(x1)/N)))



n_vaut_mil = lt(res1,test)
n_vaut_million = lt(res2,test)



