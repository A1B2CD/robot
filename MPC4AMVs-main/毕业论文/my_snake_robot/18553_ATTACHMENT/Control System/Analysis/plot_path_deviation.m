function f = plot_path_deviation(deviation, time, f)
%% Plot total deviation

figure(f);

n = length(deviation);
dist = zeros(n,1);
for i = 1:n
    dist(i) = norm(deviation(i,:));
end

%dist = filter_data(dist, 2);

hold on;
plot(time, dist, 'linewidth', 1);
hold off;

end