a = [-1.75 -.8; 1 0]; b = [1; 0];
sys = ss(a,b,eye(2),zeros(2,1),1);

t = 15;

C = b;
for i = 1:t-1
    C = [C a*C(:,end)];    
end

xini = [1;1];
xdes = [0;0];
U = flipud(C' * inv(C*C') * (xdes - a^(t)*xini));

y = lsim(sys,[U;0],[],xini)

stairs(0:(t+2),[U; zeros(3,1)],'linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([0 (t+2) ax(3:4)])
%print -depsc l4f6.eps

stairs(0:(t+2),[y(:,1); zeros(2,1)],'linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([0 (t+2) ax(3:4)])
%print -depsc l4f7.eps

stairs(0:(t+2),[y(:,2); zeros(2,1)],'linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([0 (t+2) ax(3:4)])
%print -depsc l4f8.eps


G = gram(sys,'c');
A = sqrtm(Q);
ellipsoid(A,zeros(2,1),'g')

hold on
G = C(:,1:5) * C(:,1:5)'; 
A = sqrtm(Q);
ellipsoid(A,zeros(2,1),'r')

G = C(:,1:2) * C(:,1:2)'; 
A = sqrtm(Q);
ellipsoid(A,zeros(2,1),'b')
set(gca,'fontsize',20)

legend('tiextra','','t5extra','','t2extra')
xlabel('x')
ylabel('y')
title('t')
%print -depsc l4f1.eps

e = zeros(1,t);
for i = 2:t
    xd = xdes - a^i*xini;
    Ci = C(:,1:i);    
    e(i) = xd' * inv(Ci*Ci') * xd;
end

plot(2:t,e(2:t),'linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([2 t ax(3:4)])
%print -depsc l4f2.eps
