function pipe_x_ref()
    % 管道参数
    params.H = 10;    % 直立段高度10m
    params.R = 5;     % 弯曲段曲率半径5m
    params.L = 20;    % 倾斜段长度20m
    params.alpha = 30;% 倾斜角30°
    params.v = 0.8;   % 行进速度0.8m/s

    % 生成轨迹（总时间T=分段时间+过渡时间）
    T = params.H/params.v + (pi*params.R)/params.v + params.L/params.v + 2; % 加2秒过渡
    [t_ref, x_ref] = generate_pipe_trajectory(T, params);

    % 3D轨迹图
    figure;
    plot3(x_ref(1,:), x_ref(2,:), x_ref(3,:), 'LineWidth', 2);
    hold on;
    scatter3(0,0,0, 50, 'r', 'filled'); % 起点
    scatter3(x_ref(1,end), x_ref(2,end), x_ref(3,end), 50, 'g', 'filled'); % 终点
    xlabel('东向 (m)'), ylabel('北向 (m)'), zlabel('深度 (m)');
    title('海底管道蛇形轨迹（直立+弯曲+倾斜）');
    grid on;

    % 姿态曲线（俯仰角、偏航角）
    figure;
    subplot(211);
    plot(t_ref, rad2deg(x_ref(5,:)));
    ylabel('俯仰角 (°)');
    subplot(212);
    plot(t_ref, rad2deg(x_ref(6,:)));
    xlabel('时间 (s)'), ylabel('偏航角 (°)');
end

function [t_ref, x_ref] = generate_pipe_trajectory(T, params)
    % 输入参数解析
    H = params.H;       % 直立段高度（m）
    R = params.R;       % 弯曲段曲率半径（m）
    L = params.L;       % 倾斜段长度（m）
    alpha = params.alpha; % 倾斜角（°，与水平面夹角）
    v = params.v;       % 轴向速度（m/s）

    % 分段时间分配（总时间T）
    t1 = H/v;           % 直立段时间
    t2 = (pi*R)/v;      % 平面弯曲段时间（半圆弧）
    t3 = L/v;           % 倾斜段时间
    assert(t1+t2+t3 <= T, '总时间不足！');
    t = [0, t1, t1+t2, T]; % 分段时间点

    % 全段时间序列（0.02s采样）
    t_ref = 0:0.02:T;
    N = length(t_ref);
    x_ref = zeros(13, N); % 状态向量：[x,y,z,roll,pitch,yaw,pos_ee,...]（根据需求扩展）

    % ************************** 1. 直立段（t∈[0,t1]） **************************
    idx = t_ref <= t(2);
    z = v * t_ref(idx); % 垂直上升
    x_ref(3,idx) = z;   % z坐标
    x_ref(5,idx) = pi/2; % 俯仰角90°（竖直）
    x_ref(10,idx) = v;  % 轴向速度（z向）

    % ************************** 2. 平面弯曲段（t∈[t1,t1+t2]） ******************
    idx = (t_ref > t(2)) & (t_ref <= t(3));
    s = v*(t_ref(idx)-t(2)); % 弧长
    theta = s/R;            % 偏航角（弧度）
    x = R*sin(theta);       % xy平面圆弧
    y = R*(1-cos(theta));
    x_ref(1,idx) = x;       % x坐标
    x_ref(2,idx) = y;       % y坐标
    x_ref(3,idx) = H;       % z保持直立段终点高度
    x_ref(6,idx) = theta;   % 偏航角跟随曲率
    x_ref(10,idx) = v;      % 切线速度

    % ************************** 3. 倾斜段（t∈[t1+t2,T]） ************************
    idx = t_ref > t(3);
    s = v*(t_ref(idx)-t(3)); % 倾斜段行进距离
    x = s*cosd(alpha);      % 水平分量
    z = H + s*sind(alpha);  % 垂直分量（向上倾斜）
    x_ref(1,idx) = x;       % x坐标
    x_ref(3,idx) = z;       % z坐标
    x_ref(5,idx) = alpha*pi/180; % 俯仰角=倾斜角
    x_ref(10,idx) = v;      % 合速度

    % ************************** 姿态平滑过渡（避免突变） ************************
    % 1. 直立→弯曲段：俯仰角从90°线性降至0°
    trans1 = (t_ref > t(2)-0.5) & (t_ref <= t(2)+0.5);
    x_ref(5,trans1) = interp1([t(2)-0.5, t(2)+0.5], [pi/2, 0], t_ref(trans1));

    % 2. 弯曲→倾斜段：偏航角从π/2线性降至0°
    trans2 = (t_ref > t(3)-0.5) & (t_ref <= t(3)+0.5);
    x_ref(6,trans2) = interp1([t(3)-0.5, t(3)+0.5], [pi/2, 0], t_ref(trans2));

    % ************************** 蛇形摆动（仿生扰动） **************************
    % 在倾斜段加入周期性侧向摆动（幅值A，频率f）
    A = 0.2; f = 2; % 摆动参数
    idx_tilt = t_ref > t(3);
    x_ref(2,idx_tilt) = A*sin(2*pi*f*t_ref(idx_tilt)); % y向蛇形

    % ************************** 时间向量整理 **************************
    t_ref = t_ref';
end

% 调用主函数
