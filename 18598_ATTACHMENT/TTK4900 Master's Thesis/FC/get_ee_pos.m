function [X,Y,Z] = get_ee_pos(x,snake)
   
pos       =   x(1:3);
quat      =   x(4:7);
    Rot_t  = RotQ(quat);
    pos_t  = pos;
    H_t    =  [[Rot_t, pos_t'];[0 0 0 1]];
    X=zeros(snake.n+1,1);
    Y=zeros(snake.n+1,1);
    Z=zeros(snake.n+1,1);
    X(1) =  pos_t(1);
    Y(1) =  pos_t(2);
    Z(1) =  pos_t(3);
for j=1:snake.n-1
    if snake.joint(j).type==1
         H_t = H_t*[Rotx(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        H_t = H_t*[Roty(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==3
        H_t = H_t*[Rotz(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    end 
        pos_t = H_t(1:3,4);
        X(j+1) = pos_t(1);
        Y(j+1) = pos_t(2);
        Z(j+1) = pos_t(3);
end
    pos_t = H_t*[snake.link(snake.n).length,0,0,1]';
    X(end) = pos_t(1);
    Y(end) = pos_t(2);
    Z(end) = pos_t(3);
end

