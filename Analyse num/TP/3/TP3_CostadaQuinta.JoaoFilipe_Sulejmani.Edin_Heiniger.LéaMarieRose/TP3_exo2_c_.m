% Joao Costa, Edin Sulejmani, Lea Heiniger

vaABS = F1_F2_get_plot_y_C(100);
Xerreur = [1: length(vaABS(2,:))];
%Y = linspace(1,0.01,100)

figure%1st

loglog(Xerreur,vaABS(1,:),'r*')
hold on;
grid on
title('erreur interpolation f1=|x|')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|')
%plot(Xerreur,Y)
hold off;

figure%1st

loglog(Xerreur,vaABS(2,:),'r*')
hold on;
grid on
title('erreur interpolation f1=|sin(5x)^3|')
xlabel('n') 
ylabel('max|Pn(x)-f(x)|')
hold off;
