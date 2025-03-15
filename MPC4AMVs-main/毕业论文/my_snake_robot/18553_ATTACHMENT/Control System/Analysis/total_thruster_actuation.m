function [thrust, thrust_tot, thrust_contribution] = total_thruster_actuation(u_thr, samplingTime, index)

u_thr = abs(u_thr(index:end,:));
n = length(u_thr);
u_thr_sum = zeros(1,7);
u_thr_tot = zeros(n, 1);
for i = 1:n
    u_thr_tot(i) = sum(u_thr(i,:));
end
u_thr_sum(1:end) = sum(u_thr(:,1:end)); %Total actuation on each thruster

thrust = u_thr_tot;
thrust_tot = sum(u_thr_sum)*samplingTime;
thrust_contribution = u_thr_sum*samplingTime./thrust_tot;

end