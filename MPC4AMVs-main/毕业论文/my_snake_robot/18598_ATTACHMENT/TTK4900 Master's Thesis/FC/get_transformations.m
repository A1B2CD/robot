function H_t = get_transformations(x,snake)
   pos          = x(1:3);
   quat         = x(4:7);
   theta        = x(8 : 6+snake.n);


   H_t=zeros(4,4,snake.n+1);

    Rot_t  = RotQ(quat);
    pos_t  = pos;
    H_t(:,:,1)    =  [[Rot_t, pos_t];[0 0 0 1]];
    for j=1:snake.n-1
    if snake.joint(j).type==1
         H_t(:,:,j+1) = H_t(:,:,j)*[Rotx(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        H_t(:,:,j+1) = H_t(:,:,j)*[Roty(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==3
        H_t(:,:,j+1) = H_t(:,:,j)*[Rotz(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]];
    end 
    end
H_t(:,:,snake.n+1) = H_t(:,:,snake.n)*[Rotz(0), [snake.link(snake.n).length 0 0]'; [0 0 0 1]];
end