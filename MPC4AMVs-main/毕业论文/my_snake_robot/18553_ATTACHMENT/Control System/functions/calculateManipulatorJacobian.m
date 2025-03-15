function J_manipulator_spatial = calculateManipulatorJacobian(num_joints, g_joints_home, bodyTwists)
%#codegen

% g_joints_home are the homogeneous transformations from the base frame Fb to the
% frame of joint i at home position Fi(q_i=0)
% bodyTwists is the 6xn-1 matrix of n-1 column vectors respresenting the body
% joint twists of each joint, i.e. defining the local (body) axis of translation
% (prismatic) or local (body) axis of rotation (revolute) of the joint


J_manipulator_spatial = zeros(6,num_joints);

for i = 1:num_joints
    Ad_joints_home = calculateAdjoint(g_joints_home(:,:,i));
    J_manipulator_spatial(:,i) = Ad_joints_home*bodyTwists(:,i);
end

end