function [V_b_Ib_ref, qdot_ref] = CLIK_collisionAvoidance(T_I_f, T_I_b, T_I_r, obstacleSurfacePoints, Jf, Jb, Jr)
p_I_f = tform2trvec(T_I_f);
p_I_b = tform2trvec(T_I_b);
p_I_r = tform2trvec(T_I_r);

R_I_f = tform2rotm(T_I_f);
R_I_b = tform2rotm(T_I_b);
R_I_r = tform2rotm(T_I_r);

%% Define tasks
%NormTask: A task variable that tries to keep the norm between two points
%at a certain value
%CONSTRUCTOR: NormTask(Set-based task, sigma_des, gain, weighting matrix)
%sigma_des = 0 => The USM will move towards this point
%sigma_des = k => The USM will keep a distance k from this point
persistent tasks;
persistent CA_r;
persistent Position_r;
if isempty(tasks)
    k_CA = 3;
    k_pos = 1;
    distance_CA = 0.5;
    distance_pos = 0;
    W = [1 1 1 1 1 1 1 1 1 1]; %6 base velocities + 4 joint angles

    CA_f = NormTask(1,distance_CA,k_CA,W);
    CA_b = NormTask(1,distance_CA,1,W);
    CA_r = NormTask(1,distance_CA,k_CA,W);
    
    Position_f = NormTask(0,distance_pos,k_pos,W);
    Position_b = NormTask(0,distance_pos,k_pos,W);
    Position_r = NormTask(0,distance_pos,k_pos,W);
    
    tasks = {CA_f, CA_b, Position_f};
    %tasks = {Position_f};
end
dim = 10; %(6 base vel + 4 joints)
p_attract = [-15; 0; -180]; %THIS IS THE GOAL POSITION FOR THE END-EFFECTOR
%% Update tasks
%Extract position Jacobian
Jf_pos = Jf(1:3,:);
Jb_pos = Jb(1:3,:);
Jr_pos = Jr(1:3,:);
Jr_pos_joints = Jr(1:3,7:end);

%Get closest ostacle surface point
p_obst_f = obstacleSurfacePoints(:,1);
p_obst_b = obstacleSurfacePoints(:,2);
p_obst_r = obstacleSurfacePoints(:,3);

%Calculate task errors and find the task jacobian
p_attract_f = p_I_f + (p_attract - p_I_f)/norm(p_attract - p_I_f);%Normalise to get const. vel
p_attract_b =  p_I_b + (p_attract - p_I_b)/norm(p_attract - p_I_b);
p_attract_r =  p_I_r + (p_attract - p_I_r)/norm(p_attract - p_I_r);

tasks{1}.update(Jf_pos, p_obst_f, p_I_f, R_I_f, p_attract_f);
tasks{3}.update(Jf_pos, p_attract_f, p_I_f, R_I_f, p_attract_f);

tasks{2}.update(Jb_pos, p_obst_b, p_I_b, R_I_b, p_attract_b);

%Rear tasks
CA_r.update(Jr_pos_joints, p_obst_r, p_I_r, R_I_r, p_attract_r);
Position_r.update(Jr_pos,[3;3;-180],p_I_r,R_I_r,p_attract_r);
%% Calculate system velocities
activeTasks = determineActiveTasks(tasks);
Q = multipleTaskCLIK(tasks, activeTasks, dim);
zeta_ref = Q(:,1);

%CA for the rear
if CA_r.Active == 1
    qr = CA_r.J_inv*(0 + CA_r.Gain*CA_r.Sigma_tilde);
else
    qr = zeros(dim,1);
end


V_b_Ib_ref = zeta_ref(1:6);
qdot_ref = [qr(4); qr(3); qr(2); qr(1); zeta_ref(7:end)];

end