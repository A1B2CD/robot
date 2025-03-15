function out = Rot(joint_type,x)
%This matrix compute the rotation about x, y or z (depending on joint type)

if joint_type == 1 %X
    out = [1   0        0;
           0  cos(x) -sin(x);
           0  sin(x)  cos(x)];
elseif joint_type == 2 %Y
    out = [ cos(x) 0  sin(x);
            0      1  0;
            -sin(x) 0  cos(x)];
elseif joint_type == 3 %Z
    out = [cos(x) -sin(x)  0;
           sin(x)  cos(x)  0;
           0       0       1];
else 
    out = [0 0 0;
           0 0 0;
           0 0 0];
end
end