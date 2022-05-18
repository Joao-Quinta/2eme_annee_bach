% Joao Quinta

N = 4;

%task 1
mx = [0;0];
kxx = [1,0;0,1];
vec = GenCodeMultiGaus(N, mx, kxx);


%task 2
mx = [0;1];
kxx = [1,0.8;0.8,1];
vec = GenCodeMultiGaus(N, mx, kxx)

figure 
plot(vec(:,1),vec(:,2),'+')


%task 3
mx = [0;0;0];
kxx = [3.40,-2.75,-2.00;-2.75,5.50,1.50;-2.00,1.50,1.25];
vec = GenCodeMultiGaus(N, mx, kxx);

figure
scatter3(vec(:,1),vec(:,2),vec(:,3))
