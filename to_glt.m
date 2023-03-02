%% Compute GLT representation of factor loading matrix
% input:
%   beta - factor loading matrix. A matrix of size factors times
%     observations, i.e. r times m
% output:
%   glt - GLT matrix (transposed; just like beta)
function glt=to_glt(beta)
[~,pivot_columns]=rref(beta);
[q,~]=qr(beta(:,pivot_columns));
glt=q'*beta;
glt(abs(glt)<sqrt(eps))=0;
end