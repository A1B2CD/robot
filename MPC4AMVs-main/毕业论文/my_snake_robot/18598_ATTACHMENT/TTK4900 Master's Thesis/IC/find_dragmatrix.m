function D = find_dragmatrix(zeta1,nu1,nu2,rho,snake,beta,gamma)

%D*vector =[C_d_1 C_d_4 C_d_C C_d_L]' is equal to what is
%computed by the drag() function
slices = 10;
x   = linspace(0,1,slices);
dx  = x(2)-x(1);
sqrtx   =  sqrt(nu1(2)^2+nu1(3)^2+x.^2*nu1(5)^2+x.^2*nu1(6)^2+2*x*nu1(2)*nu1(6)-2*x*nu1(3)*nu1(5));

xi = zeros(6,1);
v_ref = 1;
D=zeros(6,4,snake.n);
for i=1:snake.n
if snake.link(i).dragtype==1
    D(:,:,i)=zeros(6,4);
else
    
    if i>1
        twist    = snake.joint(i-1).twist;            
        Adinv    = Ad_inv(A);                       
        ad_tw    = ad(twist); 
        nu1      = Adinv*nu1 + twist*zeta1(6+i-1);
        nu2   = nu1;
        xi       = -ad_tw*zeta1(6+i-1)*nu2 + Adinv*xi;
    end
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

end

end

