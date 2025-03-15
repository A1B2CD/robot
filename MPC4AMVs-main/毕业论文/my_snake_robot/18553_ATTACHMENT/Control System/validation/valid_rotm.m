function is_valid = valid_rotm(R) %#codegen
%VALID_ROTM Summary of this function goes here
%   Detailed explanation goes here
MAX_ERROR = 1e-12;

% Check correct dimension
is_3by3 = all(size(R) == [3 3]);

% Check all elements finite
is_finite = all(isfinite(R(:)));

% Check orthogonality
is_orthogonal = isnear(R', inv(R), MAX_ERROR);

% Check that the determinant is +/- 1
has_unit_determinant = abs(abs(det(R)) - 1) < MAX_ERROR;

is_valid = all([is_3by3;
                is_finite;
                is_orthogonal;
                has_unit_determinant]);

end
