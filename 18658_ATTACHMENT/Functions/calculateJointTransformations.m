function [g_joints, g_joints_home] = calculateJointTransformations(q, num_joints, joint_tr, joint_ax)

% Calculates the transformation matrices from 
% the USM base frame, F_b = F_0, to the joint frames F_i (i=1..n)
% From the tail module and forward



% JOINT FRAMES
g_joints = zeros(4,4,num_joints);  
g_joints_home = zeros(4,4,num_joints+1);  % size = num_joint+1 to include F_e

for i = 1:num_joints
    if joint_ax(i) == 2 % Y
        g_nextJoint = [rotationY(q(i)), joint_tr(i,:)'; zeros(1,3), 1];
        g_nextJoint_home = [eye(3), joint_tr(i,:)'; zeros(1,3), 1];
    elseif joint_ax(i) == 3 % Z
        g_nextJoint = [rotationZ(q(i)), joint_tr(i,:)'; zeros(1,3), 1];
        g_nextJoint_home = [eye(3), joint_tr(i,:)'; zeros(1,3), 1];
    else
        g_nextJoint = eye(4);
        g_nextJoint_home = eye(4);
    end
    
    if i == 1
        g_joints(:,:,i) = g_nextJoint;
        g_joints_home(:,:,i) = g_nextJoint_home;
    else
        g_joints(:,:,i) = g_joints(:,:,i-1) * g_nextJoint;
        g_joints_home(:,:,i) = g_joints(:,:,i-1) * g_nextJoint_home;       
    end
end

g_ne = [eye(3), joint_tr(end,:)'; zeros(1,3), 1];
g_joints_home(:,:,end) = g_joints(:,:,num_joints) * g_ne;


end



