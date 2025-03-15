%% Define Physical Parameters
pp.denw = 1000;         %水密度density of water
pp.grav = 9.81;         %重力加速度gravitational acceleration
pp.velc = [0 0 0]';     %水流速度 设置为0 constant irrotational current velocity, inertial frame
pp.gdir = [0 0 -1]';    %重力方向  --指向地面 direction of gravity in inertial frame (pointing towards ground, unit vector

   C_a_C   =   1; %定义横截面的附加质量系数 Added mass coefficient for the cross section, 1 is the theoretical inviscid result
   C_d_1   =  .2; % nonlinear drag coefficient in surge
   C_d_4   =  .1; % nonlinear drag coefficient in the roll direction for the cross-section
   C_d_C   =  .5; % nonlinear crossflow drag coefficient %Henrik's was 0.8? Ida's 0.5
   C_d_L   =  .1;% Linear cross-sectional drag coefficient
   alpha   =  .2; % Added mass ratio in surge/heave for a link
   beta    =  .1; % Linear drag parameter in surge
   gamma   =  .1; % Linear drag parameter in roll
   
   masscoeff = [C_a_C, alpha];
   dragcoeff = [C_d_1, C_d_4, C_d_C, C_d_L, beta, gamma];