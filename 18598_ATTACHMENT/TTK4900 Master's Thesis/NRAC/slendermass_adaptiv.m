function out = slendermass_adaptiv(l,rho,r,alpha)

out = zeros(6);
out(1,1) = alpha*l;
out(2,2) = l;
out(3,3) = l;
out(5,5) = l^3/3;
out(6,6) = l^3/3;
out(3,5) = -0.5*l^2;
out(5,3) = -0.5*l^2;
out(2,6) = 0.5*l^2;
out(6,2) = 0.5*l^2;

out=out*rho*pi*r^2;
end
%Rigid Body Mass