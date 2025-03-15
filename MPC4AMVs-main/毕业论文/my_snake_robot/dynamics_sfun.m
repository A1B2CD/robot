function [sys,x0,str,ts] = dynamics_sfun(t,x,u,flag,snake,pp)
switch flag
    case 1 % 连续状态导数
        joint_torque = u(1:8); % WBC输出
        thrust = zeros(6,1); % 本例不使用推进器
        sys = dyn(x, joint_torque, thrust, pp, snake, 0.1);
    case 3 % 输出当前状态
        sys = x;
end