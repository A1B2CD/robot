function [qdot_ref] = CLIK_pathFollowing(Jf, Jr, T_I_f, T_I_r, pf_ref, pr_ref)
%% TASK 1 - End-effector position
%Jf_pos = Jf(1:3,:);  %Position Jacobian
%Jf_pos_joints = Jf(1:3,7:end); %Only interested in solving for joint angle velocities
%J1 = Jf(1:3,7:end);
J1 = Jf(1:3,:);

pf_I = tform2trvec(T_I_f);

%Pseudo-Inverse
J1_inv = J1'/(J1*J1');

sigma_tilde_I = pf_ref - pf_I; %pf_ref is also in intertial coordinates, i.e pf_ref = pf_ref_I
R_I_f = tform2rotm(T_I_f);
sigma_tilde_f = R_I_f'*sigma_tilde_I;

k1 = [1 1 1]*0.5;
k1 = diag(k1);

%Full position Jacobian
zeta_ref = J1_inv * (zeros(3,1) + k1*sigma_tilde_f);
qdot_ref_f = [zeros(4,1); zeta_ref(7:end)];

%Only joint velocities
% qdot_ref = J1_inv * (zeros(3,1) + k1*sigma_tilde_f);
% qdot_ref_f = [zeros(4,1); qdot_ref];
%% TASK 2 - Rear end position
%Jb_pos = Jr(1:3,:);
J2 = Jr(1:3,:);
%J2 = Jr(1:3,7:end);

pr_I = tform2trvec(T_I_r);

%Pseudo-Inverse
J2_inv = J2'/(J2*J2');

sigma_tilde_I = pr_ref - pr_I;
R_I_r = tform2rotm(T_I_r);
sigma_tilde_r = R_I_r'*sigma_tilde_I;

k1 = [1 1 1]*0.5;
k1 = diag(k1);

%Full position Jacobian
zeta_ref = J2_inv * (zeros(3,1) - k1*sigma_tilde_r);
qdot_ref_r = [zeta_ref(10); zeta_ref(9); zeta_ref(8); zeta_ref(7); zeros(4,1)];

%Only joints
% qdot_ref = J2_inv * (zeros(3,1) - k1*sigma_tilde_r);
% qdot_ref_r = [qdot_ref(4); qdot_ref(3); qdot_ref(2); qdot_ref(1); zeros(4,1)];
%% Total
qdot_ref = qdot_ref_f + qdot_ref_r;
end