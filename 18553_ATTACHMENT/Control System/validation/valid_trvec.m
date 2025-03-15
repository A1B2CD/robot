function is_valid = valid_trvec(tr) 
%#codegen
%VALID_TRVEC Summary of this function goes here
%   Detailed explanation goes here

% Check correct dimension
is_3by1 = all(size(tr) == [3 1]);

% Check all elements finite
is_finite = all(isfinite(tr));

is_valid = all([is_3by1;
                is_finite]);

end

