function [c,d,g,D,dm] = comp_cdg_adaptiv(J,R,theta,snake,pp,beta,gamma,zeta1,zeta_r)
%This function computes the terms c=C(theta,zeta1)zeta2,
%d=D(theta,zeta1)zeta2, and g(eta,theta), i.e. the coriolis, drag and
%hydrostatic forces on the snake. The sign-convention is such that these
%enter the equation of motion on the left-hand side, i.e. the actual force
%in terms of newton's laws is what this script puts out times -1.
dragcoeff_for_comparison = [0.2, 0.1, 0.8, 0.1, beta, gamma];
% dragcoeff_for_comparison = [0.5, 0.5, 0.5, 0.5, beta, gamma];
nu1 = zeta1(1:6);
nu2=zeta_r(1:6);
slices = 10;
x   = linspace(0,1,slices);
dx  = x(2)-x(1);
sqrtx   =  sqrt(nu1(2)^2+nu1(3)^2+x.^2*nu1(5)^2+x.^2*nu1(6)^2+2*x*nu1(2)*nu1(6)-2*x*nu1(3)*nu1(5));

v_ref = 1;
D=zeros(6,4,snake.n);


rho=pp.denw;
dm=[0 0 0 0 0 0]';


c  = -J(:,:,1)'*W(snake.link(1).M*nu1)*nu2;
xi = zeros(6,1);
    if snake.link(1).dragtype==1
        d  = J(:,:,1)'*zeros(6,1);
    else
        d  = J(:,:,1)'*drag(nu1,nu2,snake.link(1).length,pp.denw,snake.r,dragcoeff_for_comparison);
    end
    
            D(1,1,1)=.5*rho*pi*snake.r^2*abs(nu1(1))*nu2(1);
            D(1,4,1)=rho*snake.r*snake.link(1).length*v_ref*beta*nu2(1);
            D(2,3,1)=rho*snake.r*dx*snake.link(1).length*trapz(sqrtx.*(nu2(2)+nu2(6)*x));
            D(2,4,1)=rho*snake.r*snake.link(1).length*v_ref*(nu2(2)+0.5*snake.link(1).length*nu2(6));
            D(3,3,1)=rho*snake.r*dx*snake.link(1).length*trapz(sqrtx.*(nu2(3)-nu2(5)*x));
            D(3,4,1)=rho*snake.r*snake.link(1).length*v_ref*(nu2(3)-0.5*snake.link(1).length*nu2(5));
            D(4,2,1)=.5*rho*pi*snake.link(1).length*snake.r^4*abs(nu1(4))*nu2(4);
            D(4,4,1)=rho*snake.r*snake.link(1).length*v_ref*gamma*snake.r^2*nu2(4);
            D(5,3,1)=rho*snake.r*dx*snake.link(1).length*trapz(sqrtx.*(-nu2(3)*x+nu2(5)*x.^2));
            D(5,4,1)=rho*snake.r*snake.link(1).length*v_ref*(-0.5*snake.link(1).length*nu2(3)+snake.link(1).length^2*nu2(5)/3);
            D(6,3,1)=rho*snake.r*dx*snake.link(1).length*trapz(sqrtx.*(nu2(2)*x+nu2(6)*x.^2));
            D(6,4,1)=rho*snake.r*snake.link(1).length*v_ref*(0.5*snake.link(1).length*nu2(2)+snake.link(1).length^2*nu2(6)/3);

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
     nu2      = Adinv*nu2 + twist*zeta_r(6+j);
     xi       = -ad_tw*zeta1(6+j)*nu2 + Adinv*xi;
     M        = snake.link(i).M;
     
     c        = c + J(:,:,i)'*(M*xi - W(M*nu1)*nu2);
     if snake.link(i).dragtype==1
          d   = d + J(:,:,i)'*zeros(6,1);
          D(:,:,i)=zeros(6,4);
     else
          d   = d + J(:,:,i)'*drag(nu1,nu2,snake.link(i).length,pp.denw,snake.r,dragcoeff_for_comparison);  %Sjekk om det er riktig å ha i her
          D(1,1,i)=.5*rho*pi*snake.r^2*abs(nu1(1))*nu2(1);
            D(1,4,i)=rho*snake.r*snake.link(i).length*v_ref*beta*nu2(1);
            D(2,3,i)=rho*snake.r*dx*snake.link(i).length*trapz(sqrtx.*(nu2(2)+nu2(6)*x));
            D(2,4,i)=rho*snake.r*snake.link(i).length*v_ref*(nu2(2)+0.5*snake.link(i).length*nu2(6));
            D(3,3,i)=rho*snake.r*dx*snake.link(i).length*trapz(sqrtx.*(nu2(3)-nu2(5)*x));
            D(3,4,i)=rho*snake.r*snake.link(i).length*v_ref*(nu2(3)-0.5*snake.link(i).length*nu2(5));
            D(4,2,i)=.5*rho*pi*snake.link(i).length*snake.r^4*abs(nu1(4))*nu2(4);
            D(4,4,i)=rho*snake.r*snake.link(i).length*v_ref*gamma*snake.r^2*nu2(4);
            D(5,3,i)=rho*snake.r*dx*snake.link(i).length*trapz(sqrtx.*(-nu2(3)*x+nu2(5)*x.^2));
            D(5,4,i)=rho*snake.r*snake.link(i).length*v_ref*(-0.5*snake.link(i).length*nu2(3)+snake.link(i).length^2*nu2(5)/3);
            D(6,3,i)=rho*snake.r*dx*snake.link(i).length*trapz(sqrtx.*(nu2(2)*x+nu2(6)*x.^2));
            D(6,4,i)=rho*snake.r*snake.link(i).length*v_ref*(0.5*snake.link(i).length*nu2(2)+snake.link(i).length^2*nu2(6)/3);
          
     end

          g   = g + J(:,:,i)'*snake.link(i).G*R(:,:,i)'*pp.gdir;
 end
end