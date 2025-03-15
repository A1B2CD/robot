close all;

cd('..');
cd('sim_data\CA');
load('multipleObstacles_1.mat');
cd('..');
cd('..');
cd('Analysis');

pf = data.pf;
pb = data.pb;
pr = data.pr;
time = data.time;
%activeTask = data.activeTask;
%comb = data.comb;
%el = data.el;
V_f = data.V_f;
%u_thr = data.u_thr;

%Colors
cf = 'b';
cb = [0/255 200/255 0/255];
cr = [255/255 153/255 0/255];
ca = 'r';

%linewidths
pathLW = 1;

%p_attract = data.p_attract;
p_attract = [-15; 0; -180];

%OBSTACLES-------------------
%c1 = Cylinder([-15;-0.1;-185], [-15; -0.1; -175], 2);
%obstacles = {c1};

% b1 = Box([-5;-5;-185],[-15;5;-185],[-15;5;-175],1);
% b2 = Box([-15;5;-185], [-20;5;-185], [-20;5;-175],1);
% c1 = Cylinder([-17.5;5;-185], [-17.5; 5; -175], 2);
% obstacles = {b1,b2,c1};
%Obstacle course --------------
%Standing
R_cyl = 0.5;
d_circ = sqrt(2);
c_circ = -7;
c1 = Cylinder([c_circ + d_circ; -d_circ; -185], [c_circ + d_circ; -d_circ; -175], R_cyl);
c2 = Cylinder([c_circ + d_circ; d_circ; -185], [c_circ + d_circ; d_circ; -175], R_cyl);

c3 = Cylinder([c_circ; 0.1; -185], [c_circ; 0.1; -175], R_cyl);

c4 = Cylinder([c_circ - d_circ; -d_circ; -185], [c_circ - d_circ; -d_circ; -175], R_cyl);
c5 = Cylinder([c_circ - d_circ; d_circ; -185], [c_circ - d_circ; d_circ; -175], R_cyl);
%Cross
c6 = Cylinder([c_circ + d_circ; -d_circ; -180.1], [c_circ + d_circ; d_circ; -180.1], R_cyl);
c7 = Cylinder([c_circ; 0.1; -179], [c_circ - d_circ; -d_circ + 0.1; -179], R_cyl);
c8 = Cylinder([c_circ - d_circ; -d_circ; -181], [c_circ - d_circ; d_circ; -181], R_cyl);

obstacles = {c1, c2, c3, c4, c5, c6, c7, c8};
%----------------------------

%PROCESS DATA
% - Find timesteps where a task is active
% n_active = sum(activeTask(:,4));
% activePlot = zeros(n_active, 4);
% activeDist = zeros(n_active, 1);
% t = 4;
% counter = 1;
% for i = 1:size(activeTask,1)
%     if activeTask(i,t) == 1
%         activePlot(counter,1) = time(i);
%         activePlot(counter,2:end) = pr(i,:);
%         activeDist(counter) = obstacles{1}.distanceTo(pr(i,:)');
%         counter = counter + 1;
%     end
% end
% % - Find lines to show the situation where the CA task is deactivated
% attractLine = [activePlot(end,2) p_attract(1);
%                 activePlot(end,3) p_attract(2); 
%                 activePlot(end,4) p_attract(3)];
% p_surf = obstacles{1}.closestSurfacePointTo(activePlot(end,2:end)');
% obstacleLine = [activePlot(end,2) p_surf(1);
%                 activePlot(end,3) p_surf(2); 
%                 activePlot(end,4) p_surf(3)];

% - Find distance from CAP to obstacle surface
n = size(pf,1);
distanceToObstacle = ones(n, 3)*Inf;
n_obst = numel(obstacles);
for i = 1:n
    for j = 1:n_obst
        o = obstacles{j};
        if o.distanceTo(pf(i,:)') < distanceToObstacle(i,1)
            distanceToObstacle(i,1) = o.distanceTo(pf(i,:)');
        end
        if o.distanceTo(pb(i,:)') < distanceToObstacle(i,2)
            distanceToObstacle(i,2) = o.distanceTo(pb(i,:)');
        end
        if o.distanceTo(pr(i,:)') < distanceToObstacle(i,3)
            distanceToObstacle(i,3) = o.distanceTo(pr(i,:)');
        end
    end
end

% - Calculate total thruster usage
% startIndex = 1;
% samplingTime = 0.01666;
% [thrust, thrust_tot, thrust_contribution] = total_thruster_actuation(u_thr, samplingTime, startIndex);

%% Plot
            
%Figure parameters
label_font_size = 22;
axis_font_size = 18;
figpos = [972   483   603   387];
figposCM = [20 10 20 10];

%PLOT PATHS AND OBSTACLES
f1 = figure();
set(f1, 'color', 'white', 'Units', 'centimeters', 'Pos', [15 5 15 11]);
hold on;
grid on;

lightGrey = 0.8*[1 1 1];

%Plot obstacles
nObst = numel(obstacles);
for i = 1:nObst
    o = obstacles{i};
    o.draw(0);
    %z = ca_zones{i}.draw(1);
end

%Plot 2D circle
x0 = -15;
y0 = -0.1;
r = 4;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x0;
yunit = r * sin(th) + y0;
zunit = ones(1,length(th))*-180;
%h = plot3(xunit, yunit, zunit);

%Plot paths
plot3(pf(:,1), pf(:,2), pf(:,3), 'color', cf, 'linewidth', pathLW)
plot3(pb(:,1), pb(:,2), pb(:,3), 'color', cb, 'linewidth', pathLW)
plot3(pr(:,1), pr(:,2), pr(:,3), 'color', cr, 'linewidth', pathLW)

%Plot part of path where CA is active
%plot3(activePlot(:,2),activePlot(:,3), activePlot(:,4), ca, 'linewidth', pathLW);
% plot3(attractLine(1,:), attractLine(2,:), attractLine(3,:), 'linewidth', 1);
% plot3(obstacleLine(1,:), obstacleLine(2,:), obstacleLine(3,:), 'linewidth', 1);

%Plot starting points and attraction point
t = 1;
scatter3(pf(t,1), pf(t,2), pf(t,3), 'filled', 'MarkerFaceColor', cf);
scatter3(pb(t,1), pb(t,2), pb(t,3), 'filled', 'MarkerFaceColor', cb);
scatter3(pr(t,1), pr(t,2), pr(t,3), 'filled', 'MarkerFaceColor', cr);
scatter3(p_attract(1), p_attract(2), p_attract(3), 'filled', ca);

grid on;
%view([100 25]); %View 0
%view([160 25]); %View 1
%view([20 25]); %View 2
%view([-20 25]); %View 3
%view([200 25]); %View 4

%view([0 90]); %View xy
view([0 0]); %View xz
axis = [-16 3; -10 9; -190 -170];
%axis = [-10 -4; -3 3; -190 -170];
%axis = [-10 -4; -3 3; -183 -177];
xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));

xlabel('x');
ylabel('y');
zlabel('z');
% xlabel('$x$', 'interpreter','latex', 'FontSize',label_font_size);
% ylabel('$y$', 'interpreter','latex', 'FontSize',label_font_size);
% zlabel('$z$', 'interpreter','latex', 'FontSize',label_font_size);

% f2 = figure();
% plot(time, V_f(:,1));
% hold on;
% plot(time, dist)
% plot(time, ones(1,length(time))*1.5);
% ylim([0 5]);
% plot(time, comb_active);
% hold on;
% plot(time, dist);
% ylim([0 2.5]);

% %PLOT ACTIVE TASKS
% f3 = figure();
% subplot(3,1,1)
% plot(time, activeTask(:,1));
% ylim([0 2]);
% 
% subplot(3,1,2);
% plot(time, activeTask(:,2));
% ylim([0 2]);
% 
% subplot(3,1,3);
% plot(time, activeTask(:,4));
% hold on;
% %plot(time, activeTask(:,2));
% ylim([0 2]);
% 
% %PLOT DISTANCE TO OBSTACLE
% f4 = figure();
% hold on;
% grid on;
% set(f4, 'Color', 'White', 'Units', 'centimeters', 'Pos', [5 5 30 11]);
% xlabel('Time [s]');
% ylabel('$\sigma_{CA,e}$', 'interpreter','latex');
% r_ca = 0.5;
% 
% subplot(3,1,1);
% hold on;
% plot(time, distanceToObstacle(:,1), 'color', cf, 'linewidth', pathLW);
% %plot(activePlot(:,1), activeDist, 'color', ca, 'linewidth', pathLW);
% plot(time, ones(1,length(time))*r_ca, '--r');
% xlabel('Time [s]');
% ylabel('$\sigma_{CA,e}$', 'interpreter','latex');
% ylim([0 3]);
% 
% subplot(3,1,2);
% hold on;
% plot(time, distanceToObstacle(:,2), 'color', cb, 'linewidth', pathLW);
% %plot(activePlot(:,1), activeDist, 'color', ca, 'linewidth', pathLW);
% plot(time, ones(1,length(time))*r_ca, '--r');
% xlabel('Time [s]');
% ylabel('$\sigma_{CA,b}$', 'interpreter','latex');
% ylim([0 3]);
% 
% subplot(3,1,3);
% hold on;
% plot(time, distanceToObstacle(:,3), 'color', cr, 'linewidth', pathLW);
% %plot(activePlot(:,1), activeDist, 'color', ca, 'linewidth', pathLW);
% plot(time, ones(1,length(time))*r_ca, '--r');
% xlabel('Time [s]');
% ylabel('$\sigma_{CA,r}$', 'interpreter','latex');
% ylim([0 3]);

%PLOT THRUSTER ACTUATION
% f5 = figure();
% hold on;
% grid on;
% set(f5, 'Color', 'White', 'Units', 'centimeters', 'Pos', [15 5 13 10]);
% plot(time, u_thr);
