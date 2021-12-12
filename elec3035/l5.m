a = [-1.75 -.8; 1 0]; c = [1 0];
sys = ss(a,[],c,[],1);

t = 15;

O = c;
for i = 1:t-1
    O = [O; O(end,:)*a];    
end

A = inv(O(1:2,:)' * O(1:2,:)) * O(1:2,:)'; 
[u,s,v] = svd(A); 
ellipsoid(u * s(:,1:2) * u',zeros(2,1),'g')
set(gca,'fontsize',20)

hold on
A = inv(O(1:4,:)' * O(1:4,:)) * O(1:4,:)';
[u,s,v] = svd(A); 
ellipsoid(u * s(:,1:2) * u',zeros(2,1),'r')

G = gram(sys,'o');
A = sqrtm(inv(G));
ellipsoid(A,zeros(2,1),'b')

legend('t2extra','','t4extra','','tiextra','location','best')
xlabel('x')
ylabel('y')
title('t')
%print -depsc l5f3.eps

return

e = zeros(1,t);
x0 = [1; 1];
for i = 2:10
    Oi = O(1:i,:);    
    e(i) = det(inv(Oi'*Oi));
end

plot(2:t,e(2:t),'linewidth',2)
xlabel('x')
ylabel('y')
title('t')
set(gca,'fontsize',20)
ax = axis; axis([2 10 0 1.5])
%print -depsc l5f4.eps
