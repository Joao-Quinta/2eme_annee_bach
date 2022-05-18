% Joao Quinta

function vec = GenCodeMultiGaus(N,m,Cov)
vec = mvnrnd(m,Cov,N);
end