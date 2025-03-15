function f1 = plot_thruster_actuation(u_thr, time, f1)
%% Plot accumulative thruster usage
n = length(u_thr);
u_thr_sum = zeros(n,1);
for i = 1:n
    u_thr_sum(i) = sum(abs(u_thr(i,:)));
end

figure(f1);

u_thr_sum_filtered = filter_data(u_thr_sum, 0.9);
plot(time, u_thr_sum_filtered, 'linewidth', 1);
grid on;

end


