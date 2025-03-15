function [g_thrusters] = calculateThrusterTransformations(g_joints, num_thrusters, thruster_ax, thruster_pos, thruster_moduleNumber)

% Calculating the transformations from the base frame to the thruster
% frames
% From the center module and outwards




% THRUSTER FRAMES
g_thrusters = zeros(4,4,num_thrusters);

for i = 1:num_thrusters
    
    switch thruster_ax(i)
        case 'X'
            g_joint2Thruster = [eye(3), thruster_pos(i,:)'; zeros(1,3), 1];
        case 'Y'
            g_joint2Thruster = [rotationZ(pi/2), thruster_pos(i,:)'; zeros(1,3), 1];
        case 'Z'
            g_joint2Thruster = [rotationY(-pi/2), thruster_pos(i,:)'; zeros(1,3), 1];
        otherwise
            g_joint2Thruster = [eye(3), thruster_pos(i,:)'; zeros(1,3), 1];
    end
        
    g_thrusters(:,:,i) = g_joints(:,:,thruster_moduleNumber(i)-1) * g_joint2Thruster;
end

% g1 = g_joints(:,:,1);
% g2 = g_joints(:,:,2);
% g3 = g_joints(:,:,3);
% g4 = g_joints(:,:,4);
% g5 = g_joints(:,:,5);
% g6 = g_joints(:,:,6);
% g7 = g_joints(:,:,7);
% g8 = g_joints(:,:,8);
% 
% t1 = g_thrusters(:,:,1);
% t2 = g_thrusters(:,:,2);
% t3 = g_thrusters(:,:,3);
% t4 = g_thrusters(:,:,4);
% t5 = g_thrusters(:,:,5);
% t6 = g_thrusters(:,:,6);
% t7 = g_thrusters(:,:,7);

end



