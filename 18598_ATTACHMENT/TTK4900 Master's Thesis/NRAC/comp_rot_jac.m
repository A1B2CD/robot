function [R,J] = comp_rot_jac(quat,theta,snake)
%This function computes the rotation matrices and body-jacobians for the
%snake robot.
rot = zeros(3,3,snake.n+1);
rot(:,:,1) = RotQ(quat);


jac = zeros(6,5+snake.n,snake.n+1);
jac(1:6,1:6,1) = eye(6);


 for i = 2:snake.n
    j              = i-1;     
    if snake.joint(j).type==1
        A=[Rotx(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        A=[Roty(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    else
        A=[Rotz(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    end           
    rot(:,:,i)     = rot(:,:,i-1)*A(1:3,1:3);
    
    jac(:,:,i)   = Ad_inv(A)*jac(:,:,i-1);
    jac(:,6+j,i) = jac(:,6+j,i)+snake.joint(j).twist;
 end
 
     A=[Rotz(0), [snake.link(snake.n).length 0 0]'; [0 0 0 1]];
    jac(:,:,snake.n+1)   = Ad_inv(A)*jac(:,:,snake.n);
    rot(:,:,snake.n+1)     = rot(:,:,snake.n)*A(1:3,1:3);
 
     R = rot;
     J = jac;

end

