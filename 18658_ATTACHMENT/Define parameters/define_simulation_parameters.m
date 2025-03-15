%% Define Simulation Parameters
   Tmax          = 300;  %仿真时长
   deltaT_interp = 1;             %插值解的时间步长        %Time step size for the interpolated solution
  
   snake.link_vec  = [1 2 3 2 4 2 5 2 6];      %5个连杆+4模拟连杆(万向节)把万向节标注为2类型连杆,一般连杆为 1-3-4-5-6   %The links the snake consists of, from tail to head
   snake.joint_vec = [3 2 3 2 3 2 3 2];           %The type of joints, from tail to head
   snake.n         = length(snake.link_vec); %Number of links/modules
   snake.n_joints  = length(snake.joint_vec); %Number of joints
   snake.r         = 8.5*10^(-2);                   %Link radius
   

   y_0             = zeros(11+2*snake.n,1); %Initial conditions  11:初始状态 3个位置分量+4个四元数分量表示方向
   y_0(1:3)        = [0; 0; 0];
   angle = 0; % start angle about z-axis in deg
   y_0(4:7)        = [cos(angle*pi/360); 0; 0; sin(angle*pi/360)]; %初始化四元数  initial orientation as quaternion
   y_0(7+snake.n) = 0.45; %surge
   % y_0 :
   % [0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0.450000000000000;0;0;0;0;0;0;0;0;0;0;0;0;0]
   % 共29个数据
   
   