classdef SnakeRobotMPC < handle
    properties
        N; % 预测时域
        model; % 机器人动力学模型
        weights; % 加权矩阵
        upperbound; % 控制输入上限
        lowerbound; % 控制输入下限
    end
    
    methods
        function obj = SnakeRobotMPC(N, model, weights, upperbound, lowerbound)
            obj.N = N;
            obj.model = model;
            obj.weights = weights;
            obj.calc_upperbound(upperbound);
            obj.calc_lowerbound(lowerbound);
        end
        
        function obj = calc_upperbound(obj, upperbound)
            if ~isempty(upperbound)
                m = length(upperbound);
                Thrust_max = zeros(m*obj.N, 1);
                for i = 1:obj.N
                    Thrust_max(1+m*(i-1):m*i, 1) = upperbound;
                end
                obj.upperbound = Thrust_max;
            else
                obj.upperbound = [];
            end
        end
        
        function obj = calc_lowerbound(obj, lowerbound)
            if ~isempty(lowerbound)
                m = length(lowerbound);
                Thrust_min = zeros(m*obj.N, 1);
                for i = 1:obj.N
                    Thrust_min(1+m*(i-1):m*i, 1) = lowerbound;
                end
                obj.lowerbound = Thrust_min;
            else
                obj.lowerbound = [];
            end
        end
        
        function cost = mpc_cost(obj, u, X0, P, dt)
            % 从模型中获取相关参数
            M = obj.model.M; % 质量矩阵
            Q = obj.weights{1}; % 状态误差加权矩阵
            R = obj.weights{2}; % 控制输入误差加权矩阵
            Qf = obj.weights{3}; % 终端状态误差加权矩阵
            
            % 减小控制输入误差的权重
            R = 0.1 * R; % 可根据实际情况调整系数
            
            Hp = obj.N;
            nu = length(u);
            nu = nu/Hp;
            nx = length(X0);
            
            U = zeros(nu, Hp);
            X = zeros(nx, Hp);
            
            % 划分控制输入向量
            for i = 1:Hp
                for j = 1:nu
                    U(j, i) = u((i-1)*nu + j, 1);
                end
            end
            
            % 状态预测
            Xplus = obj.model.dynamics_discrete(X0, U(:, 1), dt);
            X(:, 1) = Xplus;
            for i = 2:Hp
                Xplus = obj.model.dynamics_discrete(Xplus, U(:, i), dt);
                X(:, i) = Xplus;
            end
            
            % 提取参考状态
            xr = zeros(Hp, 1);
            yr = zeros(Hp, 1);
            psi_r = zeros(Hp, 1);
            ur = zeros(Hp, 1);
            vr = zeros(Hp, 1);
            rr = zeros(Hp, 1);
            for i = 1:Hp
                xr(i, 1) = P(1, i);
                yr(i, 1) = P(2, i);
                psi_r(i, 1) = P(3, i);
                ur(i, 1) = P(4, i);
                vr(i, 1) = P(5, i);
                rr(i, 1) = P(6, i);
            end
            
            % 计算成本函数
            cost = 0;
            for i = 1:Hp
                Xr = [xr(i, 1); yr(i, 1); psi_r(i, 1); ur(i, 1); vr(i, 1); rr(i, 1)];
                Xe = obj.model.ErrorState(X(:, i), Xr);
                Te = M \ U(:, i); % 计算控制输入对应的广义力
                cost = cost + Xe' * Q * Xe + Te' * R * Te;
            end
            
            Xr = [xr(Hp, 1); yr(Hp, 1); psi_r(Hp, 1); ur(Hp, 1); vr(Hp, 1); rr(Hp, 1)];
            Xe = obj.model.ErrorState(X(:, Hp), Xr);
            cost = cost + Xe' * Qf * Xe;
        end
        
        function [y, ceq] = mpc_contraints(obj, u, X0, P, dt)
            ceq = [];

            Hp = obj.N;
            nx = length(X0);
            nu = length(u);
            nu = nu/Hp;
            U = zeros(nu, Hp);

            % 划分控制输入向量
            for i = 1:Hp
                for j = 1:nu
                    U(j, i) = u((i-1)*nu + j, 1);
                end
            end

            % 提取参考状态
            xr = zeros(Hp, 1);
            yr = zeros(Hp, 1);
            psi_r = zeros(Hp, 1);
            ur = zeros(Hp, 1);
            vr = zeros(Hp, 1);
            rr = zeros(Hp, 1);
            for i = 1:Hp
                xr(i, 1) = P(1, i);
                yr(i, 1) = P(2, i);
                psi_r(i, 1) = P(3, i);
                ur(i, 1) = P(4, i);
                vr(i, 1) = P(5, i);
                rr(i, 1) = P(6, i);
            end

            % 状态预测
            Xall = zeros(nx, Hp + 1);
            Xplus = X0;
            Xall(:, 1) = Xplus;
            for i = 1:Hp - 1
                Xplus = obj.model.dynamics_discrete(Xplus, U(:, i), dt);
                Xall(:, i + 1) = Xplus;
            end

            XN = Xall(:, Hp);
            XrN = [xr(Hp, 1); yr(Hp, 1); psi_r(Hp, 1); ur(Hp, 1); vr(Hp, 1); rr(Hp, 1)];
            XeN = obj.model.ErrorState(XN, XrN);
            xeN = XeN(1);
            yeN = XeN(2);
            psi_eN = XeN(3);
            ueN = XeN(4);
            veN = XeN(5);
            reN = XeN(6);

            % 放宽约束条件（示例：增加一定的余量）
            margin = 0.1;
            y1 = abs(xeN) - abs(ueN) - margin;
            y2 = abs(yeN) - abs(veN) - margin;
            y3 = abs(psi_eN) - abs(reN) - margin;
            y4 = -xeN * ueN - margin;
            y5 = -yeN * veN - margin;
            y6 = -psi_eN * reN - margin;

            y = [y1; y2; y3; y4; y5; y6];
        end
        
        function u = calc_control(obj, u0, X0, P, dt)
            % 使用 optimoptions 设置优化选项
            options = optimoptions('fmincon', 'Algorithm', 'sqp',...
                                  'MaxFunctionEvaluations', 5000,...  % 增加评估次数
                                  'TolX', 1e-6,...  % 提高精度
                                  'Display', 'off');  % 关闭迭代显示
            u = fmincon(@(u) obj.mpc_cost(u, X0, P, dt), u0, [], [], [], [], obj.lowerbound, obj.upperbound,...
                        @(u) obj.mpc_contraints(u, X0, P, dt), options);
        end
    end
end