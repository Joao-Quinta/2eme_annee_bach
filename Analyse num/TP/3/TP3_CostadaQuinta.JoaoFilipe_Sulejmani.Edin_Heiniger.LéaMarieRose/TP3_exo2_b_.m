% Joao Costa, Edin Sulejmani, Lea Heiniger

val=100;
vaE=Eget_plot_y_EC(val);
X=[3:1:val];

figure%1st

semilogy(X,vaE(1,:),'r*')
hold on;
grid on
title('f=exp(x) Points: Equi')
xlabel('n = 100') 
ylabel('max|Pn(x)-f(x)|')
set(gca, 'XTick', [0:10:val])
plot(X,vaE(2,:),'bo')
hold off;

figure%2nd

semilogy(X,vaE(3,:),'r*')
hold on;
grid on
title('f=exp(x) Points: Chevy')
xlabel('n = 100') 
ylabel('max|Pn(x)-f(x)|') 
set(gca, 'XTick', [0:10:val])
plot(X,vaE(4,:),'bo')
hold off;