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
   

   
   snake.link_vec  = [2 1 2 1 3 1 2 1 2 1];   %10      %The links the snake consists of, from head to tail
   snake.joint_vec = [2 3 2 3 3 2 3 2 1];     %9

   snake.n         = length(snake.link_vec);
   snake.r         = 0.1;                   %Link radius
   
   pos_init=[-0.02 (2*0.77*cos(pi/4)+1) 0];
   quat_init=eul2quat([0 0 pi],'XYZ');
   theta_init=[0 pi/4 0 pi/4 pi/4 0 pi/4 0 0];
   zeta_init=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
   x_init=[pos_init quat_init theta_init zeta_init]';


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
   end                      

end
snake.n_thruster_tot = m;
clear w b clink cjoint m i C_a_C 


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

%% Trajectory
M_d=eye(6)*4;
D_d=eye(6)*3;
G_d=eye(6)*0.5;

t=0 : deltaT_sim : Tmax;

xe=[zeros(1,100) ((0:((pi/4-0)/(length(t)-400)):pi/4-(pi/4/(length(t)-400)))) pi/4*ones(1,300)];
eta_ee_ref.signals.values=[ zeros(length(t),3) xe'   zeros(length(t),1)  zeros(length(t),1) ];
eta_ee_ref.time=t;




%% Simulate
disp('Simulation initializing..')
    sim 'simIC'
disp('Simulation finished...')





%% Post Process/Show Movie
   Tinterp      = 0 : deltaT_interp : Tmax;
   T=x.Time;
   simout=x.Data;
   
   simout_int   = interp1(T,simout,Tinterp);
   [X, Y, Z]    = snake2points(simout_int,snake);
   
   mov          = animatesnake(X,Y,Z,snake);




   fig = figure;
   movie(fig,mov,50)  


