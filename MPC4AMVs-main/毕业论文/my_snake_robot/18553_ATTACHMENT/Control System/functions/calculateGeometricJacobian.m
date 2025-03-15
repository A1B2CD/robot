function J_geometric_body = calculateGeometricJacobian(g_joints_home, num_joints, bodyTwists)
%#codegen

J_manipulator = calculateManipulatorJacobian(num_joints,g_joints_home,bodyTwists);

g_be = g_joints_home(:,:,end);  % Transformation from base frame to end-effector frame
Ad_be_inv = calculateAdjointInverse(g_be);

J_geometric_body = [Ad_be_inv, Ad_be_inv * J_manipulator];

end