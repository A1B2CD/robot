
function [c,d,g] = comp_cdg(J,R,theta,snake,pp,dragcoeff,zeta1)
%This function computes the terms c=C(theta,zeta1)zeta2,
%d=D(theta,zeta1)zeta2, and g(eta,theta), i.e. the coriolis, drag and
%hydrostatic forces on the snake. The sign-convention is such that these
%enter the equation of motion on the left-hand side, i.e. the actual force
%in terms of newton's laws is what this script puts out times -1.


nu1 = zeta1(1:6);
nu2=nu1;

c  = -J(:,:,1)'*W(snake.link(1).M*nu1)*nu2;
xi = zeros(6,1);
    if snake.link(1).dragtype==1
        d  = J(:,:,1)'*zeros(6,1);
    else
        d  = J(:,:,1)'*drag(nu1,nu2,snake.link(1).length,pp.denw,snake.r,dragcoeff);
    end

    g  = J(:,:,1)'*snake.link(1).G*R(:,:,1)'*pp.gdir;


 for i=2:snake.n
     j=i-1;
    if snake.joint(j).type==1
        A=[Rotx(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    elseif snake.joint(j).type==2
        A=[Roty(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    else
        A=[Rotz(theta(j)), [snake.link(i).length 0 0]'; [0 0 0 1]];
    end           
     twist    = snake.joint(j).twist;            
     Adinv    = Ad_inv(A);                       
     ad_tw    = ad(twist); 
     nu1      = Adinv*nu1 + twist*zeta1(6+j);
     nu2   = nu1;
     xi       = -ad_tw*zeta1(6+j)*nu2 + Adinv*xi;
     M        = snake.link(i).M;
     
     c        = c + J(:,:,i)'*(M*xi - W(M*nu1)*nu2);
     if snake.link(i).dragtype==1
          d   = d + J(:,:,i)'*zeros(6,1);
     else
          d   = d + J(:,:,i)'*drag(nu1,nu2,snake.link(i).length,pp.denw,snake.r,dragcoeff);  %Sjekk om det er riktig å ha i her
     end
          g   = g + J(:,:,i)'*snake.link(i).G*R(:,:,i)'*pp.gdir;
 end
end