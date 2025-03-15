function f = plot_waypoints(waypoints, path_visible, axis, f)

%Plot waypoints
figure(f);
scatter3(waypoints(1,:), waypoints(2,:), waypoints(3,:), 'filled');
hold on;
xlabel('x')
ylabel('y')
zlabel('z')

if path_visible == 1
    plot3(waypoints(1,:), waypoints(2,:), waypoints(3,:), 'linewidth', 0.5);
end

xlim(axis(1,:));
ylim(axis(2,:));
zlim(axis(3,:));

end