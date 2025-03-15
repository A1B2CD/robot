function out = A_HT(j,theta_j,snake)
%This function computes the homogene transformasjonsmatrisen for joint j 
joint_type = snake.joint(j).Rot;
R = Rot(joint_type,theta_j);
out     = [R, snake.joint(j).length;
         [0 0 0 1]];
end


% CHECK WHAT IDA HAS DONE WITH JOINT.LENGTH