
function out = comp_mass(J,snake)
%This function computes the mass matrix of the snake
out = J(:,:,1)'*snake.link(1).M*J(:,:,1);
  for i = 2:snake.n
      out = out + J(:,:,i)'*snake.link(i).M*J(:,:,i);
  end
end