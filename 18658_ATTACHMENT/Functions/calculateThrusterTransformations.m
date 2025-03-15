function [g_thrusters] = calculateThrusterTransformations(g_joints, num_thrusters, thruster_ax, thruster_pos, thruster_moduleNumber)

% Calculating the transformations from the back frame to the thruster
% frames
% From the tail module and forward




% THRUSTER FRAMES
g_thrusters = zeros(4,4,num_thrusters);

for i = 1:num_thrusters
    
    switch thruster_ax(i)
        case 1 %X
            g_joint2Thruster = [eye(3), thruster_pos(i,:)', zeros(1,3), 1];
        case 2 %Y
            g_joint2Thruster = [rotationZ(pi/2), thruster_pos(i,:)'; zeros(1,3), 1];
        case 3 %Z
            g_joint2Thruster = [rotationY(-pi/2), thruster_pos(i,:)'; zeros(1,3), 1];
        otherwise
            g_joint2Thruster = eye(4);
    end
    
    if thruster_moduleNumber(i) == 1
        g_thrusters(:,:,i) = g_joint2Thruster; 
    else
        g_thrusters(:,:,i) = g_joints(:,:,thruster_moduleNumber(i)-1) * g_joint2Thruster; 
    end
end

end



