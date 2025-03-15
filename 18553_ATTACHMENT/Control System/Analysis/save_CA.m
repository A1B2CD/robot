
%Position
data.pf = get(frontPosition, 'Data');
data.pb = get(basePosition, 'Data');
data.pr = get(rearPosition, 'Data');

%Time
data.time = get(frontPosition, 'Time');

%Velocitites
data.vf_I = get(frontVelocity, 'Data');
data.vb_I = get(baseVelocity, 'Data');
data.vb_I_angular = get(baseVelocityAngular, 'Data');

%Thruster
data.u_thr = get(thrusterForces, 'Data');
data.tau_cmd = get(tau_c, 'Data');
data.tau_cmd_uf = get(tau_c_unfiltered, 'Data');
data.tau_act = get(tau_actual, 'Data');

%Joint angles
data.q = get(jointAngles,'Data');


%Collision avoidance
%data.activeTask = get(activeTasks, 'Data');
%data.comb = get(combination, 'Data');
%data.el = get(eligible, 'Data');
data.V_f = get(frontVelocity, 'Data');

data.p_attract = [-25; 0; -180];
data.R = 1;

c1 = Cylinder([-15;-0.1;-185], [-15; -0.1; -175], 2);
data.obstacles = {c1};

cd('..');
cd('sim_data\CA');
save('multipleObstacles_1.mat', 'data');
cd('..');
cd('..');
cd('Analysis');