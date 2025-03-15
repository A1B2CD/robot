function varargout = comp_cdg(J,R,theta,snake,pp,dragcoeff,zeta1,zeta2)
%This function computes the terms c=C(theta,zeta1)zeta2,
%d=D(theta,zeta1)zeta2, and g(eta,theta), i.e. the coriolis, drag and
%hydrostatic forces on the snake. The sign-convention is such that these
%enter the equation of motion on the left-hand side, i.e. the actual force
%in terms of newton's laws is what this script puts out times -1.
nout = nargout;
nin  = nargin;

nu1 = zeta1(1:6);
if nin == 8
nu2 = zeta2(1:6);
else
   nu2 = nu1;
end
    c  = -J(:,:,1)'*W(snake.link(1).M*nu1)*nu2;
xi = zeros(6,1);
 if nout > 1
    d  = J(:,:,1)'*drag(nu1,nu2,snake.link(1).length,pp.denw,snake.r,dragcoeff,snake.link(1).drag);
 end
 if nout > 2
    g  = J(:,:,1)'*snake.link(1).G*R(:,:,1)'*pp.gdir;
 end

 for i=2:snake.n
     j=i-1;
     A        = A_HT(j,theta(j),snake);        
     twist    = snake.joint(j).twist;            
     Adinv    = Ad_inv(A);                       
     ad_tw    = ad_operator(twist); 
     nu1      = Adinv*nu1 + twist*zeta1(6+j);
      if nin  == 8
        nu2   = Adinv*nu2 + twist*zeta2(6+j);
      else
        nu2   = nu1;
      end
     xi       = -ad_tw*zeta1(6+j)*nu2 + Adinv*xi;
     M        = snake.link(i).M;
     
     c        = c + J(:,:,i)'*(M*xi - W(M*nu1)*nu2);
      if nout > 1
          d   = d + J(:,:,i)'*drag(nu1,nu2,snake.link(i).length,pp.denw,snake.r,dragcoeff,snake.link(i).drag);
      end
      if nout > 2
          g   = g + J(:,:,i)'*snake.link(i).G*R(:,:,i)'*pp.gdir;
      end
 end
 if nout == 1
     varargout = c;
 elseif nout == 2
     %varargout = cell(1,2);
     varargout{1} = c;
     varargout{2} = d;
 elseif nout == 3
     %varargout = cell(1,3);
     varargout{1} = c;
     varargout{2} = d;
     varargout{3} = g;
 end

end