% Control example

clear all
n = 15;
load l1sys

% Constant control
[a,b,c,d] = ssdata(sys); 
u = inv(c*inv(eye(n)-a)*b)*[1;-1]; 

% Simulate the controlled system 
T = 250;
y = lsim(sys,u*ones(1,T));

% Plot the trajectories
figure
stairs(y(:,1),'r'), hold on
stairs(y(:,2),'b')
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
axis([0 250 -5 5])
set(gca,'ytick',[-5 -1 0 1 5])
plot([0 250],[-1 -1],'b--','linewidth',2)
plot([0 250],[1 1],'r--','linewidth',2)
%print -depsc l1f4.eps

% Deadbeat control
k = place(a ,b , linspace(0,0.1,n));
l = place(a',c', linspace(0,0.1,n))';
o = estim(sys,l,1:2,1:2); o = o(3:end,:);
C = k * o;

sysa = ss(a,b,[zeros(2,n); c],[eye(2); d],-1);
sysc = feedback(sysa,C);

[ac,bc,cc,dc] = ssdata(sysc(3:4,1:2));
u = inv(cc*pinv(eye(2*n)-ac)*bc)*[1;-1];

% Simulate the controlled system 
T = 50;
y = lsim(sysc,u*ones(1,T),[],rand(30,1));

% Plot the trajectories
figure
stairs(y(:,3),'r','linewidth',2), hold on
stairs(y(:,4),'b','linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([1 20 ax(3:4)]) %axis([1 15 -2 10]), set(gca,'ytick',[-5 -1 0 1 5])
%plot([0 50],[-1 -1],'b--','linewidth',2)
%plot([0 50],[1 1],'r--','linewidth',2)
%print -depsc l8f5.eps

figure
stairs(y(:,1),'r','linewidth',2), hold on
stairs(y(:,2),'b','linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([1 20 ax(3:4)]) %axis([1 15 -15 15])
%print -depsc l8f6.eps

