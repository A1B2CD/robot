function [sys,x0,str,ts] = wbc_sfun(t,x,u,flag)
    % 权重矩阵
    W = diag([1, 1, 1, 1, 1, 1, 0.1*ones(1, 8)]); % 关节权重降低

    switch flag
        case 0 % 初始化
            sizes = simsizes;
            sizes.NumContStates  = 0;
            sizes.NumDiscStates  = 0;
            sizes.NumOutputs     = 14; % 输出为推进器控制信号（6维）和关节控制信号（8维）
            sizes.NumInputs      = 22; % 输入为加速度指令（14维）和当前关节角度（8维）
            sizes.DirFeedthrough = 1;
            sizes.NumSampleTimes = 1;
            sys = simsizes(sizes);
            x0  = [];
            str = [];
            ts  = [0 0];
        case 3 % 输出计算
            % 提取输入
            accel_cmd = u(1:14);
            q = u(15:end);

            % 计算广义力（简化示例，实际需根据具体动力学模型修改）
            M = eye(14); % 惯性矩阵，这里简单用单位矩阵代替，实际要根据机器人模型计算
            tau = M * accel_cmd;

            % 分离基座和关节力
            tau_base = tau(1:6);
            tau_joints = tau(7:end);

            % 假设推进器分配矩阵B
            B = eye(6); 
            B_pinv = pinv(B' * W * B) * B' * W;
            u_thrusters = B_pinv * tau_base;
            u_joints = tau_joints;

            sys = [u_thrusters; u_joints];
        case 4 % 终止函数
            sys = [];
        case 9 % 结束仿真
            sys = [];
        otherwise
            error(['Unhandled flag = ', num2str(flag)]);
    end
end