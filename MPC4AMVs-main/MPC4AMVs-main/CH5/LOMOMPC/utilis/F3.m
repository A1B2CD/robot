function [ f3 ] = F3( X,Xe,P )
% P = [xR;yR;psiR;uR;vR;rR;uRdot;vRdot;rRdot];
% System coefficients
%==========================================================================
m=116;
Iz=13.1;
X_udot=-167.6;
Y_vdot=-477.2;
N_rdot=-15.9;
Xu=26.9;
Yv=35.8;
Nr=3.5;
Du=241.3;
Dv=503.8;
Dr=76.9;

Mx=m-X_udot;
My=m-Y_vdot;
Mpsi=Iz-N_rdot;
%==========================================================================
x = X(1);
y = X(2);
psi = X(3);
u = X(4);
v = X(5);
r = X(6);

xe = Xe(1);
ye = Xe(2);
psi_e = Xe(3);
ue = Xe(4);
ve = Xe(5);
re = Xe(6);

xr = P(1);
yr = P(2);
psi_r = P(3);
ur = P(4);
vr = P(5);
rr = P(6);
ur_dot = P(7);
vr_dot = P(8);
rr_dot = P(9);
%==========================================================================

f3 = (My-Mx)*u*v+Nr*r+Dr*r*abs(r)+Mpsi*rr_dot;


end

