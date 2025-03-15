function f1 = plot_thruster_actuation_separate(u_thr, time, f1)
%% Plot thruster usage
%u_thr description:
% thruster 1 - back vertical, positive force down
% thruster 2 - back horizontal, positive force right (starboard)
% thruster 3 - longitudinal left side (port), positive force forward
% thruster 4 - longitudinal right side (starboard), positive force forward
% thruster 5 - center vertical, positive force down
% thruster 6 - front horizontal, positive force right (starboard)
% thruster 7 - front vertical, positive force down

%Filter out noisy data
f1 = figure(f1);
% u_thr_filtered = u_thr;
% d = fdesign.lowpass('Fp,Fst,Ap,Ast',3,5,0.5,40,100);
% Hd = design(d,'equiripple');
% for i = 1:7
%     u_thr_filtered(:,i) = filter_data(u_thr(:,i), 0.2);
%     %u_thr_filtered(:,i) = filter(Hd, u_thr(:,i));
% end
plot(time, u_thr(:,:), 'linewidth', 1);
grid on;
legend('back vertical', 'back horizontal', 'forward left', 'forward right', ...
    'center vertical', 'front horizontal', 'front vertical');

end