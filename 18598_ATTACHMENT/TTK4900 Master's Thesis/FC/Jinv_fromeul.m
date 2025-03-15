function Jinv = Jinv_fromeul(eul)
phi=eul(1);
theta=eul(2);
psi=eul(3);
Jinv=inv([1 0 sin(theta); 0 cos(phi) -cos(theta)*sin(phi); 0 sin(phi) cos(phi)*cos(theta)]);
%Jinv=1/cos(theta)*[1 sin(phi)*sin(theta) cos(phi)*sin(theta); 0 cos(phi)*cos(theta) -cos(theta)*sin(phi); 0 sin(phi) cos(phi)];
if abs(cos(theta))<0.000001
 disp('Close to singularity')
end
end

