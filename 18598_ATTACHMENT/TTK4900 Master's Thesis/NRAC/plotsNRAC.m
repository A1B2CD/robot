figure()
subplot(211)
hold on
plot(pos_ee.Time,pos_ee.Data(:,1),'b','LineWidth',1.1)
plot(eta_ee_d.Time, eta_ee_d.Data(:,1),'b--','LineWidth',1.5)
plot(pos_ee.Time,pos_ee.Data(:,2),'r','LineWidth',1.1)
plot(eta_ee_d.Time, eta_ee_d.Data(:,2),'r--','LineWidth',1.5)
plot(pos_ee.Time,pos_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.1)
grid on
plot(eta_ee_d.Time, eta_ee_d.Data(:,3),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
title('Adaptive control: end-effector position and orientation $$\eta_{ee}$$','interpreter','latex','fontsize',20)
legend({'x measured', 'x desired','y measured', 'y desired','z measured', 'z desired'},'interpreter','latex','fontsize',14)
hold off

ylabel('End-effector position [m]','fontsize',16)
subplot(212)
hold on
plot(rot_ee.Time,rot_ee.Data(:,1),'b','LineWidth',1.1)
plot(eta_ee_d.Time, eta_ee_d.Data(:,4),'b--','LineWidth',1.5)
plot(rot_ee.Time,rot_ee.Data(:,2),'r','LineWidth',1.1)
plot(eta_ee_d.Time, eta_ee_d.Data(:,5),'r--','LineWidth',1.5)
plot(rot_ee.Time,rot_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.1)
grid on
plot(eta_ee_d.Time, eta_ee_d.Data(:,6),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
legend({'$\phi$ measured', '$\phi$ desired','$\theta$ measured', '$\theta$ desired','$\psi$ measured', '$\psi$ desired'},'interpreter','latex','fontsize',14)
xlabel('Time [s]','fontsize',16)
ylabel('Rotation [rad]','fontsize',16)
hold off

% figure()
% subplot(211)
% hold on
% plot(pos_ee.Time,pos_ee.Data(:,1),'b','LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,1),'b--','LineWidth',1.5)
% plot(pos_ee.Time,pos_ee.Data(:,2),'r','LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,2),'r--','LineWidth',1.5)
% plot(pos_ee.Time,pos_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,3),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% title('Non-regressor-based adaptive control - end-effector position and orientation $$\eta$$','interpreter','latex','fontsize',20)
% legend({'x measured', 'x desired','y measured', 'y desired','z measured', 'z desired'},'interpreter','latex','fontsize',14)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',16)
% ylabel('End-effector position [m]','interpreter','latex','fontsize',16)
% subplot(212)
% hold on
% plot(rot_ee.Time,rot_ee.Data(:,1),'b','LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,4),'b--','LineWidth',1.5)
% plot(rot_ee.Time,rot_ee.Data(:,2),'r','LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,5),'r--','LineWidth',1.5)
% plot(rot_ee.Time,rot_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(eta_ee_d.Time, eta_ee_d.Data(:,6),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% legend({'$\phi$ measured', '$\phi$ desired','$\theta$ measured', '$\theta$ desired','$\psi$ measured', '$\psi$ desired'},'interpreter','latex','fontsize',14)
% xlabel('Time [s]','interpreter','latex','fontsize',16)
% ylabel('Rotation [rad]','interpreter','latex','fontsize',16)
% hold off

% figure()
% subplot(311)
% hold on 
% plot(y_tilde.Time, y_tilde.Data(:,1),'b','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,2),'r','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
% hold off
% subplot(312)
% hold on 
% plot(y_tilde.Time, y_tilde.Data(:,4),'b','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,5),'r','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
% hold off
% subplot(313)
% hold on 
% plot(y_tilde.Time, y_tilde.Data(:,7),'b','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,8),'r','LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,9),'Color',[0, 0.5, 0],'LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,11),'Color',[0.4940, 0.1840, 0.5560],'LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,12),'Color',[0, 0.75, 0.75],'LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,13),'Color',	[0.8500, 0.3250, 0.0980],'LineWidth',1.5)
% plot(y_tilde.Time, y_tilde.Data(:,14),'Color',[0.25, 0.25, 0.25],'LineWidth',1.5)
% hold off

figure()
subplot(511)
plot(gamma_hat.Time, gamma_hat.Data(:,1),'b','LineWidth',1.5)
ylabel('$\hat{\theta}_1$','interpreter','latex','fontsize',20)
subplot(512)
plot(gamma_hat.Time, gamma_hat.Data(:,2),'b','LineWidth',1.5)
ylabel('$\hat{\theta}_2$','interpreter','latex','fontsize',20)
subplot(513)
plot(gamma_hat.Time, gamma_hat.Data(:,3),'b','LineWidth',1.5)
ylabel('$\hat{\theta}_3$','interpreter','latex','fontsize',20)
subplot(514)
plot(gamma_hat.Time, gamma_hat.Data(:,4),'b','LineWidth',1.5)
ylabel('$\hat{\theta}_4$','interpreter','latex','fontsize',20)
subplot(515)
plot(gamma_hat.Time, gamma_hat.Data(:,5),'b','LineWidth',1.5)
ylabel('$\hat{\theta}_5$','interpreter','latex','fontsize',20)
xlabel('Time [s]','fontsize',20)

sigma=y_tilde
zline=zeros(length(sigma.Time),1);
figure()
subplot(721)
hold on
plot(sigma.Time, sigma.Data(:,1),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_1$','interpreter','latex','fontsize',20)
title('Non-regressor-based adaptive: $\tilde{y}$','interpreter','latex','fontsize',20)

subplot(722)
hold on
plot(sigma.Time, sigma.Data(:,2),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_2$','interpreter','latex','fontsize',20)
legend({'$\tilde{y}$'},'interpreter','latex','fontsize',14)
subplot(723)
hold on
plot(sigma.Time, sigma.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_3$','interpreter','latex','fontsize',20)
subplot(724)
hold on
plot(sigma.Time, sigma.Data(:,4),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_4$','interpreter','latex','fontsize',20)
subplot(725)
hold on
plot(sigma.Time, sigma.Data(:,5),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_5$','interpreter','latex','fontsize',20)
subplot(726)
hold on
plot(sigma.Time, sigma.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_6$','interpreter','latex','fontsize',20)
subplot(727)
hold on
plot(sigma.Time, sigma.Data(:,7),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_7$','interpreter','latex','fontsize',20)
subplot(728)
hold on
plot(sigma.Time, sigma.Data(:,8),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_8$','interpreter','latex','fontsize',20)
subplot(729)
hold on
plot(sigma.Time, sigma.Data(:,9),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_9$','interpreter','latex','fontsize',20)
subplot(7,2,10)
hold on
plot(sigma.Time, sigma.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_{10}$','interpreter','latex','fontsize',20)
subplot(7,2,11)
hold on
plot(sigma.Time, sigma.Data(:,11),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{11}$','interpreter','latex','fontsize',20)
subplot(7,2,12)
hold on
plot(sigma.Time, sigma.Data(:,12),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{12}$','interpreter','latex','fontsize',20)
subplot(7,2,13)
hold on
plot(sigma.Time, sigma.Data(:,13),'Color',	[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14);ylabel('$\tilde{y}_{13}$','interpreter','latex','fontsize',20)
subplot(7,2,14)
hold on
plot(sigma.Time, sigma.Data(:,14),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{14}$','interpreter','latex','fontsize',20)
xlabel('Time [s]','fontsize',14)
hold off

%% Control input plots
figure()
joint_torque=tau_j;
load('adapcontroinput.mat')
for i=1:8
    subplot(4,2,i)
    hold on
        plot(joint_torque.Time,joint_torque.Data(:,i),'b','LineWidth',2)
        plot(tau_j_adap.Time,tau_j_adap.Data(:,i),'r--','LineWidth',2)
    hold off
    s1='Joint ';
    s2=int2str(i);
    sm=strcat(s1,s2);
    ylabel({sm},'fontsize',18)
   

    if i==2
        legend({'NRAC $u_J$','AIDC $u_J$'},'interpreter','latex','fontsize',20)
    end
    if i==7 || i==8
         xlabel({'Time [s]'},'fontsize',20)
    end
end

thrust=tau_t;
figure()
title({'Applied thrust with and without external force'},'interpreter','latex','fontsize',20)
for i=1:10
    subplot(5,2,i)
    hold on
        plot(thrust.Time,thrust.Data(:,i),'b','LineWidth',2)
        plot(tau_t_adap.Time,tau_t_adap.Data(:,i),'r--','LineWidth',2)
    hold off
    s1='Thruster ';
    s2=int2str(i);
    sm=strcat(s1,s2);
    ylabel({sm},'fontsize',18)

   if i==2
        legend({'NRAC $u_T$','AIDC $u_T$'},'interpreter','latex','fontsize',20)
   end
    if i==9 || i==10
         xlabel({'Time [s]'},'fontsize',20)
    end
end
%% S plot
figure()
subplot(721)
hold on
plot(s.Time, s.Data(:,1),'b','LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_1$','interpreter','latex','fontsize',20)
title('Non-regressor-based adaptive: $s$','interpreter','latex','fontsize',20)
subplot(722)
hold on
plot(s.Time, s.Data(:,2),'r','LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_2$','interpreter','latex','fontsize',20)
legend({'$s$'},'interpreter','latex','fontsize',14)
subplot(723)
hold on
plot(s.Time, s.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_3$','interpreter','latex','fontsize',20)
subplot(724)
hold on
plot(s.Time, s.Data(:,4),'b','LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_4$','interpreter','latex','fontsize',20)
subplot(725)
hold on
plot(s.Time, s.Data(:,5),'r','LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_5$','interpreter','latex','fontsize',20)
subplot(726)
hold on
plot(s.Time, s.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_6$','interpreter','latex','fontsize',20)
subplot(727)
hold on
plot(s.Time, s.Data(:,7),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_7$','interpreter','latex','fontsize',20)
subplot(728)
hold on
plot(s.Time, s.Data(:,8),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_8$','interpreter','latex','fontsize',20)
subplot(729)
hold on
plot(s.Time, s.Data(:,9),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_9$','interpreter','latex','fontsize',20)
subplot(7,2,10)
hold on
plot(s.Time, s.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$s_{10}$','interpreter','latex','fontsize',20)
subplot(7,2,11)
hold on
plot(s.Time, s.Data(:,11),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$s_{11}$','interpreter','latex','fontsize',20)
subplot(7,2,12)
hold on
plot(s.Time, s.Data(:,12),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$s_{12}$','interpreter','latex','fontsize',20)
subplot(7,2,13)
hold on
plot(s.Time, s.Data(:,13),'Color',	[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14);ylabel('$s_{13}$','interpreter','latex','fontsize',20)
subplot(7,2,14)
hold on
plot(s.Time, s.Data(:,14),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(s.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$s_{14}$','interpreter','latex','fontsize',20)
xlabel('Time [s]','fontsize',14)
hold off


