% Joao Quinta

function x = GenUniGaus(N,m,v)
x = m + sqrt(v) * randn(N,1);
end