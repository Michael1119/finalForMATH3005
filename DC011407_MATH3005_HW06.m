clc
clear
f=@(x) -4*pi^2*cos(2*pi*x);
u=@(x) cos(2*pi*x);
[x1,U1]=ghost_at_b(0,0.5,1,0,f,0.1);
[x2,U2]=ghost_at_b(0,0.5,1,0,f,0.01);
[x3,U3]=ghost_at_b(0,0.5,1,0,f,0.001);
error1=abs(U1-u(x1));
error2=abs(U2-u(x2));
error3=abs(U3-u(x3));
format shortG
U1(mod(x1,0.1)<eps)
U2(mod(x2,0.1)<eps)
U3(mod(x3,0.1)<eps)
format shortE
error1(mod(x1,0.1)<eps)
error2(mod(x2,0.1)<eps)
error3(mod(x3,0.1)<eps)
norm(error1,"inf")
norm(error2,"inf")
norm(error3,"inf")
norm(error1,"inf")/norm(error3,"inf")

figure
plot([0;x2],[1;u(x2)],'-',[0;x1],[1;U1],'o')
title('exact solution and computed solution with h=0.1')
xlabel('x')
ylabel('u')
legend('u(x)','U_h(x)')

figure
plot([0;x2],[1;u(x2)],'-',[0;x1],[1;U2(mod(x2,0.1)<eps)],'o')
title('exact solution and computed solution with h=0.01')
xlabel('x')
ylabel('u')
legend('u(x)','U_h(x)')

figure
plot([0;x2],[1;u(x2)],'-',[0;x1],[1;U3(mod(x3,0.1)<eps)],'o')
title('exact solution and computed solution with h=0.001')
xlabel('x')
ylabel('u')
legend('u(x)','U_h(x)')

figure
semilogy(x1,error1,'-',x2,error2,'-',x3,error3,'-')
title('error between exact solution and computed solution')
xlabel('x')
ylabel('e_h(x)')
legend({'e_{0.1}(x)','e_{0.01}(x)','e_{0.01}(x)'},'Location','southeast')

x=transpose(log([0.1,0.01,0.001]));
y1=transpose(log([error1(end),error2(end),error3(end)]));
y2=transpose(log([sqrt(0.1)*norm(error1,2),sqrt(0.01)*norm(error2,2),sqrt(0.001)*norm(error3,2)]));
A=[x,ones(length(x),1)];
par1=(A'*A)\(A'*y1);
par2=(A'*A)\(A'*y2);
a=par1(1);
b=par1(2);
c=par2(1);
d=par2(2);

figure
plot(log([0.1,0.01,0.001]),a*log([0.1,0.01,0.001])+b,'-',x,y1,'o')
title('relationship between log of step size and log of infinity norm of error')
xlabel('ln(h)')
ylabel('ln(||E_h||_\infty)')
legend({'a*ln(h)+ln(b)','ln(||E_h||_\infty)'},'Location','southeast')
text(-4.5,-8,strcat('slope=',string(a)))

figure
plot(log([0.1,0.01,0.001]),c*log([0.1,0.01,0.001])+d,'-',x,y2,'o')
title('relationship between log of step size and log of 2-norm of error')
xlabel('ln(h)')
ylabel('ln(||E_h||_2)')
legend({'c*ln(h)+ln(d)','ln(||E_h||_2)'},'Location','southeast')
text(-4.5,-9,strcat('slope=',string(c)))
