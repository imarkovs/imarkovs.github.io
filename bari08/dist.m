% DIST - distance modulo translation, rotation, and scaling
%
% [d,a,s,r,ph] = dist(p,q)
%
% D  - distance between P and Q modulo translation, rotation, and scaling
% A  - translation vector
% S  - scaling factor
% R  - rotation angle in radians
% PH - best approximation of P by a translation, rotation, and scaling of Q

function [d,a,s,r,ph] = dist(p,q)

n = size(q,2); % number of points

% Form the matrix in the least sqares problem (2)
M = zeros(2*n,4);
M(1:2:end,1) = 1;
M(2:2:end,2) = 1;
M(:,3) = q(:);
R  = [0 -1; 1 0]; % rotation matrix by pi/2
qr = R * q;
M(:,4) = qr(:);

% Solve the least sqares problem (2)
ab = M \ p(:); 
ph = M * ab; % translation, rotation, and scaling of Q fitting P
ph = reshape(ph,2,n);
d  = norm(p-ph,'fro');

% Extract the rotation and scaling parameters
a = ab(1:2); 
s = norm(ab(3:4));
r = asin(ab(4)/s);