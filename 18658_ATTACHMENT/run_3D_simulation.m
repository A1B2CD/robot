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
disp(strcat(num2str(start(4)),':',num2str(start(5)))) %display start time  ʱ����
%tic �� toc �������ǳ����õ�������ڲ�������ִ�������ʱ�䣬tic ��ʼ��  toc ���� �������ϴ� tic ��������������ʱ�䣨����Ϊ��λ��
tic
sim('snake_model');
T_sim = toc;
disp(strcat('Simulation time: ',num2str(T_sim),'s'))
   
%% Post Process/Make Movie ����ģ��������������
   Tinterp      = 0 : deltaT_interp : Tmax;  % ʱ������ Tinterp
   simout_int   = interp1(x.time,x.signals.values,Tinterp);   %ʹ�� interp1 ������ģ��������в�ֵ
   % snake2points ����ֵ�õ���ʱ�������ź�ת��Ϊ���λ���������ά�ռ��е�����㡣�������ͨ������ÿ��ʱ����ϵĹؽڽǶȻ����������ź���ʵ�ֵġ�
   [X, Y, Z]    = snake2points(simout_int,snake);  
   %animatesnake ����ʹ�� X, Y, Z ��������λ����˵�ģ�� snake �����������������������չʾ�����λ�������ʱ����˶��켣��
   mov          = animatesnake(X,Y,Z,snake);
   
   
   %boxdim = [-3 3 -3 3 -3 3];
   %[~,~] = snakeplot(X(end,:),Y(end,:),Z(end,:),boxdim,true,snake,true,'on');
%% Show Movie
   fig = figure;
   movie(fig,mov,50)
   
 %% Plot
    plot_pathvariables;