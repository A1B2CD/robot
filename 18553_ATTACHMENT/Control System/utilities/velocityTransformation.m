function [J,Jinv] = velocityTransformation(eta)
%#codegen

phi = eta(4);
theta = eta(5);
psi = eta(6);

cphi = cos(phi);
sphi = sin(phi);
cth  = cos(theta);
sth  = sin(theta);
 
J1 = Rzyx(phi,theta,psi);
  
J2 = [...
      1  sphi*sth/cth  cphi*sth/cth;
      0  cphi          -sphi;
      0  sphi/cth      cphi/cth ];
  
J2_inv = [ 1 0      -sth;
           0 cphi   cth*sphi;
           0 -sphi  cth*cphi ];
 
J = [ J1  zeros(3,3);
      zeros(3,3) J2 ];
  
Jinv = [ J1'  zeros(3,3);
         zeros(3,3)  J2_inv ];

end