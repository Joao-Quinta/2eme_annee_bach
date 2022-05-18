% Joao Costa, Edin Sulejmani, Lea Heiniger

function y=detLaplace(A)
  n=length(A); j=1;
  if n==0
     y=1;
 else
     y=0;
  
   while j<=n
    a1j=A(1,j);  
    A1j=reduction(A,1,j);
    y=y+((-1).^(1+j).*a1j.*detLaplace(A1j));
    j=j+1;
   end
  end
end