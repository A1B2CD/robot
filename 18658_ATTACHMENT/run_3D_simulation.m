% This script is used to load parameters and run the simulation

clear all

%% Initialization

%Initialise path
%initializePath;

% Define paramters
define_simulation_parameters;
define_physical_parameters;
define_control_parameters;

%Define properties
define_link_properties;
define_joint_properties;

%Build snake
build_snake;

theta_max = find_sat(jointCtrl.shape, (snake.n-1)/2, jointCtrl.alpha); %find max base angle for this snake & shape

clear w b clink cjoint m i C_a_C C_d_C C_d_1 C_d_4 C_d_L alpha beta gamma


%% Simulate
start = clock;
disp(strcat(num2str(start(4)),':',num2str(start(5)))) %display start time  时：分
%tic 和 toc 是两个非常有用的命令，用于测量代码执行所需的时间，tic 开始；  toc 结束 返回自上次 tic 命令以来经过的时间（以秒为单位）
tic
sim('snake_model');
T_sim = toc;
disp(strcat('Simulation time: ',num2str(T_sim),'s'))
   
%% Post Process/Make Movie 处理模拟结果并创建动画
   Tinterp      = 0 : deltaT_interp : Tmax;  % 时间向量 Tinterp
   simout_int   = interp1(x.time,x.signals.values,Tinterp);   %使用 interp1 函数对模拟输出进行插值
   % snake2points 将插值得到的时间序列信号转换为蛇形机器人在三维空间中的坐标点。这可能是通过解析每个时间点上的关节角度或其他控制信号来实现的。
   [X, Y, Z]    = snake2points(simout_int,snake);  
   %animatesnake 函数使用 X, Y, Z 坐标和蛇形机器人的模型 snake 来创建动画。这个动画可能展示了蛇形机器人随时间的运动轨迹。
   mov          = animatesnake(X,Y,Z,snake);
   
   
   %boxdim = [-3 3 -3 3 -3 3];
   %[~,~] = snakeplot(X(end,:),Y(end,:),Z(end,:),boxdim,true,snake,true,'on');
%% Show Movie
   fig = figure;
   movie(fig,mov,50)
   
 %% Plot
    plot_pathvariables;