clear all
load exactid_data

[sysh1,r] = w2r(w,lmax);
res1 = norm(r * blkhank(w,length(r)/2))

[sysh2,a,b,c,d] = uy2x2ss(u,y,lmax);
[xini,res2] = inistate(u,y,sysh2);
res2 = res2

rank(blkhank(u,2*lmax))

norm(sysh1-sysh2,'inf')

return 

n = 3; m = 1; p = 1; l = ceil(n/p);

lmax  = 5; nmax  = 5;

T = 100; % time horizon
sys0 = drss(n,p,m);
u    = rand(T,m);
xini = rand(n,1);
y    = lsim(sys0,u,[],xini);
w    = [u y];

figure(1)
plot(u,'k-','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
%set(gca,'ytick',[-1 0 1 2])
%print -depsc exercisesf4.eps

figure(2)
plot(y,'k-','linewidth',2)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
%set(gca,'ytick',[-1 0 1 2])
%print -depsc exercisesf5.eps

%save exactid_data lmax u y w
