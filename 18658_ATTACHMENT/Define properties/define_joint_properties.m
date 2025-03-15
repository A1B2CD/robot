%% Define Joint Properties
% 每个关节的twist向量通常包含三个旋转分量和三个平移分量

%Joint 1
joint(1).name  = 'x revolute';
joint(1).twist = [0 0 0 1 0 0]';
joint(1).Rot   = 1;  %第一个关节的旋转矩阵是单位矩阵的x轴旋转部分。

%Joint 2
joint(2).name  = 'y revolute';
joint(2).twist = [0 0 0 0 1 0]';
joint(2).Rot   = 2;

%Joint 3
joint(3).name  = 'z revolute';
joint(3).twist = [0 0 0 0 0 1]';
joint(3).Rot   = 3;