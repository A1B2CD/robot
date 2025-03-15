function I = calculateSolidCylinderInertia(m,l,r)
% Calculates the moment of inertia of a solid cylinder

% Output:
% I - returned as a 3-element vector

I = [(1/2)*m*r^2,...
     (1/12)*m*l^2 + (1/4)*m*r^2,...
     (1/12)*m*l^2 + (1/4)*m*r^2];
      
end