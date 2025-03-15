function [g_joints, g_joints_home] = calculateJointTransformations(q, num_joints, joint_tr, joint_ax)

% Calculates the transformation matrices from 
% the USM base frame, F_b, to the joint frames F_i (i=1..n)
% From the center module and forward and from the center module and
% backward

base = 2;


% JOINT FRAMES
g_joints = zeros(4,4,num_joints);  
%[F1 F2 F3 F4 F5 F6 F7 F8]
g_joints_home = zeros(4,4,num_joints+2);  % size = num_joint+2 to include F_e and F_r
%[Fr F1 F2 F3 F4 F5 F6 F7 F8 Fe]

%Edit joint_tr lengths
joint_before_base = sum(joint_tr(1:2*base,1));
joint_after_base = sum(joint_tr(1:2*base + 1,1));
base_to_first_joint = [(joint_after_base - joint_before_base)/2 0 0];

joint_tr_forward = [base_to_first_joint; joint_tr(2*base + 2:end,:)];
joint_tr_backward = -1*[joint_tr(2:2*base,:); base_to_first_joint];

joint_ax_forward = joint_ax(2*base + 1:end);
joint_ax_backward = joint_ax(1:2*base);

q_forward = q(2*base + 1:end);
q_backward = q(1:2*base);

nf = num_joints - 2*base; %nr joints from base module and forward
nb = num_joints - nf; %nr joints from base module and backward
sf = 2*base; %Start index for frames from base module and forward

%Calculate transformations from base and forward
%Start at join nr 2*base + 1
for i = 1:nf
    if strcmp(joint_ax_forward(i),'Y')
        g_nextJoint = [rotationY(q_forward(i)), joint_tr_forward(i,:)'; zeros(1,3), 1];
        g_nextJoint_home = [eye(3), joint_tr_forward(i,:)'; zeros(1,3), 1];
    elseif strcmp(joint_ax_forward(i),'Z')
        g_nextJoint = [rotationZ(q_forward(i)), joint_tr_forward(i,:)'; zeros(1,3), 1];
        g_nextJoint_home = [eye(3), joint_tr_forward(i,:)'; zeros(1,3), 1];
    else
        g_nextJoint = eye(4);
        g_nextJoint_home = eye(4);
    end
    
    if i == 1
        g_joints(:,:,sf + i) = g_nextJoint;
        g_joints_home(:,:,sf + i + 1) = g_nextJoint_home; %add 1 to index because index 1 belongs to Fr
    else
        g_joints(:,:,sf + i) = g_joints(:,:,sf + i-1) * g_nextJoint;
        g_joints_home(:,:,sf + i + 1) = g_joints(:,:,sf + i-1) * g_nextJoint_home;       
    end
end

sb = num_joints - nf; %starting index for frames from base module and backwards
%Calculate transformations from base and backwards
for i = sb:-1:1
    if i == sb
        g_nextJoint = [eye(3), joint_tr_backward(i,:)'; zeros(1,3), 1];
        g_nextJoint_home = [rotationY(-q_backward(i)), joint_tr_backward(i,:)'; zeros(1,3), 1];
    else
        if strcmp(joint_ax_backward(i),'Y')
            g_nextJoint = [eye(3), joint_tr_backward(i,:)'; zeros(1,3), 1];
            g_nextJoint_home = [rotationY(-q_backward(i)), joint_tr_backward(i,:)'; zeros(1,3), 1];
        elseif strcmp(joint_ax_backward(i),'Z')
            g_nextJoint = [eye(3), joint_tr_backward(i,:)'; zeros(1,3), 1];
            g_nextJoint_home = [rotationZ(-q_backward(i)), joint_tr_backward(i,:)'; zeros(1,3), 1];
        end
    end
    
    if i == nb
        g_joints(:,:,i) = g_nextJoint;
        g_joints_home(:,:,i + 1) = g_nextJoint_home; %add 1 to index because index 1 belongs to Fr
    else
        g_joints(:,:,i) = g_joints_home(:,:,i+2) * g_nextJoint;
        g_joints_home(:,:,i + 1) = g_joints_home(:,:,i+2) * g_nextJoint_home;
    end

%Add first and last entry to g_joints_home
g_ne = [eye(3), joint_tr(end,:)'; zeros(1,3), 1];
g_joints_home(:,:,end) = g_joints(:,:,num_joints) * g_ne;


g_nr = [eye(3), -joint_tr(1,:)'; zeros(1,3), 1];
g_joints_home(:,:,1) = g_joints_home(:,:,2) * g_nr;

end



