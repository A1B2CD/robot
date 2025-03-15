function [a,b]=getab(normal)
    % A normal vector only defines two rotations not the in plane rotation.
    % Thus a (random) vector is needed which is not orthogonal with 
    % the normal vector.
    randomv=[0.57745 0.5774 0.57735]; 

    % This line is needed to prevent the case of normal vector orthogonal with
    % the random vector. But is now disabled for speed...
    if(sum(abs(cross(randomv,normal)))<0.001), randomv=[0.58 0.5774 0.56]; end
    
    % Calculate 2D to 3D transform parameters
    a=normal-randomv/(randomv*normal'); a=a/sqrt(a*a');     
    b=cross(normal,a); b=b/sqrt(b*b');
end
