function out = comp_TCM(J,snake)
%This function computes the thrust-configuration matrix for the robot. 
out          = zeros(5+snake.n,snake.n_thruster_tot); 
m            = snake.link(1).n_thruster;
if m ~= 0
    out(:,1:m)   = J(:,:,1)'*snake.link(1).B; 
end

 for i = 2:snake.n
     if snake.link(i).n_thruster > 0
        m = m + snake.link(i).n_thruster;
        out(:,m+1-snake.link(i).n_thruster:m) = J(:,:,i)'*snake.link(i).B(:,1:snake.link(i).n_thruster);
    end
 end
end