function [V_b_Ib_tilde, R_I_d] = WLOS(waypoints, T_I_b, V_b_Ib, delta)

%Keep track of which line segment to follow ---------------------
persistent activeWP;
if isempty(activeWP)
    activeWP = 1;
end

n_wp = size(waypoints,2);


pb_I = tform2trvec(T_I_b);
wpa = waypoints(1:3,activeWP + 1);
R_wp = waypoints(4,activeWP + 1);
diff = pb_I - wpa;
dist = norm(diff);
if dist <= R_wp && activeWP <= n_wp
    activeWP = activeWP + 1;
end

%LOS VECTOR -------------------------------------
wp1 = waypoints(1:3,activeWP);
wp2 = waypoints(1:3,activeWP + 1);
l = wp2 - wp1;
n = l/norm(l);
%Find shortest distance from base frame to desired path
d = (wp1 - pb_I) - ((wp1 - pb_I)'*n)*n; %Perpendicular vector from base to path
v_LOS_I = d + delta*n;

%LOS_dir = v_LOS_I;

%DESIRED ORIENTATION --------------------------------------
%R_I_d: Rotation matrix between inertial frame and desired frame
%Roll
alpha = pi;
Rx = rotationX(alpha);
R1 = Rx;
%Yaw
v_LOS_1 = R1'*v_LOS_I;
v_LOS_1_xy = [v_LOS_1(1); v_LOS_1(2); 0];
gamma = angleBetweenVectors(v_LOS_1_xy, [1; 0; 0])*pi/180;
    %Find direction of rotation
k = cross([1; 0; 0], v_LOS_1_xy);
Rz = rotationZ(gamma);
if k'*[0;0;-1] >= 0
    Rz = rotationZ(-gamma);
end
%Pitch
beta = angleBetweenVectors(v_LOS_1_xy, v_LOS_1)*pi/180;
    %Find direction of rotation
R2 = Rx*Rz;
v_LOS_2 = R2'*v_LOS_I;
v_LOS_2_xy = [v_LOS_2(1); v_LOS_2(2); 0];
k = cross(v_LOS_2_xy, v_LOS_2);
Ry = rotationY(beta);
if k'*[0;1;0] <= 0
    Ry = rotationY(-beta);
end

R_I_d = Rx*Rz*Ry;

%ROTATION ERROR -------------------------------------
R_I_b = tform2rotm(T_I_b);

R_tilde = R_I_b'*R_I_d; 
euler = rot2euler(R_tilde);

euler_tilde = [euler(1); euler(2); euler(3)];
u_ref = 0.3;
u_tilde = u_ref - V_b_Ib(1);

V_b_Ib_tilde = [u_tilde; 0; 0; euler_tilde];

end