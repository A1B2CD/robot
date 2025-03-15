close all;
%% DATA
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

%% ANIMATE USM TRAJECTORY
for t = 1:10:length(time)
    front = pf(t,:);
    base = pb(t,:);
    rear = pr(t,:);
    dynamicPlot(obstacles, front, base, rear);
    pause(0.02);
    %close all;
    disp(t)
end