function I = calculateThickwalledCylinderInertia(m,l,r_inner,r_outer)
% Calculates the moment of inertia of a thick-walled cylindrical tube with
% mass m, length l, inner radius r_inner, and outer radius r_outer

% Output:
% I - moment of inertia returned as a 3-element vector

I = [(1/2)*m*(r_inner^2+r_outer^2),...
     (1/12)*m*l^2 + (1/4)*m*(r_inner^2+r_outer^2),...
     (1/12)*m*l^2 + (1/4)*m*(r_inner^2+r_outer^2)];
      
end