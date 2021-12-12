% ELLIPSOID - plots the ellipsoid {Ax+x0 | ||x|| \leq 1}, A>0 
% 
% ellipsoid(A,x0,c)
%
% x0 = 0, c = 'g' default
%
% To plot (y-y0)'Q(y-y0) \leq 1, Q>0, take A = sqrtm(inv(Q)), x0 = y0;

function ellipsoid(A,x0,c)

N  = 50; % # of points

al = linspace(0,2*pi,N);
x  = A*[cos(al); sin(al)] + kron(ones(1,N),x0);

fill(x(1,:),x(2,:),c); hold on
plot(x(1,:),x(2,:),'k','linewidth',2)

axis equal

