function [M, M_V, M_qV, M_q] = calculateInertiaMatrixFull(g_joints_home, g_moduleCM, num_joints, bodyTwists, mass, momentOfInertia, addedMass, addedInertia)
%#codegen

% Calculates the full inertia matrix (M) about the common origin (base
% frame) defined by the transformations in g_moduleCM


M = zeros(6+num_joints,6+num_joints);

J_manipulator = calculateManipulatorJacobian(num_joints,g_joints_home,bodyTwists);


for i = 0:num_joints
    % Including also the first link (link 0)
    Ad_bi_inv = calculateAdjointInverse(g_moduleCM(:,:,i+1));
    J_i = [J_manipulator(:,1:i), zeros(6,num_joints-i)];
    J_gi = [Ad_bi_inv, Ad_bi_inv*J_i];
    
    M_i = diag([mass(i+1)*ones(1,3)+addedMass(i+1,:), momentOfInertia(i+1,:)+addedInertia(i+1,:)]);
    
    M = M + J_gi' * M_i * J_gi;
end

M_V = M(1:6,1:6);
M_qV = M(7:end,1:6);
M_q = M(7:end,7:end);

end

