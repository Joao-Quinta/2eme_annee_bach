% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=Cramer2x2(A,b)
d=(A(1,1)*A(2,2)-A(2,1)*A(1,2));
y(1,1)=(b(1,1)*A(2,2)-b(2,1)*A(1,2))/d;
y(2,1)=(b(2,1)*A(1,1)-b(1,1)*A(2,1))/d;
end

