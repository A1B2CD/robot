function out = drag(nu1,nu2,l,rho,r,dragcoeff)
%This function computes the drag wrench D(nu1)nu2 for a link.
slices = 10;
x   = linspace(0,1,slices);
dx  = x(2)-x(1);
d_N = zeros(6,1);
d_L = d_N;

v_ref = 1;

C_d_1 = dragcoeff(1);
C_d_4 = dragcoeff(2);
C_d_C = dragcoeff(3);

C_d_L = dragcoeff(4);
beta  = dragcoeff(5);
gamma = dragcoeff(6);

d_N(1)  = .5*rho*pi*r^2*C_d_1*abs(nu1(1))*nu2(1); 
d_N(4)  = .5*rho*pi*l*r^4*C_d_4*abs(nu1(4))*nu2(4);

sqrtx   =  sqrt(nu1(2)^2+nu1(3)^2+x.^2*nu1(5)^2+x.^2*nu1(6)^2+2*x*nu1(2)*nu1(6)-2*x*nu1(3)*nu1(5));

k_N     =  rho*r*dx*C_d_C*l;
d_N(2)  =  k_N*trapz(sqrtx.*(nu2(2)+nu2(6)*x));
d_N(3)  =  k_N*trapz(sqrtx.*(nu2(3)-nu2(5)*x));
d_N(5)  =  k_N*trapz(sqrtx.*(-nu2(3)*x+nu2(5)*x.^2));
d_N(6)  =  k_N*trapz(sqrtx.*(nu2(2)*x+nu2(6)*x.^2));

k_L     = rho*r*l*C_d_L*v_ref;
d_L(1)  = k_L*beta*nu2(1);
d_L(2)  = k_L*(nu2(2)+0.5*l*nu2(6));
d_L(3)  = k_L*(nu2(3)-0.5*l*nu2(5));
d_L(4)  = k_L*gamma*r^2*nu2(4);
d_L(5)  = k_L*(-0.5*l*nu2(3)+l^2*nu2(5)/3);
d_L(6)  = k_L*(0.5*l*nu2(2)+l^2*nu2(6)/3);

out= d_N + d_L;
end
%Added Mass

