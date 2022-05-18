% Joao Costa, Edin Sulejmani, Lea Heiniger
%% Donn?es
n=100;
x0=(pi/4);
%remplit les matrice de zeros
erreurReel=zeros(1,n);
erreurComplex=zeros(1,n);
%La vraie valeure de la d?riv?e
fDeriver=funcDeriv(x0);
%on genere un espace vectoriel logarithmique entre 10^-16 et 10^-1 avec n
%?l?ments
h=logspace(-16,-1,n); % Gen?re un espace vectoriel logaritmique entre 10^-16 et 10^0 avec n ?l?ments
%O(h)
Odeh=logspace(-9,1,n);
%% Calculs des real/complex steps et leur estimations th?orique
for i=1:length(h)
    %?R(x0,h;f)
    deltaReel=(f(x0+h(i))-f(x0))/(h(i)); %formule pour "real steps" des diff?rences finies ?R(x0,h;f):= (f(x0+h)?f(x0))/h
    %?C(x0,h;f)
    deltaComplex=imag(f(x0+(sqrt(-1))*h(i))/(h(i))); %formule pour "complex steps" des diff?rences finies ?C(x0,h;f) := Im(f(x0+ih)/h)
    %calcul d'erreurs d'estimations
    erreurReel(1,i)=abs(deltaReel-fDeriver); %estimation th?orique pour "real steps"
    erreurComplex(1,i)=abs(deltaComplex-fDeriver); %estimation th?orique pour "complex steps"
end
%% Plot
hold on
grid on
%on mets les axes en puissance de 10
set(gca,'Yscale','log');
set(gca,'Xscale','log');
%plot pour real steps
plot(h,erreurReel,'ro');
%plot pour complex steps
plot(h,erreurComplex,'bo');
%plot for h
plot(Odeh,Odeh,'m');
%plot for h^2
plot(Odeh,Odeh.^2,'cyan');
legend('real step','complex step','h','h^2','Location','southeast');
hold off
%% Fonctions
%fonction pour la d?riv? de f(x)
function yPrime= funcDeriv(x)
   yPrime= exp(-x)*(2*x*cos(x)^3 + 3*cos(x)*sin(x)^2 - 3*x^2*cos(x)^2*sin(x)) - exp(-x)*(x^2*cos(x)^3 + sin(x)^3)
   %exp(-x)*(2*x*cos(x)^3 + 3*cos(x)*sin(x)^2 - 3*x^2*cos(x)^2*sin(x)) - exp(-x)*(x^2*cos(x)^3 + sin(x)^3)
   %((-3*(x.^2)*sin(x)*(cos(x).^2)*exp(x))+(2*x*(cos(x).^3)*exp(x))+(3*cos(x)*(sin(x).^2)*exp(x))-((sin(x).^3)*exp(x))-((x.^2)*(cos(x).^3)*exp(x)))/(exp(x).^2)

end
%fonction pour f(x)
function y = f(x)
   y = (((x^2)*(cos(x)^3))+(sin(x)^3))/(exp(x));
   %(((x.^2)*(cos(x).^3))+(sin(x).^3))/(exp(x));
end
