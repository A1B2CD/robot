clear; clc; close all
format compact

%% 1. 初始化系统（类文件需在当前路径）
params = UnderwaterSnakeRobotParams();
model = SnakeRobotDynamics(params);
N = 10; % 预测时域
weights = {0.4*eye(6), 0.01*eye(3), 0.5*eye(6)};  % 加权矩阵
upperbound = [2000; 2000; 1000];
lowerbound = [-2000; -2000; -1000];

mpc = SnakeRobotMPC(N, model, weights, upperbound, lowerbound);
wbc = SnakeRobotWBC(params);

%% 2. 仿真参数
Tstep = 200;    % 20秒（0.1s采样）
dt = 0.1;
X0 = [0; 0; 0; 0; 0; 0];  % 初始状态：x,y,ψ,u,v,r
Xall = zeros(6, Tstep+1);  % 存储状态（Tstep+1个点）
Xall(:,1) = X0;
Uall = zeros(3, Tstep);    % 存储控制输入（Tstep个点）
t_state = (0:Tstep)*dt;    % 状态时间轴
t_control = (0:Tstep-1)*dt;% 控制时间轴

%% 3. 主循环（MPC+WBC）
% 主循环
% 初始状态
X0 = [0; 0; 0; 0; 0; 0]; % 可以根据实际情况调整初始状态

% 主循环
for i = 1:Tstep
    % 生成参考轨迹（随时间线性增加）
    current_time = (i-1)*dt;
    % 确保参考轨迹有一定的变化，使机器人有运动需求
    P = repmat([current_time; 0.1 * sin(current_time); 0; 1; 0; 0], 1, mpc.N); 
    
    % 求解MPC
    if i == 1
        u0 = 0.1 * ones(3*mpc.N, 1); 
    else
        u0 = [Uall(:,i-1); zeros(3*(mpc.N-1), 1)]; % 基于上一步控制输入
    end
    u = mpc.calc_control(u0, Xall(:,i), P, dt);
    F = u(1:3);  % 提取当前步广义力
    Uall(:,i) = F;
    
    % WBC分配（示例：简单平均分配，需根据实际推进器布局修改）
    [Thrust, Torque] = wbc.allocateForces(F);
    
    % 更新AUV状态（使用离散动力学模型）
    Xall(:,i+1) = model.dynamics_discrete(Xall(:,i), F, dt);
end

%% 4. 绘图（修正后的索引）
figure(1), clf, set(gcf, 'Color','white','Position',[100,100,1200,800])
% 全局设置中文字体
% set(0, 'DefaultAxesFontName', '微软雅黑'); % 适用于所有子图
% 轨迹跟踪（状态时间轴：Tstep+1个点）
% % % % % subplot(3,2,1)
% % % % % plot(t_state, Xall(1,:), 'r-', t_state, t_state, 'b--','LineWidth',1.5)
% % % % % ylabel('X位置 (m)'), grid on, title('沿管道轴线跟踪')
% % % % % legend('实际轨迹','参考轨迹','Location','southeast')
% % % % % 
% % % % % subplot(3,2,2)
% % % % % plot(t_state, Xall(2,:), 'r-', 'LineWidth',1.5), ylim([-0.2,0.2])
% % % % % ylabel('Y偏移 (m)'), grid on, title('横向稳定性（±0.1m）')
% % % % % 
% % % % % subplot(3,2,3)
% % % % % plot(t_state, rad2deg(Xall(3,:)), 'r-', 'LineWidth',1.5), ylim([-3,3])
% % % % % ylabel('航向角 (°)'), grid on, title('航向保持（±2°）')

% 广义力（控制时间轴：Tstep个点）
subplot(3,2,4)
plot(t_control, Uall(1,:), 'r-', t_control, 1*ones(1,Tstep), 'k--','LineWidth',0.1)
ylabel('纵向力 Fx (N)'), grid on, title('MPC_force 广义力输出')
text(0.95, 0.9, '上限: 2000N', 'Units','normalized','Color','k','FontSize',10)

subplot(3,2,5)
plot(t_control, Uall(2,:), 'b-', 'LineWidth',1.5), ylim([-5,5])
ylabel('横向力 Fy (N)'), grid on

subplot(3,2,6)
plot(t_control, Uall(3,:), 'g-', 'LineWidth',1.5), ylim([-1,1])
ylabel('扭矩torque Mz (N·m)'), xlabel('时间 (s)'), grid on


%% 保存结果（可选）
% save('snake_robot_sim.mat', 'Xall', 'Uall', 't_state', 't_control');
% exportgraphics(gcf, 'Pipeline_Inspection_Results.pdf', 'ContentType','vector');