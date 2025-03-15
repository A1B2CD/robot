%% OBSTACLES
%"Original"
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

% %ZIG-ZAG
% R_cyl = 0.5;
% R_ca = 0.5;
% c_start = [-5; -0.3; -180];
% h = [0; 0; 5];
% step = (R_cyl + R_ca)*2.5;
% c_rd = [-1;1;0]/norm([1;1;0])*step;
% c_ru = [-1;-1;0]/norm([1;1;0])*step;
% 
% c1 = Cylinder(c_start - h, c_start + h, R_cyl);
% c2 = Cylinder(c_start - h + c_rd, c_start + h + c_rd, R_cyl);
% c3 = Cylinder(c_start - h + c_rd + c_ru, c_start + h + c_rd + c_ru, R_cyl);
% obstacles = {c1, c2, c3};
% 
% c1_z = Cylinder(c_start - h, c_start + h, R_cyl + R_ca);
% c2_z = Cylinder(c_start - h + c_rd, c_start + h + c_rd, R_cyl + R_ca);
% c3_z = Cylinder(c_start - h + c_rd + c_ru, c_start + h + c_rd + c_ru, R_cyl + R_ca);
% ca_zones = {c1_z, c2_z, c3_z};

%% PLOT
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
    %z = ca_zones{i};
    %z.draw(1);
end


grid on;
%view([140 20]);
view([180 90]);
axis = [-20 3; -11 11; -190 -170];
xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));

xlabel('x');
ylabel('y');
zlabel('z');