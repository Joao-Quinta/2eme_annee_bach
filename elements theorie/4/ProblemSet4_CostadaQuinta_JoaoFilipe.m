%comment unecessary ones
theta=0.25;
theta=0.5;

N=32;
N=1024;
N=5024;

dis=makedist('Binomial','N',N,'p',theta);
x=[];
for i=1:1:10000
    x(i)=random(dis);
end

hist(x,50);

