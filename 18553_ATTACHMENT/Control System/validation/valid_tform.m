function is_valid = valid_tform(T) %#codegen
%VALID_TFORM Summary of this function goes here
%   Detailed explanation goes here
MAX_ERROR = 1e-12;

% Check correct dimension
is_4by4 = all(size(T) == [4 4]);

% Check valid translation
valid_translation = valid_trvec(tform2trvec(T));

% Check valid rotation
valid_rotation = valid_rotm(tform2rotm(T));

% Check that bottom row is [0 0 0 1]
valid_bottomrow = isnear(T(4,:), [0 0 0 1], MAX_ERROR);

is_valid = all([is_4by4;
                valid_translation;
                valid_rotation;
                valid_bottomrow]);

end
