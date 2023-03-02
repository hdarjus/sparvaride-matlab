%% Compute if a factor loading matrix the Anderson-Rubin row deletion rule
% input:
%   beta - factor loading matrix. A matrix of size factors times
%     observations, i.e. r times m
% output:
%   identified - boolean. 1 if Anderson-Rubin is satisfied and 0 otherwise
function identified = is_identified(beta)
glt=to_glt(beta);
delta=glt~=0;
identified=is_identified_indicator(delta);
end