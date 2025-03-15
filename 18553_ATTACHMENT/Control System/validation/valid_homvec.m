function is_valid = valid_homvec(p) %#codegen
%VALID_HOMVEC Summary of this function goes here
%   Detailed explanation goes here

% Check correct dimension
is_4by1 = all(size(p) == [4 1]);

% Check last element is 1
valid_lastelement = p(end) == 1;

% Check all elements finite
is_finite = all(isfinite(p(:)));

is_valid = all([is_4by1;
                valid_lastelement;
                is_finite]);

end

