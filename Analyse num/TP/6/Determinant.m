% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=Determinant(A)
 [~,U,~,P]=LUPivot(A);
 prodPiv=1; n=length(A);i=1;p=0;
 
 while i<n
     if P(i)~=i
         % on re-ordone P
         t=P(P(i));
         P(P(i))=P(i);
         P(i)=t;
         p=p+1; % nombre de permutations
         i=i-1;
     end
     i=i+1;
 end
 
 for i=1:n
     prodPiv=prodPiv*U(i,i); %on multiplie les pivots entre eux
 end
     

 y=(-1)^p*prodPiv;
 %y=prodPiv
 
end