function [H_t,pos_t] = comp_H(x,snake)
   pos          = x(1:3);
   quat         = x(4:7);
   theta        = x(8 : 6+snake.n);
    Rot_t  = RotQ(quat);
    pos_t  = pos;
    size(pos_t)
    H_t    =  [[Rot_t, pos_t];[0 0 0 1]];
    for j=1:snake.n-1
    if snake.joint(j).type==1
        H_t = H_t*[Rotx(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        H_t = H_t*[Roty(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==3
        H_t = H_t*[Rotz(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    end 
    end
    pos_t = H_t*[snake.link(snake.n).length,0,0,1]';
end

