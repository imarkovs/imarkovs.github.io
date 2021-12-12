p = [1     0    -1    -1     0     1
     1     1     1    -1    -1    -1];

q = [2.5    2.6    2.5    3.5    3.4    3.5
     1.5    1.0    0.5    0.5    1.0    1.5];

[d,ah,sh,th,ph] = dist(p,q)

figure(2)
fill(p(1,:),p(2,:),'g--'), hold on
plot(p(1,:),p(2,:),'ko','markersize',4,'linewidth',4),
fill(ph(1,:),ph(2,:),'r--'),
plot(ph(1,:),ph(2,:),'ko','markersize',4,'linewidth',4)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
axis equal, axis([-1.5 4 -1.5 2])
set(gca,'ytick',[-1 0 1 2])
%print -depsc exercisesf2.eps

[d,ah,sh,th,qh] = dist(q,p)

figure(3)
fill(qh(1,:),qh(2,:),'g--'), hold on
plot(qh(1,:),qh(2,:),'ko','markersize',4,'linewidth',4)
fill(q(1,:),q(2,:),'r--'),
plot(q(1,:),q(2,:),'ko','markersize',4,'linewidth',4),
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',20)
axis equal, axis([-1.5 4 -1.5 2])
set(gca,'ytick',[-1 0 1 2])
%print -depsc exercisesf3.eps

return

% data generation
p = [1 0 -1 -1  0  1
     1 1  1 -1 -1 -1];
qq = [1 0   -1 -1  0    1
      1 0.8  1 -1 -0.8 -1];
a = [3;1]; s = .5; t = pi/2;
q = s * [cos(t) -sin(t); sin(t) cos(t)] * qq + a(:,ones(1,size(qq,2)));

figure(1)
fill(p(1,:),p(2,:),'g--'), hold on
plot(p(1,:),p(2,:),'ko','markersize',4,'linewidth',4)
fill(q(1,:),q(2,:),'r--'), hold on
plot(q(1,:),q(2,:),'ko','markersize',4,'linewidth',4)
title('t'), xlabel('x'), ylabel('y')
set(gca,'fontsize',15)
axis equal, axis([-1.5 4 -1.5 2])
%print -depsc exercisesf1.eps
