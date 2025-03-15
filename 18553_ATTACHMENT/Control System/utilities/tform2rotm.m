function R = tform2rotm( T )
%TFORM2ROTM Extract rotation matrix from homogeneous transformation

%#codegen

R = T(1:3,1:3);

end

