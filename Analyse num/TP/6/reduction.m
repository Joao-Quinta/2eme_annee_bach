% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=reduction(A,i,j)
 A(i,:)=[];
 A(:,j)=[];
 y=A;
end