clear all

% Load the wing flutter data
load flutter.dat; w = flutter;

% Split the data into identification and validation parts
wi = w(1:600,:); wv = w(601:end,:);

% Test misfit computation 
tic, sys = w2r(wi,3); t_w2r = toc;
sys = tf([0.8924   -2.7278    2.8745   -1.0666],[1.0000   -2.5736    2.3369   -0.7235],-1); 
tic, [m1,wh1] = misfit2(w,sys); t1 = toc; % inefficient implementation
tic, [m2,wh2] = misfit(w,sys);  t2 = toc; % efficient implementation
ph = 1:size(w,1);
figure(1), plot(ph,w(ph,1),'-k',ph,wh1(ph,1),'b--','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
ax = axis; axis([1 1024 ax(3:4)])
%print -depsc exercisesf6.eps

figure(2), plot(ph,w(ph,2),'-k',ph,wh2(ph,2),'b--','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
ax = axis; axis([1 1024 ax(3:4)])
%print -depsc exercisesf7.eps

% GTLS
n = 3; % model order
tic, [sysgtls,mi] = gtls(wi,n,sys); t_gtls = toc;
[mv_gtls,wh_gtls] = misfit(wv,sysgtls); 

% PEM
tic, syspem = pem(iddata(wi(:,2),wi(:,1)),n); t_pem = toc;
syspem_ss = ss(syspem);
[mv_pem,wh_pem] = misfit(wv,syspem_ss(1,1));

% Plot the results of GTLS and PEM
[mv_gtls mv_pem m1] 
[t_gtls t_pem t_w2r]
ph = 1:size(wv,1);

figure(1), plot(ph,wv(ph,1),'-k',ph,wh_gtls(ph,1),'b--',ph,wh_pem(ph,1),'r-.','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
ax = axis; axis([1 150 -1 1])
%print -depsc exercisesf8.eps

figure(2), plot(ph,wv(ph,2),'-k',ph,wh_gtls(ph,2),'b--',ph,wh_pem(ph,2),'r-.','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
ax = axis; axis([1 150 -1.2 1.2])
%print -depsc exercisesf9.eps

sysgtls = idss(sysgtls);
figure(3), compare(iddata(wv(:,2),wv(:,1)),sysgtls,syspem)
%title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',15)
ax = axis; axis([1 150 ax(3:4)])
%print -depsc exercisesf10.eps

return

u = rand(10,1);
y = lsim(sys,u);
w = [u y];

