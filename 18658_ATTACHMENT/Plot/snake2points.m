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
        H_t = H_t*A_HT(j,theta(i,j),snake);
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