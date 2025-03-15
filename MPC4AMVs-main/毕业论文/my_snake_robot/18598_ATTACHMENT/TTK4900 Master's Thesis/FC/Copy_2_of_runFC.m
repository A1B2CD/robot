%This is a simple smiulator for an underwater snake-like robot. The code is
%not optimized for speed and there may still be bugs. Please report back to
%me if you find anything fishy :)
%
%Henrik

%clc;
clear all
close all
%% Define Simulation Parameters
   Tmax          = 100;
   deltaT_interp = 1;                     %Time step size for the interpolated solution
    deltaT_sim=0.1;
   
    %snake.link_vec  = [2 2 2 2 2];         %The links the snake consists of, from head to tail
   %snake.joint_vec = [3 3 3 3]; 
   
   snake.link_vec  = [2 1 2 1 3 1 2 1 2 1];         %The links the snake consists of, from head to tail
   snake.joint_vec = [2 3 2 3 3 2 3 2 1]; 
%   snake.link_vec  = [2 1 2 1 3 1 2 1 2 1];         %The links the snake consists of, from head to tail
%    snake.joint_vec = [2 3 2 3 3 2 3 2 1];           %The type of joints, from head to tail
   snake.n         = length(snake.link_vec);
   snake.r         = 0.1;                   %Link radius
%    
      pos_init=[-0.02 (2*0.77*cos(pi/4)+1) 0];
   quat_init=eul2quat([0 0 pi],'XYZ');
   theta_init=[0 pi/4 0 pi/4 pi/4 0 pi/4 0 0];
 zeta_init=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
  x_init=[pos_init quat_init theta_init zeta_init]';


%      
%       pos_init=[0 (2*0.77*cos(pi/4)+1) 0]*0;
%    quat_init=[1 0 0 0];
%    theta_init=[0 pi/4 0 pi/4 pi/4 0 pi/4 0 0]*0;
%  zeta_init=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%   x_init=[pos_init quat_init theta_init zeta_init]';
%   
   y_0             = zeros(11+2*snake.n,1); %Initial conditions
   y_0(4)          = 1;                     %"zero" quaternion
%% Define Physical Parameters
pp.denw = 1000;         %density of water
pp.grav = 9.81;         %gravitational acceleration
pp.velc = [0 0 0]';    %constant irrotational current velocity, inertial frame
pp.gdir = [0 0 -1]';    %direction of gravity in inertial frame (pointing towards ground, unit vector

   C_a_C   =   1; % Added mass coefficient for the cross section, 1 is the theoretical inviscid result
   C_d_1   =  .2; % nonlinear drag coefficient in surge
   C_d_4   =  .1; % nonlinear drag coefficient in the roll direction for the cross-section
   C_d_C   =  .8; % nonlinear crossflow drag coefficient
   C_d_L   =  .1;% Linear cross-sectional drag coefficient
   alpha   =  .2; % Added mass ratio in surge/heave for a link
   beta    =  .1; % Linear drag parameter in surge
   gamma   =  .1; % Linear drag parameter in roll
   
   masscoeff = [C_a_C, alpha];
   dragcoeff = [C_d_1, C_d_4, C_d_C, C_d_L, beta, gamma];
   
%% Define Link Properties

%Link 1
link(1).name = '1';
link(1).length = .02;
link(1).mass = 0.1;
link(1).vol = link(1).mass/pp.denw;
link(1).r_grav = [0.5 0 0]'*link(1).length - [0 0 0.5]'*snake.r;
link(1).r_buoy = [0.5 0 0]'*link(1).length + [0 0 0]'*snake.r;
link(1).M_R  = RBmass(link(1).r_grav,snake.r,link(1).length,link(1).mass);
link(1).M_A  = slendermass(link(1).length,pp.denw,snake.r,masscoeff);
link(1).dragtype = 1;
link(1).n_thruster = 0;

%Link 2
link(2).name = '2';
link(2).length = .75;
link(2).vol = pi*link(2).length*snake.r^2;
link(2).mass = link(2).vol*pp.denw;
link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0.5]'*snake.r;
link(2).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;
link(2).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass);
link(2).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff);
link(2).dragtype = 2;
link(2).n_thruster = 2;
link(2).t_thrust     = [ [0 1 0]' [0 0 1]'];
link(2).r_thrust     = [ [0.5 0 0]' [0.5 0 0]']*link(2).length;

%Link 3
link(3).name = '3';
link(3).length = 1;
link(3).vol = pi*link(3).length*snake.r^2;
link(3).mass = link(3).vol*pp.denw;
link(3).r_grav = [0.5 0 0]'*link(3).length - [0 0 0.5]'*snake.r;
link(3).r_buoy = [0.5 0 0]'*link(3).length + [0 0 0]'*snake.r;
link(3).M_R  = RBmass(link(3).r_grav,snake.r,link(3).length,link(3).mass);
link(3).M_A  = slendermass(link(3).length,pp.denw,snake.r,masscoeff);
link(3).dragtype = 3;
link(3).n_thruster   = 2;
link(3).t_thrust     = [ [1 0 0]' [1 0 0]'];
link(3).r_thrust     = [ [0 1.5 0]' [0 -1.5 0]']*snake.r;
%% Define Joint Properties

%Joint 1
joint(1).name  = 'x revolute';
joint(1).twist = [0 0 0 1 0 0]';
joint(1).rot   = 1;%@(x)[1   0        0;
                   %   0  cos(x) -sin(x);
                   %   0  sin(x)  cos(x)];
%Joint 2
joint(2).name  = 'y revolute';
joint(2).twist = [0 0 0 0 1 0]';
joint(2).rot   = 2;%@(x)[ cos(x) 0  sin(x);
                    %   0      1  0;
                    %  -sin(x) 0  cos(x)];
%Joint 3
joint(3).name  = 'z revolute';
joint(3).twist = [0 0 0 0 0 1]';
joint(3).rot   = 3;%@(x)[cos(x) -sin(x)  0;
                    %  sin(x)  cos(x)  0;
                     % 0       0       1];
                     

%% Build Snake
m=0;
for i = 1 : snake.n
   %Build Links
   clink = link(snake.link_vec(i));
   snake.link(i).name   = clink.name;
   snake.link(i).length = clink.length;
   snake.link(i).M      = clink.M_R+clink.M_A;
   snake.link(i).M_A =clink.M_A;
   snake.link(i).M_R=clink.M_R;
   snake.link(i).dragtype   = clink.dragtype;
   snake.link(i).n_thruster = clink.n_thruster;
   
   w = clink.mass*pp.grav;
   b = clink.vol*pp.denw*pp.grav;
   snake.link(i).G = [(b-w)*eye(3); b*skew(clink.r_buoy)-w*skew(clink.r_grav)];
   
   m = m + clink.n_thruster;
   if clink.n_thruster > 0
   snake.link(i).B = [clink.t_thrust; cross(clink.r_thrust,clink.t_thrust)];
   else
   snake.link(i).B = zeros(6,2);
   end
   %Build Joints
   if i < snake.n
    cjoint = joint(snake.joint_vec(i));
    snake.joint(i).twist = cjoint.twist;
    snake.joint(i).type=cjoint.rot;
    %snake.joint(i).A     =@(x)[cjoint.Rot(x), [clink.length 0 0]';
   end                         %  [0 0 0 1]];

end
snake.n_thruster_tot = m;
clear w b clink cjoint m i C_a_C 

%% Controller

lambda_SM=1.2;
gamma_1=1;
epsilon=3;
omega_1=ones(14,1)*100;
alpha_m=0.1;
alphadot_0=zeros(14,1);
alphadot_not0=omega_1*sqrt(gamma_1/2);

%% Trajectory
M_d=eye(6)*4;
D_d=eye(6)*3;
G_d=eye(6)*0.5;

%% Valve

valve_pos=[0 0 0]';


%% AIDC

K_theta=diag([0.001, 0.00001, 0.0001, 0.1]);
K_P=blkdiag(eye(3),eye(3),eye(9)*30);
K_D=blkdiag(eye(3),eye(3),eye(9))*500;

Lambda=blkdiag(eye(3)*40,eye(3)*40,eye(9)*40);

estimate_init=[0 0 0 0]'; 

%% Impedance control

K_SI=diag([1 1 1 0.2 0.2 0.2])*30;
K_DI=diag([0.5 0.5 0.5 0.1 0.1 0.1])*2;
K_II=diag([0.2 0.2 0.2 0.15 0.15 0.15]*20);

K_FP=diag([1 1 1 0.2 0.2 0.2])/1.3;
K_FI=diag([0.5 0.5 0.5 0.3 0.1 0.1])/1.05;


%% Trajectory
M_d=eye(6)*4;
D_d=eye(6)*3;
G_d=eye(6)*0.5;

t=0 : deltaT_sim : Tmax;

    xe=[zeros(1,100) ((0:((pi/3.4-0)/(length(t)-400)):pi/3.4-(pi/3.4/(length(t)-400)))) pi/3.4*ones(1,300)];
    eta_ee_ref.signals.values=[ zeros(length(t),3) xe'   zeros(length(t),1)  zeros(length(t),1) ];
    eta_ee_ref.time=t;
    
%% Post Process/Show Movie


disp('Simulation started..')
    sim 'simFC2'
disp('Simulation finished...')
  %[T, simout]   = ode45(@(t,x)dyn(t,x,snake,pp,dragcoeff),[0 Tmax], y_0);





   Tinterp      = 0 : deltaT_interp : Tmax;
   T=x.Time;
   simout=x.Data;
   
   simout_int   = interp1(T,simout,Tinterp);
     [X, Y, Z]    = snake2points(simout_int,snake);
   
%   mov          = animatesnake(X,Y,Z,snake);
%    
%    
%    %boxdim = [-3 3 -3 3 -3 3];
%    %[~,~] = snakeplot(X(end,:),Y(end,:),Z(end,:),boxdim,true,snake,true,'on');
%    
%    fig = figure;
%    movie(fig,mov,50)  


%% Plots

% figure()
% subplot(811)
% plot(x.Time,x.Data(:,8),zeta_ref_int.Time,zeta_ref_int.Data(:,7))
% title('Joint angles')
% legend('Actual angle', 'Desired angle')
% subplot(812)
% plot(x.Time,x.Data(:,9),zeta_ref_int.Time,zeta_ref_int.Data(:,8))
% subplot(813)
% plot(x.Time,x.Data(:,10),zeta_ref_int.Time,zeta_ref_int.Data(:,9))
% subplot(814)
% plot(x.Time,x.Data(:,11),zeta_ref_int.Time,zeta_ref_int.Data(:,10))
% subplot(815)
% plot(x.Time,x.Data(:,12),zeta_ref_int.Time,zeta_ref_int.Data(:,11))
% subplot(816)
% plot(x.Time,x.Data(:,13),zeta_ref_int.Time,zeta_ref_int.Data(:,12))
% subplot(817)
% plot(x.Time,x.Data(:,14),zeta_ref_int.Time,zeta_ref_int.Data(:,13))
% subplot(818)
% plot(x.Time,x.Data(:,15),zeta_ref_int.Time,zeta_ref_int.Data(:,14))

figure()
subplot(611)
plot(zeta.Time,zeta.Data(:,1),zeta_ref.Time,zeta_ref.Data(:,1))
title('Zeta1')
legend('Zeta', 'zeta_ref')
subplot(612)
plot(zeta.Time,zeta.Data(:,2),zeta_ref.Time,zeta_ref.Data(:,2))
subplot(613)
plot(zeta.Time,zeta.Data(:,3),zeta_ref.Time,zeta_ref.Data(:,3))
subplot(614)
plot(zeta.Time,zeta.Data(:,4),zeta_ref.Time,zeta_ref.Data(:,4))
subplot(615)
plot(zeta.Time,zeta.Data(:,5),zeta_ref.Time,zeta_ref.Data(:,5))
subplot(616)
plot(zeta.Time,zeta.Data(:,6),zeta_ref.Time,zeta_ref.Data(:,6))



figure()
subplot(911)
plot(zeta.Time,zeta.Data(:,7),zeta_ref.Time,zeta_ref.Data(:,7))
title('Joint angular velocities')
legend('q_dot', 'q_dotref')
subplot(912)
plot(zeta.Time,zeta.Data(:,8),zeta_ref.Time,zeta_ref.Data(:,8))
subplot(913)
plot(zeta.Time,zeta.Data(:,9),zeta_ref.Time,zeta_ref.Data(:,9))
subplot(914)
plot(zeta.Time,zeta.Data(:,10),zeta_ref.Time,zeta_ref.Data(:,10))
subplot(915)
plot(zeta.Time,zeta.Data(:,11),zeta_ref.Time,zeta_ref.Data(:,11))
subplot(916)
plot(zeta.Time,zeta.Data(:,12),zeta_ref.Time,zeta_ref.Data(:,12))
subplot(917)
plot(zeta.Time,zeta.Data(:,13),zeta_ref.Time,zeta_ref.Data(:,13))
subplot(918)
plot(zeta.Time,zeta.Data(:,14),zeta_ref.Time,zeta_ref.Data(:,14))
subplot(919)
plot(zeta.Time,zeta.Data(:,15),zeta_ref.Time,zeta_ref.Data(:,15))

figure()

subplot(311)
plot(pos_ee.Time,pos_ee.Data(:,1),eta_ee_ref.time, eta_ee_ref.signals.values(:,1))
title('End-effector positions')
legend('Actual pos', 'Desired pos')
subplot(312)
plot(pos_ee.Time,pos_ee.Data(:,2), eta_ee_ref.time, eta_ee_ref.signals.values(:,2))
subplot(313)
plot(pos_ee.Time,pos_ee.Data(:,3), eta_ee_ref.time, eta_ee_ref.signals.values(:,3))

figure()
subplot(311)
plot(rot_ee.Time,rot_ee.Data(:,1),eta_ee_ref.time, eta_ee_ref.signals.values(:,4))
title('End-effector rotation in euler angles')
legend('Actual rot', 'Desired rot')
subplot(312)
plot(rot_ee.Time,rot_ee.Data(:,2),eta_ee_ref.time, eta_ee_ref.signals.values(:,5))
subplot(313)
plot(rot_ee.Time,rot_ee.Data(:,3),eta_ee_ref.time, eta_ee_ref.signals.values(:,6))

% figure()
% subplot(811)
% plot(d_est.Time,d_est.Data(:,1),d_actual.Time,d_actual.Data(:,1))
% title('D valus 1')
% legend('d_est', 'd act')
% subplot(812)
% plot(d_est.Time,d_est.Data(:,2),d_actual.Time,d_actual.Data(:,2))
% subplot(813)
% plot(d_est.Time,d_est.Data(:,3),d_actual.Time,d_actual.Data(:,3))
% subplot(814)
% plot(d_est.Time,d_est.Data(:,4),d_actual.Time,d_actual.Data(:,4))
% subplot(815)
% plot(d_est.Time,d_est.Data(:,5),d_actual.Time,d_actual.Data(:,5))
% subplot(816)
% plot(d_est.Time,d_est.Data(:,6),d_actual.Time,d_actual.Data(:,6))
% subplot(817)
% plot(d_est.Time,d_est.Data(:,7),d_actual.Time,d_actual.Data(:,7))
% subplot(818)
% plot(d_est.Time,d_est.Data(:,8),d_actual.Time,d_actual.Data(:,8))
% 
% figure()
% subplot(811)
% plot(d_est.Time,d_est.Data(:,9),d_actual.Time,d_actual.Data(:,9))
% title('D valus 2')
% legend('d_est', 'd act')
% subplot(812)
% plot(d_est.Time,d_est.Data(:,10),d_actual.Time,d_actual.Data(:,10))
% subplot(813)
% plot(d_est.Time,d_est.Data(:,11),d_actual.Time,d_actual.Data(:,11))
% subplot(814)
% plot(d_est.Time,d_est.Data(:,12),d_actual.Time,d_actual.Data(:,12))
% subplot(815)
% plot(d_est.Time,d_est.Data(:,13),d_actual.Time,d_actual.Data(:,13))
% subplot(816)
% plot(d_est.Time,d_est.Data(:,14),d_actual.Time,d_actual.Data(:,14))
% 
% figure()
% subplot(911)
% plot(q_act.Time,q_act.Data(:,1),q_ref.Time,q_ref.Data(:,1))
% title('Joint positions')
% legend('q', 'q_ref')
% subplot(912)
% plot(q_act.Time,q_act.Data(:,2),q_ref.Time,q_ref.Data(:,2))
% subplot(913)
% plot(q_act.Time,q_act.Data(:,3),q_ref.Time,q_ref.Data(:,3))
% subplot(914)
% plot(q_act.Time,q_act.Data(:,4),q_ref.Time,q_ref.Data(:,4))
% subplot(915)
% plot(q_act.Time,q_act.Data(:,5),q_ref.Time,q_ref.Data(:,5))
% subplot(916)
% plot(q_act.Time,q_act.Data(:,6),q_ref.Time,q_ref.Data(:,6))
% subplot(917)
% plot(q_act.Time,q_act.Data(:,7),q_ref.Time,q_ref.Data(:,7))
% subplot(918)
% plot(q_act.Time,q_act.Data(:,8),q_ref.Time,q_ref.Data(:,8))
% subplot(919)
% plot(q_act.Time,q_act.Data(:,9),q_ref.Time,q_ref.Data(:,9))
% 
% load('thrustF.mat')
% load('jtForce.mat')
% figure()
% subplot(521)
% plot(thrust_force.Time,thrust_force.Data(:,1),thrust.Time,thrust.Data(:,1))
% title('Thrust')
% legend('With force', 'Without force')
% ylabel('thrust 1')
% subplot(522)
% plot(thrust_force.Time,thrust_force.Data(:,2),thrust.Time,thrust.Data(:,2))
% ylabel('thrust 2')
% subplot(523)
% plot(thrust_force.Time,thrust_force.Data(:,3),thrust.Time,thrust.Data(:,3))
% ylabel('thrust 3')
% subplot(524)
% plot(thrust_force.Time,thrust_force.Data(:,4),thrust.Time,thrust.Data(:,4))
% ylabel('thrust 4')
% subplot(525)
% plot(thrust_force.Time,thrust_force.Data(:,5),thrust.Time,thrust.Data(:,5))
% ylabel('thrust 5')
% subplot(526)
% plot(thrust_force.Time,thrust_force.Data(:,6),thrust.Time,thrust.Data(:,6))
% ylabel('thrust 6')
% subplot(527)
% plot(thrust_force.Time,thrust_force.Data(:,7),thrust.Time,thrust.Data(:,7))
% ylabel('thrust 7')
% subplot(528)
% plot(thrust_force.Time,thrust_force.Data(:,8),thrust.Time,thrust.Data(:,8))
% ylabel('thrust 8')
% subplot(529)
% plot(thrust_force.Time,thrust_force.Data(:,9),thrust.Time,thrust.Data(:,9))
% ylabel('thrust 9')
% subplot(5,2,10)
% plot(thrust_force.Time,thrust_force.Data(:,10),thrust.Time,thrust.Data(:,10))
% ylabel('thrust 10')
% 
% figure()
% subplot(911)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,1),joint_torque.Time,joint_torque.Data(:,1))
% title('Joint torques')
% legend('With force', 'Without force')
% subplot(912)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,2),joint_torque.Time,joint_torque.Data(:,2))
% subplot(913)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,3),joint_torque.Time,joint_torque.Data(:,3))
% subplot(914)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,4),joint_torque.Time,joint_torque.Data(:,4))
% subplot(915)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,5),joint_torque.Time,joint_torque.Data(:,5))
% subplot(916)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,6),joint_torque.Time,joint_torque.Data(:,6))
% subplot(917)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,7),joint_torque.Time,joint_torque.Data(:,7))
% subplot(918)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,8),joint_torque.Time,joint_torque.Data(:,8))
% subplot(919)
% plot(joint_torque_with_force.Time,joint_torque_with_force.Data(:,9),joint_torque.Time,joint_torque.Data(:,9))
% 
% 
% figure()
% subplot(811)
% plot(M_est_part.Time,M_est_part.Data(:,1),M_act_part.Time,M_act_part.Data(:,1))
% title('M valus 1')
% legend('M_est', 'M act')
% subplot(812)
% plot(M_est_part.Time,M_est_part.Data(:,2),M_act_part.Time,M_act_part.Data(:,2))
% subplot(813)
% plot(M_est_part.Time,M_est_part.Data(:,3),M_act_part.Time,M_act_part.Data(:,3))
% subplot(814)
% plot(M_est_part.Time,M_est_part.Data(:,4),M_act_part.Time,M_act_part.Data(:,4))
% subplot(815)
% plot(M_est_part.Time,M_est_part.Data(:,5),M_act_part.Time,M_act_part.Data(:,5))
% subplot(816)
% plot(M_est_part.Time,M_est_part.Data(:,6),M_act_part.Time,M_act_part.Data(:,6))
% subplot(817)
% plot(M_est_part.Time,M_est_part.Data(:,7),M_act_part.Time,M_act_part.Data(:,7))
% subplot(818)
% plot(M_est_part.Time,M_est_part.Data(:,8),M_act_part.Time,M_act_part.Data(:,8))
% 
% figure()
% subplot(811)
% plot(M_est_part.Time,M_est_part.Data(:,9),M_act_part.Time,M_act_part.Data(:,9))
% title('M valus 2')
% legend('M_est', 'M act')
% subplot(812)
% plot(M_est_part.Time,M_est_part.Data(:,10),M_act_part.Time,M_act_part.Data(:,10))
% subplot(813)
% plot(M_est_part.Time,M_est_part.Data(:,11),M_act_part.Time,M_act_part.Data(:,11))
% subplot(814)
% plot(M_est_part.Time,M_est_part.Data(:,12),M_act_part.Time,M_act_part.Data(:,12))
% subplot(815)
% plot(M_est_part.Time,M_est_part.Data(:,13),M_act_part.Time,M_act_part.Data(:,13))
% subplot(816)
% plot(M_est_part.Time,M_est_part.Data(:,14),M_act_part.Time,M_act_part.Data(:,14))
% 

