function [g_thrusters] = calculateThrusterTransformations(g_joints, num_thrusters, thruster_rotation, thruster_pos, thruster_moduleNumber)

% Calculating the transformations from the back frame to the thruster
% frames
% From the tail module and forward




% THRUSTER FRAMES
g_thrusters = zeros(4,4,num_thrusters);

for i = 1:num_thrusters
    
    rotAngles = thruster_rotation(i,:);
    thruster_orientation = rotationZ(rotAngles(1))*rotationY(rotAngles(2));
   
    g_joint2Thruster = [thruster_orientation, thruster_pos(i,:)'; zeros(1,3), 1];
            
    g_thrusters(:,:,i) = g_joints(:,:,thruster_moduleNumber(i)-1) * g_joint2Thruster;
end

end



