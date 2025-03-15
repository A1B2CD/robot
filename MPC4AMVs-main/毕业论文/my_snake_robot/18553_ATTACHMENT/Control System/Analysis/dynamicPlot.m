function dynamicPlot(obstacles, front, base, rear)

% Sets figure properties
window = figure(1);

% Indicates that the erasing and redrawing of a rendering occurs off-screen
% to avoid flickering
set(window, 'DoubleBuffer', 'on');
clf

% Sets the background color.
set(window, 'color', 'white');
hold on;
%grid on;

%Colors
cf = 'b';
cb = [0/255 200/255 0/255];
cr = [255/255 153/255 0/255];
ca = 'r';

%linewidths
pathLW = 1;

%Plot obstacles
nObst = numel(obstacles);
for i = 1:nObst
    o = obstacles{i};
    o.draw(0);
    %z = ca_zones{i}.draw(1);
end

%Plot USM
%Body
plot3([rear(1) base(1) front(1)],[rear(2) base(2) front(2)], [rear(3) base(3) front(3)], 'k', 'linewidth', pathLW);
%CAPs
scatter3(front(1), front(2), front(3), 'filled', 'MarkerFaceColor', cf);
scatter3(base(1), base(2), base(3), 'filled', 'MarkerFaceColor', cb);
scatter3(rear(1), rear(2), rear(3), 'filled', 'MarkerFaceColor', cr);

%view([100 25]); %View 0
%view([160 25]); %View 1
%view([20 25]); %View 2
view([30 25]); %View 3
%view([200 25]); %View 4
%view([0 90]); %View xy
%view([0 0]); %View xz
axis = [-16 3; -10 9; -190 -170];
%axis = [-10 -4; -3 3; -190 -170];
%axis = [-10 -4; -3 3; -183 -177];
xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));

xlabel('x');
ylabel('y');
zlabel('z');

hold off
end