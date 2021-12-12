% BLKHANK - Construct block-Hankel matrix H from W with I block-rows.
%
% H = blkhank(w,i)

function H = blkhank(w,i)

[T,dw]  = size(w); w = w';
j = T - i  + 1;
H = zeros(i*dw,j);
for k = 1:i
  H((k-1)*dw+1:k*dw,:) = w(:,k:k+j-1);
end