% 主运行文件：参数配置+闭环仿真+可视化
function run_robot_inspection()
    %% 1. 机器人参数配置（集中管理）
    % 物理参数
    param.m = 5.2;          % 总质量 (kg)
    param.I = diag([0.8, 0.8, 1.2]); % 惯性矩阵 (kg·m²)
    param.L = [0.3, 0.4, 0.4, 0.3]; % 连杆长度 (m) 倒U型结构
    param.D = 0.5*eye(3);   % 水阻力系数 (N·s/m)
    
    % 控制参数
    param.N = 8;            % MPC预测时域
    param.dt = 0.05;        % 控制周期 (s)
    param.Q = diag([100,100,50, 1,1,1, 50,50,50, 10,10,10, 1]); % 状态权重
    param.R = 0.1*eye(15);  % 力控制权重（15维接触力）
    
    % 执行器约束
    param.u_servo_max = 5;  % 舵机力矩上限 (Nm)
    param.u_thruster_max = 100; % 推进器推力上限 (N)
    param.q_lim = deg2rad([-90, 90]); % 关节角度限制
    
    %% 2. 任务参数（海底管道巡检）
    pipe_radius = 0.5;      % 管道半径 (m)
    mission_time = 20;      % 总任务时间 (s)
    [t_ref, x_ref] = generate_pipe_trajectory(mission_time, pipe_radius); % 轨迹生成
    
    %% 3. 初始化
    x0 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0]; % 初始状态：[θ, φ, ψ, x, y, z, ω, v]
    states = zeros(13, mission_time/param.dt); % 记录状态
    inputs = zeros(16, mission_time/param.dt); % 记录输入（8舵机+8推进器）
    
    %% 4. 闭环仿真
    for k = 1:length(t_ref)
        %% 4.1 轨迹生成（带时变参考）
        x_ref_k = interp1(t_ref, x_ref, (k-1)*param.dt, 'previous');
        
        %% 4.2 MPC 计算广义力
        u_mpc = mpc_controller(x0, x_ref_k, param);
        
        %% 4.3 WBC 分配到执行器
        [u_servo, u_thruster] = wbc_allocator(u_mpc, param);
        
        %% 4.4 动力学更新（带反馈）
        x0 = robot_dynamics(x0, u_servo, u_thruster, param);
        
        %% 4.5 数据记录
        states(:,k) = x0;
        inputs(:,k) = [u_servo; u_thruster];
    end
    
    %% 5. 结果可视化
    visualize_results(t_ref, x_ref, states, inputs, param);
end