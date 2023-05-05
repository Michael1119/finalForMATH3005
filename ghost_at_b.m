function [x,U] = ghost_at_b(a,b,ua,uxb,f,h)
n = (b-a)/h; h1=h*h;
A = zeros(n,n);
x = zeros(n,1);
F = zeros(n,1);
for i=1:n-1
A(i,i) = -2/h1;
A(i+1,i) = 1/h1;
A(i,i+1)= 1/h1;
end
A(n,n) = -2/h1;
A(n,n-1) = 2/h1;
for i=1:n
x(i) = a+i*h;
F(i) = feval(f,x(i));
end
F(1) = F(1) - ua/h1;
F(n) = F(n) - 2*uxb/h;
U = A\F;
return