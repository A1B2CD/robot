function [X, Y, Z] = snake2points(simout,snake)
   pos          = simout(:,1:3);
   quat         = simout(:,4:7);
   theta        = simout(:,8 : 6+snake.n);

   [row, ~]   = size(pos);
   X          = zeros(row,snake.n+1);
   Y          = zeros(row,snake.n+1);
   Z          = zeros(row,snake.n+1);
   
   for i = 1:row
    Rot_t  = RotQ(quat(i,:));
    pos_t  = pos(i,:);
    H_t    =  [[Rot_t, pos_t'];[0 0 0 1]];
    X(i,1) =  pos_t(1);
    Y(i,1) =  pos_t(2);
    Z(i,1) =  pos_t(3);
    for j=1:snake.n-1
%         i
%         j
%         size(H_t) 
%         size(Rotx(theta(i,j)))
%         size( [snake.link(i).length 0 0]')
%         size([0 0 0 1])
    if snake.joint(j).type==1
         H_t = H_t*[Rotx(theta(i,j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        H_t = H_t*[Roty(theta(i,j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==3
        H_t = H_t*[Rotz(theta(i,j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    end 
        pos_t = H_t(1:3,4);
        X(i,j+1) = pos_t(1);
        Y(i,j+1) = pos_t(2);
        Z(i,j+1) = pos_t(3);
    end
    pos_t = H_t*[snake.link(snake.n).length,0,0,1]';
    X(i,end) = pos_t(1);
    Y(i,end) = pos_t(2);
    Z(i,end) = pos_t(3);
   end
end