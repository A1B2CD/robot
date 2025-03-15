function [pf_ref, pr_ref] = configurationController(R_I_d, T_I_b, cf)

L_r = 1.8;%1.775; %Length from base to rear when USM is straigt;
L_f = 1.6;%1.525; %Length from base to front when USM is straight;
pb_I = tform2trvec(T_I_b); %Vector from intertial frame to base frame expressed in intertial frame
R_I_b = tform2rotm(T_I_b);

%% Desired end-effector position
%AIM the front part of the USM along a vector rotated from base-x towards
%the LOS vector
pf_d_b = [L_f; 0; 0]; %Syntax: pointfront_{desired}^baseframe
pf_d_I = R_I_b*pf_d_b;
e1 = [1;0;0];
vLOS_I = R_I_d*e1;

theta = angleBetweenVectors(pf_d_I,vLOS_I)*pi/180;
k_I = cross(vLOS_I,pf_d_I);
k_I = k_I/norm(k_I);
curve_angle = cf*theta;
max_angle = 45*pi/180;
if curve_angle > max_angle
    curve_angle = max_angle;
end
q = [cos(curve_angle/2); sin(curve_angle/2)*k_I];

coder.extrinsic('quatrotate')
pf_rot_I = pf_d_I';
pf_rot_I = quatrotate(q',pf_d_I');
pf_ref = pb_I + pf_rot_I';

%% Desired rear-end position
%LOS vector based steering
pr_b = [-L_r; 0; 0];
pr_I = R_I_b*pr_b;
q = [cos(-curve_angle/2); sin(-curve_angle/2)*k_I];

pr_rot_I = pr_I';
pr_rot_I = quatrotate(q',pr_I');
pr_ref = pb_I + pr_rot_I';

end