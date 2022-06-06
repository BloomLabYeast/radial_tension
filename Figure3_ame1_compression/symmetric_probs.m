function M = symmetric_probs(c)
%%symmetric_probs converts c matrix from multcomp to a symmetric matrix of
%%p-values for superbar function
M = zeros(size(c,1));
for n = 1:size(c,1)
M(c(n,1), c(n,2)) = c(n,6);
M(n,n) = nan;
end
M = M + M'; 