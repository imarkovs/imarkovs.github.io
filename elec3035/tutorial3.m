clear all
load tutorial3
T = length(yp);

% Noise free data

yf_ss  = sspredict(yp,a,c,Tf);
yf_pol = polpredict(yp,p,Tf);

ss_pol_diff = norm(yf_ss-yf_pol)

figure
stairs(1:T,yp,'r--','linewidth',2), hold on
stairs(T+1:T+Tf,yf_ss,'b-','linewidth',2)
set(gca,'fontsize',20)
legend('Given data y_p','Prediction y_f','Location','Best')
xlabel('x')
ylabel('y')
title('t')

%print -depsc tutorial3f1

% Noisy data

% yp_noisy = yp + 0.0005 * randn(size(yp)) / norm(yp);

yf_ss_noisy  = sspredict(yp_noisy,a,c,Tf);
yf_pol_noisy = polpredict(yp_noisy,p,Tf);

err_ss  = norm(yf_ss-yf_ss_noisy)
err_pol = norm(yf_pol-yf_pol_noisy)

figure
stairs(T+1:T+Tf,yf_ss,'g-.','linewidth',2), hold on
stairs(T+1:T+Tf,yf_ss_noisy,'r-','linewidth',2)
stairs(T+1:T+Tf,yf_pol_noisy,'b--','linewidth',2)
ax = axis; axis([T T+Tf ax(3:4)])
set(gca,'fontsize',20)
legend('Exact y_f','State space prediction','Polynomial prediction','Location','Best')
xlabel('x')
ylabel('y')
title('t')

%print -depsc tutorial3f2

% Identification

p = [1 -1 -1 -1];

a = [1 1 1; 1 0 0; 0 1 0];
c = [1 1 1];

sys = ss(a,[],c,[],-1);
y = initial(sys,[1 0 0]',8)

p_ident = ident(y,3)

% Apply on the prediction example (exact data)

ph = ident(yp,16);
yf_ident_pol = polpredict(yp,p,Tf)

figure
stairs(T+1:T+Tf,yf_ss,'g-.','linewidth',2), hold on
%stairs(T+1:T+Tf,yf_ss_noisy,'r-','linewidth',2)
stairs(T+1:T+Tf,yf_ident_pol,'b--','linewidth',2)
ax = axis; axis([T T+Tf ax(3:4)])
set(gca,'fontsize',20)
%legend('Exact y_f','State space prediction','Polynomial prediction','Location','Best')
xlabel('x')
ylabel('y')
title('t')

% Apply on the prediction example (noisy data)

yp_noisy = yp + 0.01 * randn(size(yp)) / norm(yp);

ph    = ident(yp_noisy,16);
[ah,ch] = comp(ph);
yf_ident_ss_noisy = sspredict(yp_noisy,ah,ch,Tf)

figure
stairs(T+1:T+Tf,yf_ss,'g-.','linewidth',2), hold on
%stairs(T+1:T+Tf,yf_ss_noisy,'r-','linewidth',2)
stairs(T+1:T+Tf,yf_ident_ss_noisy,'b--','linewidth',2)
ax = axis; axis([T T+Tf ax(3:4)])
set(gca,'fontsize',20)
%legend('Exact y_f','State space prediction','Polynomial prediction','Location','Best')
xlabel('x')
ylabel('y')
title('t')

% save tutorial3 yp yp_noisy a c p Tf
