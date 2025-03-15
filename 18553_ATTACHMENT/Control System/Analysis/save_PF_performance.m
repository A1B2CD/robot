%% Extract data from timeseries
%Description
sim.description = "u_ref = 0.3, Cf_front = 0.3, Cf_back  = 0.3";
%Position
sim.pb_I = get(basePosition, 'Data');
sim.pf_I = get(frontPosition, 'Data');
sim.pr_I = get(rearPosition, 'Data');

sim.pf_I_ref = get(frontPosition_ref, 'Data');
sim.pr_I_ref = get(rearPosition_ref, 'Data');

%Orientation
sim.R_I_d = get(R_I_d_measured, 'Data');

%Velocitites
sim.vf_I = get(frontVelocity, 'Data');
sim.vb_I = get(baseVelocity, 'Data');
sim.vb_I_angular = get(baseVelocityAngular, 'Data');

%Thruster
sim.u_thr = get(thrusterForces, 'Data');
sim.tau_cmd = get(tau_c, 'Data');
sim.tau_cmd_uf = get(tau_c_unfiltered, 'Data');
sim.tau_act = get(tau_actual, 'Data');

%Time
sim.time = get(thrusterForces,'Time');

%Joint angles
sim.q = get(jointAngles,'Data');

%Pathfollowing
%sim.u_tilde = get(u_tilde_measured, 'Data');
%sim.euler_tilde = get(orientationError_euler, 'Data');

%Controller gains
sim.Ke_D = Ke_D;
sim.Ke_P = Ke_P;

%Waypoints
sim.waypoints = waypoints;

cd('..')
cd('sim_data/PF');
save('test_1.mat', 'sim');
cd('..');
cd('..');
cd('Analysis');