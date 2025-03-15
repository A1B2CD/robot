%data:    2025/1/6 -------
%author :  Jiang chaohui
%   for underwater snake robot
% robot :  8 thrustors  8  duoji  5link 


clear all
close all


%%  仿真参数

Tmax          = 100;
deltaT_interp = 1;                     %Time step size for the interpolated solution
deltaT_sim=0.1;
%  base 在尾  单向排序                1 2 3 4 5 6 7 8 9 10
% snake.link_vec  = [2 1 3 1 4 1 5 1 6 1];   %10 包括了末端作业机械手     %The links the snake consists of, from head to tail
% snake.joint_vec = [ 2 3 2 3 3 2 3 2 1];     %9
%  base在中间 双向  中 左      右
%                   1 2 3 4 5 6 7 8 9 10
snake.link_vec  = [ 4 1 3 1 2 1 5 1 6];   %9 不包括末端作业机械手     %The links the snake consists of, from head to tail
snake.joint_vec = [  3 2 3 2 3 2 3 2 ];     %8



snake.n         = length(snake.link_vec);
snake.r         = 0.2665;                   %Link radius

pos_init=[-0.02 (2*0.77*cos(pi/4)+1) 0];
quat_init=eul2quat([0 0 pi],'XYZ');
%%%  机器人 初始化状态
%  姿态  ：  直立-0 ; U - 1
gesture = 0;
if gesture == 0
  % 关节角度
  theta_init=[0 0 0 0 0 0 0 0 0];   %%  直立
else 
  %合适的初始 是否重要？
  % theta_init=[0 pi/4 0 pi/4 pi/4 0 pi/4 0 0];  %% 平面倒U  z轴
  % theta_init=[0 pi/4 pi/4 pi/4 pi/4 pi/4 pi/4 0 0];  %%单向 斜倒U z轴+base两边y轴
  % 双向
  theta_init=[pi/4 pi/4 pi/4 0 pi/4 pi/4 pi/4 0 ];
end
zeta_init=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];  %%%  base 广义速度  ; joint角速度
x_init=[pos_init quat_init theta_init zeta_init]';  %%%  base , joint 


%% 机器人 物理参数
% Define Physical Parameters
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


%% 机器人 link  类型与参数
% Define Link Properties

%Link 1 关节组合连杆
link(1).name = '1';
link(1).length = .033;  %%% 33mm
link(1).mass = 0.0001;  %%% 是虚拟连杆  m 归于舵机部分
link(1).vol = link(1).mass/pp.denw;  
% 重心偏下
% link(1).r_grav = [0.5 0 0]'*link(1).length - [0 0 0.5]'*snake.r;
link(1).r_grav = [0.5 0 0]'*link(1).length - [0 0 0]'*snake.r;
link(1).r_buoy = [0.5 0 0]'*link(1).length + [0 0 0]'*snake.r;
link(1).M_R  = RBmass(link(1).r_grav,snake.r,link(1).length,link(1).mass);
link(1).M_A  = slendermass(link(1).length,pp.denw,snake.r,masscoeff);
link(1).dragtype = 1;
link(1).n_thruster = 0;
link(1).I_c = diag(0,0,0) ;  %%%  惯性张量

%Link 2  作业端 rail
link(6).name = '2';
link(6).length = .779;
link(6).vol = pi*link(2).length*snake.r^2;
link(6).mass = link(2).vol*pp.denw;
% link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0.5]'*snake.r;
link(6).r_grav = [0.5 0 0]'*link(2).length - [0 0 0]'*snake.r;
link(6).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;
link(6).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass);
link(6).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff);
link(6).dragtype = 2;
link(6).n_thruster = 0;
link(6).I_c =  ;  %%%  惯性张量

%Link 3 侧推动力段
link(5).name = '3';
link(5).length = 1.919;
link(5).vol = pi*link(3).length*snake.r^2;
link(5).mass =link(3).vol*pp.denw;  %%%  179.8  是否需要均匀化密度 
link(5).r_grav = [0.5 0 0]'*link(3).length - [0 0 0]'*snake.r;
link(5).r_buoy = [0.5 0 0]'*link(3).length + [0 0 0]'*snake.r;
link(5).M_R  = RBmass(link(3).r_grav,snake.r,link(3).length,link(3).mass);
link(5).M_A  = slendermass(link(3).length,pp.denw,snake.r,masscoeff);
link(5).dragtype = 3;
link(5).n_thruster   = 4;
link(5).t_thrust     = [ [0 1 0]' [0 1 0]' [1 0 0]' [1 0 0]' ];  %%%  推进器方向
link(5).r_thrust     = [ [0.391 0 0.15]' [0.391 0 -0.15]' [0.391 0.344 0]' [0.391 -0.344 0]' ]; %%% 推进器作用点
link(5).I_c =  ;

%Link 4  控制舱段 base  核心
link(4).name = '4';
link(4).length = 2.597;
link(4).vol = pi*link(2).length*snake.r^2;
link(4).mass = link(2).vol*pp.denw;

link(4).r_grav = [0.5 0 0]'*link(2).length - [0 0 0]'*snake.r;
link(4).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;
link(4).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass);
link(4).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff);
link(4).dragtype = 4;
link(4).n_thruster = 0;
link(4).I_c =  ;  %%%  惯性张量

%Link 5 垂推动力段
link(3).name = '3';
link(3).length = 1.919;
link(3).vol = pi*link(3).length*snake.r^2;
link(3).mass =link(3).vol*pp.denw;  %%%  179.8  是否需要均匀化密度 
link(3).r_grav = [0.5 0 0]'*link(3).length - [0 0 0]'*snake.r;
link(3).r_buoy = [0.5 0 0]'*link(3).length + [0 0 0]'*snake.r;
link(3).M_R  = RBmass(link(3).r_grav,snake.r,link(3).length,link(3).mass);
link(3).M_A  = slendermass(link(3).length,pp.denw,snake.r,masscoeff);
link(3).dragtype = 3;
link(3).n_thruster   = 4;
link(3).t_thrust     = [ [0 0 1]' [0 0 1]' [1 0 0]' [1 0 0]' ];  %%%  推进器方向
link(3).r_thrust     = [ [-0.391 0.15 0]' [-0.391 -0.15 0]' [-0.391 0 0.344]' [-0.391  0 -0.344]' ]; %%% 推进器作用点
link(3).I_c =  ;

%Link 6  摄像端 first
link(2).name = '6';
link(2).length = .981;
link(2).vol = pi*link(2).length*snake.r^2;
link(2).mass = link(2).vol*pp.denw;
% link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0.5]'*snake.r;
link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0]'*snake.r;
link(2).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;
link(2).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass);
link(2).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff);
link(2).dragtype = 5;
link(2).n_thruster = 0;
link(2).I_c =  ;  %%%  惯性张量


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
m=0;  %%%%  

for i = 1 : snake.n
   %Build Links
   clink = link(snake.link_vec(i));
   snake.link(i).name   = clink.name;
   snake.link(i).length = clink.length;
    
   snake.link(i).M_A =clink.M_A;
   snake.link(i).M_R=clink.M_R;
   snake.link(i).dragtype   = clink.dragtype;
   snake.link(i).n_thruster = clink.n_thruster;

   w = clink.mass*pp.grav;  %%%  重力
   b = clink.vol*pp.denw*pp.grav;  %%%%  浮力
   %%%  构建力矩阵 = [ 重力浮力差  ； 浮力和重力作用点不同而产生的力矩]
   snake.link(i).G = [(b-w)*eye(3); b*skew(clink.r_buoy)-w*skew(clink.r_grav)];
   
   m = m + clink.n_thruster;  %%%%   推进器数量
   if clink.n_thruster > 0
   % link_i 的推进器矩阵 = [推进器推力方向  ； 力矩（通过作用点与力方向叉乘）]
   snake.link(i).B = [clink.t_thrust; cross(clink.r_thrust,clink.t_thrust)];
   else
   snake.link(i).B = zeros(6,2);
   end
   %Build Joints
   if i < snake.n
    cjoint = joint(snake.joint_vec(i));
    snake.joint(i).twist = cjoint.twist; %%%  [0 0 0 1 0 0]'
    snake.joint(i).type=cjoint.rot;%%%   1,2,3
   end                      

end
snake.n_thruster_tot = m;
clear w b clink cjoint m i C_a_C 
 
%% MPC  
global dt_MPC dt_MPC N   t_start

N = 5000 ; %%  total MPC prediction length
t_start = 0  ;



%% PID
K_theta=diag([0.001, 0.00001, 0.0001, 0.1]);
K_P=blkdiag(eye(3),eye(3),eye(9)*30);
K_D=blkdiag(eye(3),eye(3),eye(9))*500;

Lambda=blkdiag(eye(3)*40,eye(3)*40,eye(9)*40);

estimate_init=[0 0 0 0]'; 

%% Simulate
disp('Simulation initializing..')
    sim 'simIC'
disp('Simulation finished...')
