function plotUSMInEnvironment(obstacles, front, rear, base)
hold on;
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

hold off
end