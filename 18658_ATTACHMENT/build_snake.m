%% Build Snake
m=0;
for i = 1 : snake.n
   %Build Links
   clink = link(snake.link_vec(i));
   snake.link(i).name   = clink.name;
   snake.link(i).length = clink.length;
   snake.link(i).M      = clink.M_R*2+clink.M_A;
   snake.link(i).M_RB   = clink.M_R; %added by Marianna to try stuff
   snake.link(i).drag   = clink.drag; 
   snake.link(i).n_thruster = clink.n_thruster;
   
   %if snake.link(i).n_thruster ~= 0
       %snake.link(i).t_thrust = [];
       %snake.link(i).r_thrust = [];
       % 推进器方向与位置
       snake.link(i).t_thrust = clink.t_thrust;
       snake.link(i).r_thrust = clink.r_thrust;
   %end
   
   w = clink.mass*pp.grav;
   b = clink.vol*pp.denw*pp.grav;
   %skew(clink.r_buoy) 和 skew(clink.r_grav): skew 函数将一个 3 元素的向量转换为一个 3x3 的斜对称矩阵。
   %clink.r_buoy 是浮心的位置向量，clink.r_grav 是重心的位置向量。斜对称矩阵用于表示力矩。
   %b*skew(clink.r_buoy) 和 -w*skew(clink.r_grav): 这些表达式分别计算浮力和重力产生的力矩。
   %最终的力和力矩平衡矩阵，它是一个 6x3 的矩阵。前三个元素代表线性力，后三个元素代表力矩
   %这些信息对于模拟蛇形机器人在流体中的动态行为至关重要。这个矩阵可以用于计算蛇形机器人在受到外力作用时的加速度和角加速度，是动力学方程的一部分。
   snake.link(i).G = [(b-w)*eye(3); b*skew(clink.r_buoy)-w*skew(clink.r_grav)];
   % 计算推进器总数
   m = m + clink.n_thruster;
   %if clink.n_thruster > 0
   snake.link(i).B = [clink.t_thrust; cross(clink.r_thrust,clink.t_thrust)];
   %else
   %snake.link(i).B = [];
   %end
   
   %Build Joints
   if i < snake.n
    cjoint = joint(snake.joint_vec(i));
    snake.joint(i).twist = cjoint.twist;
    snake.joint(i).Rot   = cjoint.Rot;
    snake.joint(i).length= [clink.length 0 0]';
   
   end
end
%Transformation matrix
joint_tr = zeros(snake.n,3);
joint_ax = zeros(snake.n_joints,1);

for i = 1 : snake.n
    joint_tr(i,1) = snake.link(i).length;
end
for i = 1 : snake.n_joints
    joint_ax(i,1) = snake.joint(i).Rot;
end

snake.joint_tr = joint_tr;
snake.joint_ax = joint_ax;

%Thruster information
snake.n_thruster_tot = m;

thruster_ax = zeros(m,1);
thruster_pos = zeros(m,3);
thruster_moduleNumber = zeros(m,1);

num = 1;
%为每个推进器分配一个轴（axis）、位置（position）和模块编号（module number）
for i = 1 : snake.n
    if snake.link(i).n_thruster ~= 0
        for j = 1:snake.link(i).n_thruster
            for k = 1:3 %for k = 1:3：这个循环检查每个推进器在三个空间轴（x、y、z）上是否有力的作用。
                if snake.link(i).t_thrust(k,j) == 1  %如果推进器 j 在轴 k 上有作用力，则执行以下操作：
                    thruster_ax(num) = k;
                    thruster_moduleNumber(num) = i;
                    for l = 1:3
                        thruster_pos(num,l) = snake.link(i).r_thrust(l,j);
                    end
                    num = num + 1;
                end
            end                
        end
    end
end

snake.thruster_ax = thruster_ax;
snake.thruster_pos = thruster_pos;
snake.thruster_moduleNumber = thruster_moduleNumber;

%%%----------------------------
% 存储了蛇形机器人每个关节的扭转向量
bodyTwist = zeros(6,snake.n_joints);

for i = 1:snake.n_joints
    bodyTwist(:,i) = snake.joint(i).twist;
end
snake.bodyTwist = bodyTwist;

