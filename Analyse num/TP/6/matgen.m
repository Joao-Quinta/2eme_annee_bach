function A = matgen(n, kappa)
% A = matgen(n, kappa) generates a random matrix A of size n and condition
%   number kappa.
%
%   NOTES: A = U*S*V where U and V are random orthonormal matrices, and S are
%   diagonal matrix 
%   S = diag([0, kappa^(-1/(n-1)), kappa^(-2/(n-1)), . . ., kappa^(-1)]).
%
%   Last modified 2016-11-22

A = randn(n,n); 
[U,S,V] = svd(A);
A = U*diag(kappa.^(-[0:1:n-1]/(n-1)))*V';

return
