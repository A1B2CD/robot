close all;

%% Load simulation data
cd('..');
cd('sim_data\PF');
load('trial_1.mat');
cd('..');
cd('..');
cd('Analysis');

%% Parameters
label_font_size = 22;
axis_font_size = 18;

samplingPeriod = 0.0167;
dataStartingIndex = 5;
time = sim.time(dataStartingIndex:end);
%% Analyse energy efficiency
[thrust, thrust_tot, thrust_contribution] = total_thruster_actuation(sim.u_thr, samplingPeriod, dataStartingIndex);

%% Analyse path convergance
[deviation, deviation_tot] = calculate_path_deviation(sim.waypoints, sim.pb_I, samplingPeriod, dataStartingIndex);

%% Plot waypoints
h = figure(1);
world = [-45 5; -15 10; -185 -175];
%world = [-5 30; -30 5; -185 -175]; %Spiral 1
%world = [-25 15; -5 25; -185 -175]; %Spiral 2
%world = [-30 30; -30 30; -185 -175]; %Spiral common
%world = [-25 15; -5 25; -185 -165]; %Spiral 2, 3D
pathBetweenWP_visible = 1;
h = plot_waypoints(sim.waypoints(:,1:end), pathBetweenWP_visible, world, h); 

% Plot USM path
propertyName = {'LineWidth', 'Color'};
propertyValue = {1, 'Blue'};
h = plot_USMpath(sim.pb_I, h, propertyName, propertyValue, dataStartingIndex, 0);
set(h, 'Color', 'White', 'Units', 'centimeters', 'Pos', [5 10 12 10]); %x: 18 wide, 12 square
view([0 90])

%% Plot deviation
h2 = figure(2);
h2 = plot_path_deviation(deviation, time, h2);
grid on;
set(h2, 'Color', 'White', 'Units', 'centimeters', 'Pos', [20 10 20 10]);
xlabel('Time [s]', 'interpreter','latex')%,'FontSize',label_font_size);
ylabel('norm($\mathbf{d}$) [m]', 'interpreter','latex')%,'FontSize',label_font_size);

%% Plot thruster actuation
%Total
h3 = figure(3);
thrust_filtered = filter_data(thrust, 0.001);
%hold on
%h3 = plot_thruster_actuation(thrust, time, h3);
h3 = plot_thruster_actuation(thrust_filtered, time, h3);

grid on;
set(h3, 'Color', 'White', 'Units', 'centimeters', 'Pos', [2 2 20 10]);
xlabel('Time [s]', 'interpreter','latex');
ylabel('Force [N]', 'interpreter','latex');

%% Separate
h4 = figure(4);
u_thr_filtered = zeros(size(thrust,1),7);
for i = 1:7
    u_thr_filtered(:,i) = filter_data(sim.u_thr(dataStartingIndex:end, i), 0.005);
end
%h4 = plot_thruster_actuation_separate(sim.u_thr(dataStartingIndex:end, 4), time, h4);
%hold on
h4 = plot_thruster_actuation_separate(u_thr_filtered(:,:), time, h4);

grid on;
set(h4, 'Color', 'White', 'Units', 'centimeters', 'Pos', [2 2 20 10]);
xlabel('Time [s]', 'interpreter','latex');
ylabel('Force [N]', 'interpreter','latex');

%% Display data in console
thrust_tot
deviation_tot