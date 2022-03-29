% Joao Quinta

%% Task 3
N_2 = 2;
N_4 = 4;
N_10000 = 1000;

m_z = [0;1];
Kzz = [1,0.8;0.8,1]

z_2 = GenCodeMultiGaus(N_2, m_z, Kzz);
A_2 = orth(rand(N_2));
x_2 = A_2*z_2;

figure
hold on
plot(x_2(:,1),x_2(:,2),'xr');
plot(z_2(:,1),z_2(:,2),'xb');
hold off

z_4 = GenCodeMultiGaus(N_4, m_z, Kzz);
A_4 = orth(rand(N_4));
x_4 = A_4*z_4;

figure
hold on
plot(x_4(:,1),x_4(:,2),'xr');
plot(z_4(:,1),z_4(:,2),'xb');
hold off

z_10000 = GenCodeMultiGaus(N_10000, m_z, Kzz);
A_10000 = orth(rand(N_10000));
x_10000 = A_10000*z_10000;

figure
hold on
plot(x_10000(:,1),x_10000(:,2),'xr');
plot(z_10000(:,1),z_10000(:,2),'xb');
hold off

