load('d_est05.mat')
load('d_actual05.mat')

figure()
subplot(8,2,1)
subplot(8,2,2)
legend({ '$D_{est}$, $\theta$=original','$D_{actual}$, $\theta$=original','$D_{est}$, $\theta$=0.5','$D_{actual}$, $\theta$=0.5' },'interpreter','latex','fontsize',14)
subplot(8,2,3)
hold on
plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)

hold off
grid on
ylabel('$D_1$','interpreter','latex','fontsize',20)


for j=4:16
    i=j-2;
    subplot(8,2,j)
    hold on
    plot(d_est.Time,d_est.Data(:,i),'b','LineWidth',1.1)
    plot(d_actual.Time,d_actual.Data(:,i),'b--','LineWidth',1.5)
    plot(d_est_05.Time,d_est_05.Data(:,i),'Color',[0, 0.5, 0],'LineWidth',1.1)
    plot(d_act_05.Time,d_act_05.Data(:,i),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
    hold off
    grid on
    if i==2
    legend({ '$D_{est}$, $\theta$=original','$D_{actual}$, $\theta$=original','$D_{est}$, $\theta$=0.5','$D_{actual}$, $\theta$=0.5' },'interpreter','latex','fontsize',14)
    end
    
    if i==13 || i==14
    xlabel('Time [s]','fontsize',14)
    end
    number=int2str(i);
    ylab1=strcat('$D_{',number);
    ylab2=strcat(ylab1,'}$');
    ylabel({ylab2},'interpreter','latex','fontsize',20)
end


% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% 
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_2$','interpreter','latex','fontsize',14)
% subplot(423)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_3$','interpreter','latex','fontsize',14)
% subplot(424)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_4$','interpreter','latex','fontsize',14)
% subplot(425)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_5$','interpreter','latex','fontsize',14)
% subplot(426)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_6$','interpreter','latex','fontsize',14)
% subplot(427)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_7$','interpreter','latex','fontsize',14)
% subplot(428)
% hold on
% plot(d_est.Time,d_est.Data(:,1),'b','LineWidth',1.1)
% plot(d_actual.Time,d_actual.Data(:,1),'b--','LineWidth',1.5)
% plot(d_est_05.Time,d_est_05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
% plot(d_act_05.Time,d_act_05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
% hold off
% xlabel('Time [s]','interpreter','latex','fontsize',14)
% ylabel('$D_8$','interpreter','latex','fontsize',14)


load('dragconstant05.mat')
load('dragconstant05line.mat')
figure
subplot(411)
hold on

plot(dragconstant0.Time,dragconstant0.Data(:,1),'b','LineWidth',1.1)
plot(dragconstantline.Time,dragconstantline.Data(:,1),'b--','LineWidth',1.5)
plot(dragconst05.Time,dragconst05.Data(:,1),'Color',[0, 0.5, 0],'LineWidth',1.1)
plot(dragconstline05.Time,dragconstline05.Data(:,1),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
grid on


hold off

ylabel('$C_{d,1}$','interpreter','latex','fontsize',20)
legend({'$\hat{\theta}$,$\theta_{act}$=original','$\theta$, $\theta_{act}$=original', '$\hat{\theta}$, $\theta_{act}$=0.5','$\theta$, $\theta_{act}$=0.5'},'interpreter','latex','fontsize',14)
subplot(412)
hold on
plot(dragconstant0.Time,dragconstant0.Data(:,2),'b','LineWidth',1.1)
plot(dragconstantline.Time,dragconstantline.Data(:,2),'b--','LineWidth',1.5)
plot(dragconst05.Time,dragconst05.Data(:,2),'Color',[0, 0.5, 0],'LineWidth',1.1)
plot(dragconstline05.Time,dragconstline05.Data(:,2),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
grid on
hold off

ylabel('$C_{d,4}$','interpreter','latex','fontsize',20)
subplot(413)
hold on
plot(dragconstant0.Time,dragconstant0.Data(:,3),'b','LineWidth',1.1)
plot(dragconstantline.Time,dragconstantline.Data(:,3),'b--','LineWidth',1.5)
plot(dragconst05.Time,dragconst05.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.1)
plot(dragconstline05.Time,dragconstline05.Data(:,3),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
grid on
hold off

ylabel('$C_{d,C}$','interpreter','latex','fontsize',20)
subplot(414)
hold on
plot(dragconstant0.Time,dragconstant0.Data(:,4),'b','LineWidth',1.1)
plot(dragconstantline.Time,dragconstantline.Data(:,4),'b--','LineWidth',1.5)
plot(dragconst05.Time,dragconst05.Data(:,4),'Color',[0, 0.5, 0],'LineWidth',1.1)
plot(dragconstline05.Time,dragconstline05.Data(:,4),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',1.5)
grid on
hold off
xlabel('Time [s]','interpreter','latex','fontsize',14)
ylabel('$C_{d,L}$','interpreter','latex','fontsize',20)

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

%% Sjekk hva jeg egneltig plotter
zline=zeros(length(sigma.Time),1);
figure()
subplot(721)
hold on
plot(sigma.Time, sigma.Data(:,1),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_1$','interpreter','latex','fontsize',16)


subplot(722)
hold on
plot(sigma.Time, sigma.Data(:,2),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_2$','interpreter','latex','fontsize',16)
legend({'$\tilde{y}$'},'interpreter','latex','fontsize',14)
subplot(723)
hold on
plot(sigma.Time, sigma.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_3$','interpreter','latex','fontsize',16)
subplot(724)
hold on
plot(sigma.Time, sigma.Data(:,4),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_4$','interpreter','latex','fontsize',16)
subplot(725)
hold on
plot(sigma.Time, sigma.Data(:,5),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_5$','interpreter','latex','fontsize',16)
subplot(726)
hold on
plot(sigma.Time, sigma.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_6$','interpreter','latex','fontsize',16)
subplot(727)
hold on
plot(sigma.Time, sigma.Data(:,7),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_7$','interpreter','latex','fontsize',16)
subplot(728)
hold on
plot(sigma.Time, sigma.Data(:,8),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_8$','interpreter','latex','fontsize',16)
subplot(729)
hold on
plot(sigma.Time, sigma.Data(:,9),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_9$','interpreter','latex','fontsize',16)
subplot(7,2,10)
hold on
plot(sigma.Time, sigma.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$\tilde{y}_{10}$','interpreter','latex','fontsize',16)
subplot(7,2,11)
hold on
plot(sigma.Time, sigma.Data(:,11),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ; ylabel('$\tilde{y}_{11}$','interpreter','latex','fontsize',16)
subplot(7,2,12)
hold on
plot(sigma.Time, sigma.Data(:,12),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ; ylabel('$\tilde{y}_{12}$','interpreter','latex','fontsize',16)
subplot(7,2,13)
hold on
plot(sigma.Time, sigma.Data(:,13),'Color',	[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14); ylabel('$\tilde{y}_{13}$','interpreter','latex','fontsize',16)
subplot(7,2,14)
hold on
plot(sigma.Time, sigma.Data(:,14),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14); ylabel('$\tilde{y}_{14}$','interpreter','latex','fontsize',16)
xlabel('Time [s]','fontsize',14)
hold off

%% S plot
zline=zeros(length(sigma.Time),1);
figure()
subplot(721)
hold on
plot(sigma.Time, sigma.Data(:,1),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_1$','interpreter','latex','fontsize',20)


subplot(722)
hold on
plot(sigma.Time, sigma.Data(:,2),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_2$','interpreter','latex','fontsize',20)

subplot(723)
hold on
plot(sigma.Time, sigma.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_3$','interpreter','latex','fontsize',20)
subplot(724)
hold on
plot(sigma.Time, sigma.Data(:,4),'b','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_4$','interpreter','latex','fontsize',20)
subplot(725)
hold on
plot(sigma.Time, sigma.Data(:,5),'r','LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_5$','interpreter','latex','fontsize',20)
subplot(726)
hold on
plot(sigma.Time, sigma.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_6$','interpreter','latex','fontsize',20)
subplot(727)
hold on
plot(sigma.Time, sigma.Data(:,7),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_7$','interpreter','latex','fontsize',20)
subplot(728)
hold on
plot(sigma.Time, sigma.Data(:,8),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_8$','interpreter','latex','fontsize',20)
subplot(729)
hold on
plot(sigma.Time, sigma.Data(:,9),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_9$','interpreter','latex','fontsize',20)
subplot(7,2,10)
hold on
plot(sigma.Time, sigma.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ; ylabel('$s_{10}$','interpreter','latex','fontsize',20)
subplot(7,2,11)
hold on
plot(sigma.Time, sigma.Data(:,11),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ; ylabel('$s_{11}$','interpreter','latex','fontsize',20)
subplot(7,2,12)
hold on
plot(sigma.Time, sigma.Data(:,12),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ; ylabel('$s_{12}$','interpreter','latex','fontsize',20)
subplot(7,2,13)
hold on
plot(sigma.Time, sigma.Data(:,13),'Color',	[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14); ylabel('$s_{13}$','interpreter','latex','fontsize',20)
subplot(7,2,14)
hold on
plot(sigma.Time, sigma.Data(:,14),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(sigma.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14); ylabel('$s_{14}$','interpreter','latex','fontsize',20)
xlabel('Time [s]','fontsize',14)
hold off

zline=zeros(length(y_tilde.Time),1);
figure()
subplot(721)
hold on
plot(y_tilde.Time, y_tilde.Data(:,1),'b','LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_1$','interpreter','latex','fontsize',20)


subplot(722)
hold on
plot(y_tilde.Time, y_tilde.Data(:,2),'r','LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_2$','interpreter','latex','fontsize',20)
legend({'$\tilde{y}$'},'interpreter','latex','fontsize',14)
subplot(723)
hold on
plot(y_tilde.Time, y_tilde.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_3$','interpreter','latex','fontsize',20)
subplot(724)
hold on
plot(y_tilde.Time, y_tilde.Data(:,4),'b','LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_4$','interpreter','latex','fontsize',20)
subplot(725)
hold on
plot(y_tilde.Time, y_tilde.Data(:,5),'r','LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_5$','interpreter','latex','fontsize',20)
subplot(726)
hold on
plot(y_tilde.Time, y_tilde.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_6$','interpreter','latex','fontsize',20)
subplot(727)
hold on
plot(y_tilde.Time, y_tilde.Data(:,7),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_7$','interpreter','latex','fontsize',20)
subplot(728)
hold on
plot(y_tilde.Time, y_tilde.Data(:,8),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_8$','interpreter','latex','fontsize',20)
subplot(729)
hold on
plot(y_tilde.Time, y_tilde.Data(:,9),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_9$','interpreter','latex','fontsize',20)
subplot(7,2,10)
hold on
plot(y_tilde.Time, y_tilde.Data(:,10),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)
grid on; hold off;  ylabel('$\tilde{y}_{10}$','interpreter','latex','fontsize',20)
subplot(7,2,11)
hold on
plot(y_tilde.Time, y_tilde.Data(:,11),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{11}$','interpreter','latex','fontsize',20)
subplot(7,2,12)
hold on
plot(y_tilde.Time, y_tilde.Data(:,12),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{12}$','interpreter','latex','fontsize',20)
subplot(7,2,13)
hold on
plot(y_tilde.Time, y_tilde.Data(:,13),'Color',	[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)

grid on; hold off; xlabel('Time [s]','fontsize',14);ylabel('$\tilde{y}_{13}$','interpreter','latex','fontsize',20)
subplot(7,2,14)
hold on
plot(y_tilde.Time, y_tilde.Data(:,14),'Color',[0.9290, 0.6940, 0.1250],'LineWidth',1.5)
plot(y_tilde.Time, zline,'k--','LineWidth',0.5)

grid on; hold off;  ylabel('$\tilde{y}_{14}$','interpreter','latex','fontsize',20)
xlabel('Time [s]','fontsize',14)
hold off



