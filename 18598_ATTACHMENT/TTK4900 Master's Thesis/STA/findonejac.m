function J=findonejac(quat,theta,snake)

rot = zeros(3,3,snake.n);
rot(:,:,1) = RotQ(quat);


jac = zeros(6,5+snake.n,snake.n);

J=zeros(6,14);
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
    jac(:,6+j,i) = snake.joint(j).twist;
 end
     J = jac(:,:,9);
end