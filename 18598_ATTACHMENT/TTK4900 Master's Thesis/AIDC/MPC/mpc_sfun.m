function [sys,x0,str,ts] = mpc_sfun(t,x,u,flag,params)
% params: snake结构体, Ts=0.01, Np=10, Q=diag([10,10,10,1,1,1])
switch flag
    case 0 % 初始化
        sizes = simsizes;
        sizes.NumOutputs = 8; % 关节加速度（假设8关节）
        sizes.NumInputs = 17; % [ee_pos_ref(3), x_state(14)]
        sys = simsizes(sizes);
        x0 = zeros(8,1); % 初始加速度
        ts = [0.01 0]; % 100Hz
    case 3 % 输出计算
        % 输入解析
        ee_pos_ref = u(1:3); % 参考位置
        x_state = u(4:17); % 状态：pos(3)+quat(4)+theta(8)
        
        % 运动学正解（调用comp_rot_jac）
        quat = x_state(4:7); theta = x_state(8:15);
        [R,J] = comp_rot_jac(quat,theta,params.snake);
        ee_pos = R(:,3,10); % 第10关节位置
        
        % 优化问题（简化为PID+约束）
        error = ee_pos_ref - ee_pos;
        accel_ref = 10*error - 2*x_state(1:3); % PD控制
        
        % 关节加速度限幅（±5rad/s²）
        sys = max(min(accel_ref, 5), -5);
end

% function [sys,x0,str,ts] = mpc_sfun(t,x,u,flag)
%     % 参数设置
%     N = 10; % 预测时域
%     Q = diag([10, 10, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]); % 状态权重矩阵
%     R = diag([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]); % 控制输入权重矩阵
%     umax = 100; % 最大控制输入幅值
% 
%     switch flag
%         case 0 % 初始化
%             sizes = simsizes;
%             sizes.NumContStates  = 0;
%             sizes.NumDiscStates  = 0;
%             sizes.NumOutputs     = 14; % 输出为期望加速度指令（基座6维 + 关节8维）
%             sizes.NumInputs      = 28; % 输入为当前状态（14维）和期望轨迹（14维）
%             sizes.DirFeedthrough = 1;
%             sizes.NumSampleTimes = 1;
%             sys = simsizes(sizes);
%             x0  = [];
%             str = [];
%             ts  = [0 0];
%         case 3 % 输出计算
%             % 提取输入
%             current_state = u(1:14);
%             desired_trajectory = u(15:end);
% 
%             % 定义优化变量
%             x_var = optimvar('x', 14, N + 1);
%             u_var = optimvar('u', 14, N);
% 
%             % 定义优化问题
%             problem = optimproblem('ObjectiveSense', 'minimize');
%             objective = 0;
%             for k = 1:N
%                 objective = objective + (x_var(:, k) - desired_trajectory).' * Q * (x_var(:, k) - desired_trajectory) + u_var(:, k).' * R * u_var(:, k);
%             end
%             problem.Objective = objective;
% 
%             % 动力学约束（简化示例，实际需根据具体动力学模型修改）
%             for k = 1:N
%                 % 这里简单假设状态更新为 x(k+1) = x(k) + u(k)，实际要替换为准确的动力学方程
%                 problem.Constraints.dynamics(:, k) = x_var(:, k + 1) == x_var(:, k) + u_var(:, k);
%             end
% 
%             % 控制输入约束
%             problem.Constraints.input_limit = -umax <= u_var <= umax;
% 
%             % 初始状态约束
%             problem.Constraints.initial_state = x_var(:, 1) == current_state;
% 
%             % 求解优化问题
%             [sol, ~] = solve(problem);
%             accel_cmd = sol.u_var(:, 1); % 取第一个控制输入作为当前时刻的加速度指令
% 
%             sys = accel_cmd;
%         case 4 % 终止函数
%             sys = [];
%         case 9 % 结束仿真
%             sys = [];
%         otherwise
%             error(['Unhandled flag = ', num2str(flag)]);
%     end
% end