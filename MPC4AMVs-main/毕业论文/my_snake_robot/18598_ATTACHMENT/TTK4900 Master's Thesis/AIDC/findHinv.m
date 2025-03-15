function H_tinv = findHinv(pos_ee,eul_ee,theta,snake)
   

   

    Rot_ee  = eul2rotm(eul_ee','XYZ');
    H_t    =  [[Rot_ee, pos_ee];[0 0 0 1]];
    H_t    =  H_t*inv([eye(3), [snake.link(snake.n).length 0 0]'; [0 0 0 1]]);
    for j=(snake.n-1):-1:1
%         i
%         j
%         size(H_t) 
%         size(Rotx(theta(i,j)))
%         size( [snake.link(i).length 0 0]')
%         size([0 0 0 1])
   

    if snake.joint(j).type==1
         H_t = H_t*inv([Rotx(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]]);
    elseif snake.joint(j).type==2
        H_t = H_t*inv([Roty(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]]);
    elseif snake.joint(j).type==3
        H_t = H_t*inv([Rotz(theta(j)), [snake.link(j).length 0 0]'; [0 0 0 1]]);
    end 

    end
H_tinv=H_t;
  
end
