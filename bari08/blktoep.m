% BLKTOEP - Construct block-Toeplitz matrix T from W with I block-rows.
%
% T = blktoep(w,i)

function T = blktoep(w,i)

[TT,dw]  = size(w); w = w';
j = TT - i  + 1;
T = zeros(i*dw,j);
for k = 1:i
  T((k-1)*dw+1:k*dw,:) = w(:,i-k+1:j+i-k);
end