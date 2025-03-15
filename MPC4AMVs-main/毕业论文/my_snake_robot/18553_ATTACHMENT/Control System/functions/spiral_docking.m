
%% Create docking path

%Starting point
x0 = -20;
y0 = 20;

r_0 = sqrt(x0^2 + y0^2);
phi_0 = atan2(y0,x0);

%r_0 = 20;
%phi_0 = pi/3;
p_0 = [r_0; phi_0];
theta_max = pi/3;

%Identify the parameter theta <= theta_max (field of view)
d = 15;
p1 = [d; 0];
theta = atan(phi_0/log(r_0/d));

%Find the value of the scaling factor a
a = r_0/sqrt( sinh(2*phi_0/tan(theta)) );

%Plot the curve
if phi_0 > 0
    phi = 0:0.01:phi_0;
else
    phi = phi_0:0.01:0;
end

r = a*sqrt(sinh(2.*phi/tan(theta)));
f = figure();
set(f, 'Color', 'White', 'Units', 'centimeters', 'Pos', [5 10 10 10]);
polarplot(phi,r);

%% Generate waypoints
n = 20;

%By radius
i = 0:n-1;
r_wp = r_0*((n-i)/n);
phi_wp = tan(theta)/2*asinh(r_wp.^2/a^2);
%By angle
% arc_segment = abs(phi_0/n);
% if phi_0 > 0
%     phi_wp = 0:arc_segment:phi_0;
% else
%     phi_wp = phi_0:arc_segment:0;
% end
% r_wp = a*sqrt(sinh(2.*phi_wp/tan(theta)));

%Plot
hold on;
polarscatter(phi_wp, r_wp)

x_wp = zeros(1,n);
y_wp = zeros(1,n);
z_wp = ones(1,n + 1)*-180;
for i = 1:n
    x_wp(i) = r_wp(i)*cos(phi_wp(i));
    y_wp(i) = r_wp(i)*sin(phi_wp(i));
end

dist_wp = zeros(1,n-1);
for i = 1:n-1
    dist_wp(i) = sqrt( (x_wp(i) - x_wp(i + 1))^2 + (y_wp(i) - y_wp(i + 1))^2 );
end
R_wp = ones(1,n)*min(dist_wp)*0.5;
waypoints = [x_wp 0;
             y_wp 0;
             z_wp;
             R_wp 0;];

save('spiralWP.mat', 'waypoints');



 