function varargout = comp_rot_jac(quat,theta,snake)
%This function computes the rotation matrices and body-jacobians for the
%snake robot.
rot = zeros(3,3,snake.n);
rot(:,:,1) = RotQ(quat);

nout = nargout;
 if nout == 2
    jac = zeros(6,5+snake.n,snake.n);
    jac(1:6,1:6,1) = eye(6);
 end

 for i = 2:snake.n
    j              = i-1;                             
    A              = A_HT(j,theta(j),snake);  %Joint nr, angle, snake          
    rot(:,:,i)     = rot(:,:,i-1)*A(1:3,1:3);
    
    if nout == 2
        jac(:,:,i)   = Ad_inv(A)*jac(:,:,i-1);
        jac(:,6+j,i) = snake.joint(j).twist;
    end
 end
 if nout == 1
     %varargout = cell(1,1);
     varargout{1} = rot;
 elseif nout == 2
     %varargout = cell(1,2);
     varargout{1} = rot;
     varargout{2} = jac;
 end
 
end