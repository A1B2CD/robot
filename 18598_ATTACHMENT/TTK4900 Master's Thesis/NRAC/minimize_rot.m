function [err,circm]=minimize_rot(angles,circmo,angleoffset,a,b)
    % This function calculates a distance "error", between the same
    % coordinates in two circles on a line. 
    [circm]=normal_circle(angles,angleoffset,a,b);
    dist=(circm-circmo).^2;
    err=sum(dist(:));
end