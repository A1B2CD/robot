function [R,J] = comp_rot_jac(quat,theta,snake)
%This function computes the rotation matrices and body-jacobians for the
%snake robot.
rot = zeros(3,3,snake.n+1);
rot(:,:,0) = RotQ(quat);   %%%%   base 与 I  的 旋转矩阵


jac = zeros(6,5+snake.n,snake.n);  %%%  6*14*9
jac(1:6,1:6,1) = eye(6);

%% 左后退 
% snake.link_vec  = [ 4 1 3 1 2   1 5 1 6];   %9 不包括末端作业机械手     %The links the snake consists of, from head to tail
% snake.joint_vec = [  3 2 3 2 3 2 3 2 ];     %8
% base:0  
A =[Rotz(0) ,[-0.5*snake.link(1).length 0 0]'; [0 0 0 1]];  %%平移
rot(:,:,1) =  rot(:,:,0)*A(1:3,1:3);
 for i = 2:snake.n  %%连杆2:9
    j              = i-1;  %%% 关节1 2 3 4     
    %   坐标系（关节）--连杆 -- 
    if j == 5  %%% 关节5  声明到右边了  i == 6
        A =[Rotz(0) ,[0.5*snake.link(1).length 0 0]'; [0 0 0 1]];  %%平移
        rot(:,:,1) =  rot(:,:,0)*A(1:3,1:3);%%  rot1 只有方向不一样
    end
    if snake.joint(j).type==1
        A=[Rotx(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        A=[Roty(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    else
        A=[Rotz(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    end 
    if  j ==5  %向右
        rot(:,:,6)     = rot(:,:,1)*A(1:3,1:3);
    else
        rot(:,:,i)     = rot(:,:,i-1)*A(1:3,1:3);
    end

    % Ad_inv伴随逆矩阵（adjoint inverse matrix）
    jac(:,:,i)   = Ad_inv(A)*jac(:,:,i-1);  %%% 
    jac(:,6+j,i) = jac(:,6+j,i)+snake.joint(j).twist;%%%
    %%%，这一步是将关节的扭转特性融入到雅可比矩阵中，进一步完善雅可比矩阵对关节运动学特性的描述，
    %%% 体现了关节扭转角度对各环节运动学关系的影响，具体物理意义和后续在分析中的作用依赖于整个运动学和动力学模型的设定
    

 end
    %%末端机械臂部分
    % A=[Rotz(0), [snake.link(snake.n).length 0 0]'; [0 0 0 1]];  %%%  计算末端机械手位置的平移矩阵
    % jac(:,:,snake.n+1)   = Ad_inv(A)*jac(:,:,snake.n);
    % rot(:,:,snake.n+1)   = rot(:,:,snake.n)*A(1:3,1:3);

     R = rot;
     J = jac;

end

