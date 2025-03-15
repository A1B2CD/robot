function vec = tform2trvec( T )
%TFORM2TRVEC Extract translation vector from homogeneous transformation

%#codegen

vec = T(1:3,4);

end

