
figure()
subplot(211)
hold on
plot(force_d.Time,force_d.Data(:,1),'b--','LineWidth',2)
plot(force.Time, -force.Data(:,1),'b','LineWidth',1.5)

title('Desired and applied force','fontsize',20)

legend({'$h_{ee,d}(1)$', '$h_{ee,m}(1)$'},'interpreter','latex','fontsize',14)
xlabel('Time [s]', 'fontsize',16)
ylabel('Torque [Nm]', 'fontsize',16)
hold off

subplot(212)
hold on
plot(force_d.Time,force_d.Data(:,4),'b--','LineWidth',2)
plot(force.Time, -force.Data(:,4),'b','LineWidth',1.5)

title('Desired and applied force','fontsize',20)

legend({'$h_{ee,d}(4)$', '$h_{ee,m}(4)$'},'interpreter','latex','fontsize',14)
xlabel('Time [s]', 'fontsize',16)
ylabel('Torque [Nm]', 'fontsize',16)
hold off

des=pi/4*ones(length(valve_pos.Time),1);
figure()
hold on
plot(valve_pos.Time,valve_pos.Data,'b','LineWidth',2)
plot(valve_pos.Time,des,'k--','LineWidth',1.5)
legend({'Valve rotation', 'Minimum desired valve rotation'},'interpreter','latex','fontsize',14)
title('Impedance and force control: valve rotation', 'fontsize',20)
xlabel('Time [s]', 'fontsize',16)
ylabel('Valve rotation [rad]', 'fontsize',16)
hold off

figure()
subplot(311)
hold on
plot(pos_ee.Time,pos_ee.Data(:,1),'b','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,1),'b--','LineWidth',2)
plot(pos_ee.Time,pos_ee.Data(:,2),'r','LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,2),'r--','LineWidth',2)
plot(pos_ee.Time,pos_ee.Data(:,3),'Color',[0, 0.5, 0],'LineWidth',1.5)
plot(eta_ee_d.Time, eta_ee_d.Data(:,3),'Color',[0, 0.5, 0],'LineStyle','--','LineWidth',2)
title('Force control and impedance control: end-effector position and orientation $$\eta_{ee}$$','interpreter','latex','fontsize',20)
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