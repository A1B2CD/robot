close all;
%% DATA
cd('..');
cd('sim_data');
load('multipleObstacles_1.mat');
cd('..');
cd('Analysis');

pf = data.pf;
pb = data.pb;
pr = data.pr;
time = data.time;
activeTask = data.activeTask;
comb = data.comb;
el = data.el;
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

%% OBSTACLES-------------------
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


%% Plot
            
%Figure parameters
label_font_size = 22;
axis_font_size = 18;
figpos = [972   483   603   387];
figposCM = [20 10 20 10];

%PLOT PATHS AND OBSTACLES
f1 = figure();
set(f1, 'color', 'white', 'Units', 'centimeters', 'Pos', [5 5 30 8]);
hold on;
grid on;

lightGrey = 0.8*[1 1 1];

%Plot USM

sec = 19; %[7 10 19 28 32 35]
t = 1;
for i = 1:length(time)
    if time(i) > sec
        t = i;
        break
    end
end

subplot(1,3,1)
plotUSMInEnvironment(obstacles, pf(t,:), pr(t,:), pb(t,:))
view([20 25]);
axis = [-10 -4; -3 3; -183 -177];
xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));
xlabel('x');
ylabel('y');
zlabel('z');
grid on

subplot(1,3,2)
plotUSMInEnvironment(obstacles, pf(t,:), pr(t,:), pb(t,:))
view([0 90]);
axis = [-10 -4; -3 3; -190 -170];
xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));

xlabel('x');
ylabel('y');
zlabel('z');
grid on

subplot(1,3,3)
c6 = Cylinder([c_circ + d_circ; -d_circ - 0.6; -180.1], [c_circ + d_circ; d_circ; -180.1], R_cyl);
c7 = Cylinder([c_circ; 0.1; -179], [c_circ - d_circ - 0.4; -d_circ - 0.4; -179], R_cyl);
c8 = Cylinder([c_circ - d_circ; -d_circ - 0.6; -181], [c_circ - d_circ; d_circ; -181], R_cyl);
obstacles = {c1, c2, c3, c4, c5, c6, c7, c8};
plotUSMInEnvironment(obstacles, pf(t,:), pr(t,:), pb(t,:))
view([0 0]);
axis = [-10 -4; -3 3; -183 -177];

xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));
xlabel('x');
ylabel('y');
zlabel('z');
grid on;


% %view([100 25]); %View 0
% %view([160 25]); %View 1
% %view([20 25]); %View 2
% %view([-20 25]); %View 3
% %view([200 25]); %View 4
% 
% view([0 90]); %View xy
% %view([0 0]); %View xz
% axis = [-16 3; -10 9; -190 -170];
% %axis = [-10 -4; -3 3; -190 -170];
% %axis = [-10 -4; -3 3; -183 -177];
% xlim(axis(1,:));
% ylim(axis(2,:));
% zlim(axis(3,:));
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% % xlabel('$x$', 'interpreter','latex', 'FontSize',label_font_size);
% % ylabel('$y$', 'interpreter','latex', 'FontSize',label_font_size);
% % zlabel('$z$', 'interpreter','latex', 'FontSize',label_font_size);