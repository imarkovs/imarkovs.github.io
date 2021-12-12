% Harmonic oscillator

g = inline('[0 1; -1 0] * x', 't', 'x')
vectfield(g,-1:0.1:1,-1:0.1:1)

xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)

%print -depsc l3f1

a = [0 1; -1 0];
eig(a)

