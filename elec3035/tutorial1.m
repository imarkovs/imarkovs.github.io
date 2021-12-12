easyplot('x^2',[0,2])
plot([0 2],[0 2*9/5],'r--','linewidt',2)
plot([0 1 2],[0 9/5 2*9/5],'rO','markersize',12,'linewidt',4)
plot([0 1 2],[0 1 2^2],'bO','markersize',12,'linewidt',4)
grid on
%print -depsc tutorial1f1.eps
xlabel('x')
ylabel('y')
