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
       % �ƽ���������λ��
       snake.link(i).t_thrust = clink.t_thrust;
       snake.link(i).r_thrust = clink.r_thrust;
   %end
   
   w = clink.mass*pp.grav;
   b = clink.vol*pp.denw*pp.grav;
   %skew(clink.r_buoy) �� skew(clink.r_grav): skew ������һ�� 3 Ԫ�ص�����ת��Ϊһ�� 3x3 ��б�Գƾ���
   %clink.r_buoy �Ǹ��ĵ�λ��������clink.r_grav �����ĵ�λ��������б�Գƾ������ڱ�ʾ���ء�
   %b*skew(clink.r_buoy) �� -w*skew(clink.r_grav): ��Щ���ʽ�ֱ���㸡�����������������ء�
   %���յ���������ƽ���������һ�� 6x3 �ľ���ǰ����Ԫ�ش�����������������Ԫ�ش�������
   %��Щ��Ϣ����ģ�����λ������������еĶ�̬��Ϊ������Ҫ���������������ڼ������λ��������ܵ���������ʱ�ļ��ٶȺͽǼ��ٶȣ��Ƕ���ѧ���̵�һ���֡�
   snake.link(i).G = [(b-w)*eye(3); b*skew(clink.r_buoy)-w*skew(clink.r_grav)];
   % �����ƽ�������
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
%Ϊÿ���ƽ�������һ���ᣨaxis����λ�ã�position����ģ���ţ�module number��
for i = 1 : snake.n
    if snake.link(i).n_thruster ~= 0
        for j = 1:snake.link(i).n_thruster
            for k = 1:3 %for k = 1:3�����ѭ�����ÿ���ƽ����������ռ��ᣨx��y��z�����Ƿ����������á�
                if snake.link(i).t_thrust(k,j) == 1  %����ƽ��� j ���� k ��������������ִ�����²�����
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
% �洢�����λ�����ÿ���ؽڵ�Ťת����
bodyTwist = zeros(6,snake.n_joints);

for i = 1:snake.n_joints
    bodyTwist(:,i) = snake.joint(i).twist;
end
snake.bodyTwist = bodyTwist;

