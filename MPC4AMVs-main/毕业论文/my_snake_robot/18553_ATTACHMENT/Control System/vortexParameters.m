%This script contains parameters that are needed for Simulink to have the
%same world view as Vortex throughout simulation

%=========================================================================
% Constant transformations
%=========================================================================
% UPDATE IF THE MEASUREMENT POINTS IN THE VORTEX MODEL HAS BEEN MODIFIED

%T_a_b is a homogenous transformation matrix from frame a to frame b
%i.e: v_a = T_a_b*v_b;

%Transformation between chosen world intertial frame and Vortex' inertial
%frame
T_I_vx = eye(4); %vx = vortex inertial frame

%Constant transformation from a frame which can be measured in Vortex to a
%desired frame. 
%Ex: Vortex has placed the body frame of the front link of the USM at the
%link's center of mass. The transformation from this body frame to a frame
%on the front of the front link is constant.
T_head_front = [rotationX(pi), zeros(3,1); zeros(1,3), 1];
T_tail_back = [rotationZ(pi) * rotationX(pi), [0.105,0,0]'; zeros(1,3), 1];
T_cm_cb = [rotationX(pi), [0.09 0 0]'; zeros(1,3), 1]; %Center module/link to desired base location, "center base"

%=========================================================================
% Initial values
%=========================================================================
%These values depend on the position, orientation and configuration of the
%USM in VORTEX at SIMULATION START

%Initial joint angles
q_IC = zeros(1,8);%3*[4, 0, -4, 0, 4, 0, -4, 0]*pi/180;

T_vx_cm_IC = [rotationZ(pi), [0.240, 0, -180]'; zeros(1,3),1]; %Transform from Vortex world intertial frame to center module/link body frame

%TRANSFORMATIONS THAT DEPEND ON THE INITIAL JOINT ANGLES
T_vx_head_IC = [rotationZ(pi), [-1.371,0,-180]'; zeros(1,3), 1]; %T_vortexInertialFrame_head_InitialConditions
T_vx_tail_IC = [eye(3), [1.817,0,-180]'; zeros(1,3), 1];


T_I_f_IC = T_I_vx * T_vx_head_IC * T_head_front; %T_Inertial_front_IC
T_I_b_IC = T_I_vx * T_vx_cm_IC * T_cm_cb; %T_Inertial_back_IC


