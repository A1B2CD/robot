function [ g_If,R_If,eta_f,g_Ib,R_Ib,eta_b,q,g_joints_home,g_moduleCM,g_thrusters ] = calculateTransformations( q1, q2, eta_marker, g_marker2front, controlCenterLink )
%#codegen

modelParams = coder.load('eely_params.mat');


num_joints = modelParams.num_joints;
num_modules = modelParams.num_modules;
num_thrusters = modelParams.num_thrusters;

module_cm = modelParams.module_cm;
joint_tr = modelParams.joint_tr;
joint_ax = modelParams.joint_ax;

thruster_ax = modelParams.thruster_ax;
thruster_pos = modelParams.thruster_pos;
thruster_moduleNumber = modelParams.thruster_moduleNumber;



% [EELY] Specific code for Eely
% Measured: Position and Euler angles for the markers, eta_marker
R_marker = Rzyx(eta_marker(4),eta_marker(5),eta_marker(6));
g_marker = [R_marker, eta_marker(1:3); zeros(1,3), 1];
g_If = g_marker * g_marker2front;

p_If_I = g_If(1:3,4);
R_If = g_If(1:3,1:3);
eta_f = [p_If_I; rot2euler(R_If)];


% Code to convert the joint angle inputs q1 and q2 from the Eely robot
% to the definition used in this code by reorganizing the vector elements.
q = [q2(4),q1(4),q2(3),q1(3),q2(2),q1(2),q2(5),q1(5)]';
q = q * pi/180;


%% TRANSFORMATIONS

% Calculate the sequential transformations from base frame to the joint
% frames
[g_joints, g_joints_home] = calculateJointTransformations(q, num_joints, joint_tr, joint_ax);

% Calculate transformations for the CM of each module
[g_moduleCM] = calculateModuleTransformations(g_joints, num_modules, module_cm);

% Calculate transformations for the thrusters
[g_thrusters] = calculateThrusterTransformations(g_joints, num_thrusters, thruster_ax, thruster_pos, thruster_moduleNumber);

% Calculate the transformation from the front end to the back end
g_front2back = calculateTransformationInverse(g_joints_home(1:4,1:4,num_joints+1));


% Transformation from inertial frame to base frame
if controlCenterLink
    % Calculate the transformation from the back end to the center module
    % (module number 5)
    g_back2center = g_moduleCM(1:4,1:4,5);
    g_center2back = calculateTransformationInverse(g_back2center);
    
    g_Ib = g_If * g_front2back * g_back2center;
    for i = 1:num_thrusters
        g_thrusters(1:4,1:4,i) = g_center2back * g_thrusters(1:4,1:4,i);
    end
    for i = 1:num_modules
        g_moduleCM(1:4,1:4,i) = g_center2back * g_moduleCM(1:4,1:4,i);
    end
    for i = 1:num_joints+1
        g_joints_home(1:4,1:4,i) = g_center2back * g_joints_home(1:4,1:4,i);
    end
else
    g_Ib = g_If * g_front2back;
end

p_Ib_I = g_Ib(1:3,4);
R_Ib = g_Ib(1:3,1:3);
eta_b = [p_Ib_I; rot2euler(R_Ib)];

end

