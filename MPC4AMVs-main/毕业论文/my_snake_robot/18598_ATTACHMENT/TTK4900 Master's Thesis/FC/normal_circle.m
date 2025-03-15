function [X,a,b]=normal_circle(angles,angleoffset,a,b)
    % This function rotates a 2D circle in 3D to be orthogonal 
    % with a normal vector.

    % 2D circle coordinates.
    circle_cor=[cosd(angles+angleoffset);sind(angles+angleoffset)]';
    
    X = [circle_cor(:,1).*a(1) circle_cor(:,1).*a(2) circle_cor(:,1).*a(3)]+...
         [circle_cor(:,2).*b(1) circle_cor(:,2).*b(2) circle_cor(:,2).*b(3)];
end