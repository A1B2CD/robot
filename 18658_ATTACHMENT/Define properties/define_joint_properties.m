%% Define Joint Properties
% ÿ���ؽڵ�twist����ͨ������������ת����������ƽ�Ʒ���

%Joint 1
joint(1).name  = 'x revolute';
joint(1).twist = [0 0 0 1 0 0]';
joint(1).Rot   = 1;  %��һ���ؽڵ���ת�����ǵ�λ�����x����ת���֡�

%Joint 2
joint(2).name  = 'y revolute';
joint(2).twist = [0 0 0 0 1 0]';
joint(2).Rot   = 2;

%Joint 3
joint(3).name  = 'z revolute';
joint(3).twist = [0 0 0 0 0 1]';
joint(3).Rot   = 3;