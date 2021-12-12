% Identification of a scalar autonomous system

function p = ident(y,L)

H = hankel(y(1:L+1),y(L+1:end));
Y = -H(1,:);
H = H(2:end,:);

x = Y * H' * inv(H*H');
p = [1 x];

% Convert p to the Matlab convention of decending powers
p = fliplr(p);
p = p / p(1);