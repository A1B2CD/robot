function f = plot_USMpath(pb_I, f, name, value, index, filter)

pb_I = pb_I(index:end, :);

%Remove measurement errors
n = length(pb_I);
tol = 0.05;
dist = zeros(n,1);
for i = 1:n
    dist(i) = norm(pb_I(i,:));
end
for i = 1:n-1
    if abs(dist(i) - dist(i+1)) > tol
        pb_I(i + 1,:) = pb_I(i,:);
    end
end

figure(f);
hold on;
p = plot3(pb_I(:,1), pb_I(:,2), pb_I(:,3), 'k', 'linewidth', 1);
set(p, name, value);
scatter3(pb_I(1,1), pb_I(1,2), pb_I(1,3), 'filled', 'MarkerFaceColor','red');
scatter3(pb_I(end,1), pb_I(end,2), pb_I(end,3), 'filled', 'MarkerFaceColor','green');
hold off;

end