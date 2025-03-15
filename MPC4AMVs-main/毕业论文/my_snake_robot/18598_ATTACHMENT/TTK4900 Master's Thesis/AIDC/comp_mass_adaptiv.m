

function [known_M, unknown_M] = comp_mass_adaptiv(J,snake,pp,alpha)
%This function computes the mass matrix of the snake
known_M = J(:,:,1)'*snake.link(1).M_R*J(:,:,1);
SM=slendermass_adaptiv(snake.link(1).length, pp.denw, snake.r,alpha);
unknown_M=  J(:,:,1)'*SM*J(:,:,1);
    for i = 2:snake.n      
        known_M = known_M + J(:,:,i)'*snake.link(i).M_R*J(:,:,i);
        if snake.link(i).dragtype==1
            SM=zeros(6,6);
        else
            SM=slendermass_adaptiv(snake.link(i).length, pp.denw, snake.r,alpha);
        end
        unknown_M= unknown_M + J(:,:,i)'*SM*J(:,:,i);
    end
end