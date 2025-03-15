function I = calculateCylinderInertia(m,l,r)

I = diag([(1/2)*m*r^2,
          (1/12)*m*l^2 + (1/4)*m*r^2,
          (1/12)*m*l^2 + (1/4)*m*r^2]);
      
end