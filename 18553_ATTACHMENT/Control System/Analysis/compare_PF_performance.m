close all;

%% Load simulation data
cd('sim_data\wp_set_2');
data_set_1 = load('trial_1.mat');
data_set_2 = load('trial_2.mat');
cd('..');
cd('..');

sim_1 = data_set_1.sim;
sim_2 = data_set_2.sim;

%% Parameters
samplingPeriod = 0.0167;
dataStartingIndex = 5;%2000;
time_1 = sim_1.time(dataStartingIndex:end);
time_2 = sim_2.time(dataStartingIndex:end);

%% Synchronize data


%% Plot waypoints
h = figure(1);
world = [-45 5; -15 10; -185 -175];
%world = [-5 30; -30 3; -185 -175]; %Docking 
pathBetweenWP_visible = 1;
propertyName = {'MarkerFaceColor'};
propertyValue = {'b'};
h = plot_waypoints(sim_1.waypoints, pathBetweenWP_visible, world, h); 

% Plot USM path
propertyName = {'LineWidth', 'Color'};
propertyValue = {1, 'Blue'};
h = plot_USMpath(sim_1.pb_I, h, propertyName, propertyValue, dataStartingIndex, 0);
propertyName = {'LineWidth', 'Color'};
propertyValue = {1, 'Red'};
h = plot_USMpath(sim_2.pb_I, h, propertyName, propertyValue, dataStartingIndex, 0);
set(h, 'Color', 'White', 'Units', 'centimeters', 'Pos', [5 10 10 10]);
view([0 90])

%% Do calculations
[thrust_1, thrust_tot_1, thrust_contribution_1] = total_thruster_actuation(sim_1.u_thr, samplingPeriod, dataStartingIndex);
[thrust_2, thrust_tot_2, thrust_contribution_2] = total_thruster_actuation(sim_2.u_thr, samplingPeriod, dataStartingIndex);

[deviation_1, deviation_tot_1] = calculate_path_deviation(sim_1.waypoints, sim_1.pb_I, samplingPeriod, dataStartingIndex);
[deviation_2, deviation_tot_2] = calculate_path_deviation(sim_2.waypoints, sim_2.pb_I, samplingPeriod, dataStartingIndex);

[vel_1, vel_1_tot] = calculate_velocity(sim_1.vb_I, dataStartingIndex);
[vel_2, vel_2_tot] = calculate_velocity(sim_2.vb_I, dataStartingIndex);

%% Plot total thruster actuation
thrust_1_filtered = filter_data(thrust_1, 0.001);
thrust_2_filtered = filter_data(thrust_2, 0.001);

h2 = figure(2);
plot(time_1, thrust_1_filtered, 'linewidth', 1)
grid on;
hold on;
plot(time_2, thrust_2_filtered, 'linewidth', 1)
set(h2, 'Color', 'White', 'Units', 'centimeters', 'Pos', [2 2 20 10]);
legend('C. C. disabled', 'C. C. active');

%% Plot path deviation

h3 = figure(3);
h3 = plot_path_deviation(deviation_1, time_1, h3);
h3 = plot_path_deviation(deviation_2, time_2, h3);
grid on;
set(h3, 'Color', 'White', 'Units', 'centimeters', 'Pos', [2 2 20 10]);
legend('C. C. disabled', 'C. C. active');

%% Plot velocity

%Surge
h4 = figure(4);
h4 = plot_velocity(vel_1(:,1), time_1, h4);
h4 = plot_velocity(vel_2(:,1), time_2, h4);
grid on;
set(h4, 'Color', 'White', 'Units', 'centimeters', 'Pos', [20 2 14 7]);

%Total

h5 = figure(5);
h5 = plot_velocity(vel_1_tot, time_1, h5);
h5 = plot_velocity(vel_2_tot, time_2, h5);
grid on;
set(h5, 'Color', 'White', 'Units', 'centimeters', 'Pos', [20 2 14 7]);




