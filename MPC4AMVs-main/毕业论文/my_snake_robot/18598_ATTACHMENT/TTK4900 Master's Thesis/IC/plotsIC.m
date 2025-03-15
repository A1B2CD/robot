
figure()
subplot(311)
hold on
plot(pos_ee.Time,pos_ee.Data(:,1),'b','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,1),'b--','LineWidth',2)
plot(pos_ee.Time,pos_ee.Data(:,2),'r','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,2),'r--','LineWidth',2)
plot(pos_ee.Time,pos_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,3),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',2)
title('Impedance control: end-effector position and orientation $$\eta$$','interpreter','latex','fontsize',20)
legend({'x measured', 'x desired','y measured', 'y desired','z measured', 'z desired'},'interpreter','latex','fontsize',13)
hold off
xlabel('Time [s]','fontsize',14)
ylabel('End-effector position [m]','fontsize',14)
subplot(312)
hold on
plot(rot_ee.Time,rot_ee.Data(:,1),'b','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,4),'b--','LineWidth',2)
hold off
legend({'$\phi$ measured', '$\phi$ desired'},'interpreter','latex','fontsize',13)
xlabel('Time [s]','fontsize',14)
ylabel('Rotation [rad]','fontsize',14)
subplot(313)
hold on
plot(rot_ee.Time,rot_ee.Data(:,2),'r','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,5),'r--','LineWidth',2.4)
plot(rot_ee.Time,rot_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,6),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',2)
legend({'$\theta$ measured', '$\theta$ desired','$\psi$ measured', '$\psi$ desired'},'interpreter','latex','fontsize',13)
xlabel('Time [s]','fontsize',14)
ylabel('Rotation [rad]','fontsize',14)
hold off

piby4=pi/4*ones(length(valve_pos.Time),1);
figure()
hold on
plot(valve_pos.Time,valve_pos.Data,'b','LineWidth',2)
plot(valve_pos.Time,piby4,'k--','LineWidth',2)
legend({'Valve angle', '$\frac{\pi}{4}$'},'interpreter','latex','fontsize',14)
xlabel('Time [s]','fontsize',14)
ylabel('Valve rotation [rad]','fontsize',14)
title('Impedance control: Valve rotation','interpreter','latex','fontsize',20)
hold off
figure()

load('thrust.mat')
load('jt.mat')
jt_force=joint_torque;
joint_torque=jt;
thrust_force=thrust;
thrust=thr;

for i=1:9
    subplot(5,2,i)
    hold on
        plot(joint_torque.Time,joint_torque.Data(:,i),'b--','LineWidth',2)
        plot(jt_force.Time, jt_force.Data(:,i),'b','LineWidth',2)
    hold off
    s1='Joint ';
    s2=int2str(i);
    s=strcat(s1,s2);
    ylabel({s},'fontsize',14)
 
    if i==1
        title({'Applied joint torque with and without external force'},'interpreter','latex','fontsize',20)
    end
    if i==2
     legend({'$\tau_j$ only rotation', '$\tau_j$ turning valve'},'interpreter','latex','fontsize',14)
    end
    if i==8||i==9
           xlabel({'Time [s]'},'fontsize',14)
    end
   
end

figure()
title({'Applied thrust with and without external force'},'interpreter','latex','fontsize',20)
for i=1:10
    subplot(5,2,i)
    hold on
        plot(thrust.Time,thrust.Data(:,i),'b--','LineWidth',2)
        plot(thrust_force.Time, thrust_force.Data(:,i),'b','LineWidth',2)
    hold off
    s1='Thruster ';
    s2=int2str(i);
    s=strcat(s1,s2);
    ylabel({s},'fontsize',14)
     
   if i==1
   title({'Applied thrust with and without external force'},'interpreter','latex','fontsize',20)
   end
    if i==2
     legend({'$u_t$ only rotation', '$u_t$ turning valve'},'interpreter','latex','fontsize',14)
    end
    
    if i==9 || i==10
         xlabel({'Time [s]'},'fontsize',14)
    end
%     if i==2
%         ylim([-0.5 3.5])
%     elseif i==4
%         ylim([-1 1])
%     elseif i==8
%         ylim([-3 1])
%     elseif i==10
%     ylim([-2 2.5])
%     elseif i==10
%     ylim([-0.1 0.1])
%     else
%         ylim([-0.2 0.2])
%     end
end

figure()
subplot(211)
hold on
plot(force_ee.Time,force_ee.Data(:,1),'b','LineWidth',1.5)
plot(force_ee.Time,force_ee.Data(:,2),'r','LineWidth',2)
plot(force_ee.Time,force_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
hold off
xlabel('Time [s]','interpreter','latex','fontsize',16)
ylabel('Force [N]','interpreter','latex','fontsize',16)
legend({'Force at end-effector,\\ x-direction','Force at end-effector,\\ y-direction','Force at end-effector,\\ z-direction'},'interpreter','latex','fontsize',14)
title('Explicit force control: Force experienced by the end effector','interpreter','latex','fontsize',20)
subplot(212)
hold on
plot(force_ee.Time,force_ee.Data(:,4),'b','LineWidth',1.5)
plot(force_ee.Time,force_ee.Data(:,5),'r','LineWidth',2)
plot(force_ee.Time,force_ee.Data(:,6),'Color',[0, 0.5, 0],'LineWidth',1.5)
legend({'Moment at end-effector,\\ x-axis','Moment at end-effector,\\ y-axis','Moment at end-effector,\\ z-axis'},'interpreter','latex','fontsize',14)
xlabel('Time [s]','interpreter','latex','fontsize',16)
ylabel('Moment [Nm]','interpreter','latex','fontsize',16)
hold off

