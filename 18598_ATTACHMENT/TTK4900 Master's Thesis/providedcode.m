%This is a simple smiulator for an underwater snake-like robot. The code is
%not optimized for speed and there may still be bugs. Please report back to
%me if you find anything fishy :)
%
%Henrik

%clc;
clear all
close all
%% Define Simulation Parameters
   Tmax          = 100;
   deltaT_interp = 1;                     %Time step size for the interpolated solution
  
   snake.link_vec  = [2 1 2 1 3 1 2 1 2];         %The links the snake consists of, from head to tail
   snake.joint_vec = [2 3 2 3 3 2 3 2];           %The type of joints, from head to tail
   snake.n         = length(snake.link_vec);
   snake.r         = 0.1;                   %Link radius
   
   y_0             = zeros(11+2*snake.n,1); %Initial conditions
   y_0(4)          = 1;                     %"zero" quaternion
%% Define Physical Parameters
pp.denw = 1000;         %density of water
pp.grav = 9.81;         %gravitational acceleration
pp.velc = [0 0 0]';    %constant irrotational current velocity, inertial frame
pp.gdir = [0 0 -1]';    %direction of gravity in inertial frame (pointing towards ground, unit vector

   C_a_C   =   1; % Added mass coefficient for the cross section, 1 is the theoretical inviscid result
   C_d_1   =  .2; % nonlinear drag coefficient in surge
   C_d_4   =  .1; % nonlinear drag coefficient in the roll direction for the cross-section
   C_d_C   =  .8; % nonlinear crossflow drag coefficient
   C_d_L   =  .1;% Linear cross-sectional drag coefficient
   alpha   =  .2; % Added mass ratio in surge/heave for a link
   beta    =  .1; % Linear drag parameter in surge
   gamma   =  .1; % Linear drag parameter in roll
   
   masscoeff = [C_a_C, alpha];
   dragcoeff = [C_d_1, C_d_4, C_d_C, C_d_L, beta, gamma];
%% Define Link Properties

%Link 1
link(1).name = 'link in cardan joints';
link(1).length = .02;
link(1).mass = 0;
link(1).vol = link(1).mass/pp.denw;
link(1).r_grav = zeros(3,1);
link(1).r_buoy = zeros(3,1);
link(1).M_R  = zeros(6);
link(1).M_A  = zeros(6);
link(1).drag = @(x,y)zeros(6,1);
link(1).n_thruster = 0;

%Link 2
link(2).name = 'y,z thruster symmetric link';
link(2).length = .75;
link(2).vol = pi*link(2).length*snake.r^2;
link(2).mass = link(2).vol*pp.denw;
link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0.5]'*snake.r;
link(2).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;
link(2).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass);
link(2).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff);
link(2).drag = @(x,y)drag(x,y,link(2).length,pp.denw,snake.r,dragcoeff);
link(2).n_thruster = 2;
link(2).t_thrust     = [ [0 1 0]' [0 0 1]'];
link(2).r_thrust     = [ [0.5 0 0]' [0.5 0 0]']*link(2).length;

%Link 3
link(3).name = 'x,x thruster middle symmetric link';
link(3).length = 1;
link(3).vol = pi*link(3).length*snake.r^2;
link(3).mass = link(3).vol*pp.denw;
link(3).r_grav = [0.5 0 0]'*link(3).length - [0 0 0.5]'*snake.r;
link(3).r_buoy = [0.5 0 0]'*link(3).length + [0 0 0]'*snake.r;
link(3).M_R  = RBmass(link(3).r_grav,snake.r,link(3).length,link(3).mass);
link(3).M_A  = slendermass(link(3).length,pp.denw,snake.r,masscoeff);
link(3).drag = @(x,y)drag(x,y,link(3).length,pp.denw,snake.r,dragcoeff);
link(3).n_thruster   = 2;
link(3).t_thrust     = [ [1 0 0]' [1 0 0]'];
link(3).r_thrust     = [ [0 1.5 0]' [0 -1.5 0]']*snake.r;
%% Define Joint Properties

%Joint 1
joint(1).name  = 'x revolute';
joint(1).twist = [0 0 0 1 0 0]';
joint(1).rot   = @(x)[1   0        0;
                      0  cos(x) -sin(x);
                      0  sin(x)  cos(x)];
%Joint 2
joint(2).name  = 'y revolute';
joint(2).twist = [0 0 0 0 1 0]';
joint(2).Rot   = @(x)[ cos(x) 0  sin(x);
                       0      1  0;
                      -sin(x) 0  cos(x)];
%Joint 3
joint(3).name  = 'z revolute';
joint(3).twist = [0 0 0 0 0 1]';
joint(3).Rot   = @(x)[cos(x) -sin(x)  0;
                      sin(x)  cos(x)  0;
                      0       0       1];
%% Build Snake
m=0;
for i = 1 : snake.n
   %Build Links
   clink = link(snake.link_vec(i));
   snake.link(i).name   = clink.name;
   snake.link(i).length = clink.length;
   snake.link(i).M      = clink.M_R*2+clink.M_A;
   snake.link(i).drag   = clink.drag;
   snake.link(i).n_thruster = clink.n_thruster;
   
   w = clink.mass*pp.grav;
   b = clink.vol*pp.denw*pp.grav;
   snake.link(i).G = [(b-w)*eye(3); b*skew(clink.r_buoy)-w*skew(clink.r_grav)];
   
   m = m + clink.n_thruster;
   if clink.n_thruster > 0
   snake.link(i).B = [clink.t_thrust; cross(clink.r_thrust,clink.t_thrust)];
   else
   snake.link(i).B = [];
   end
   %Build Joints
   if i < snake.n
    cjoint = joint(snake.joint_vec(i));
    snake.joint(i).twist = cjoint.twist;
    snake.joint(i).A     =@(x)[cjoint.Rot(x), [clink.length 0 0]';
                               [0 0 0 1]];
   end
end
snake.n_thruster_tot = m;
clear w b clink cjoint m i C_a_C C_d_C C_d_1 C_d_4 C_d_L alpha beta gamma
%% Simulate
   [T, simout]   = ode45(@(t,x)dyn(t,x,snake,pp),[0 Tmax], y_0);
%% Post Process/Show Movie
   Tinterp      = 0 : deltaT_interp : Tmax;
   simout_int   = interp1(T,simout,Tinterp);
   [X, Y, Z]    = snake2points(simout_int,snake);
   mov          = animatesnake(X,Y,Z,snake);
   
   
   %boxdim = [-3 3 -3 3 -3 3];
   %[~,~] = snakeplot(X(end,:),Y(end,:),Z(end,:),boxdim,true,snake,true,'on');
   
   fig = figure;
   movie(fig,mov,50)  
   
%% Functions
% Dynamics
function x_dot = dyn(t,x,snake,pp)
%Get states
pos       =  x(1:3);
quat      =  x(4:7);
theta     =  x(8 : 6+snake.n);
zeta      =  x(7+snake.n : 11+2*snake.n);

%Compute rotation matrices and jacobians
[R, J]    =  comp_rot_jac(quat,theta,snake);
%Compute mass matrix
M         =  comp_mass(J,snake);

%Compute relative velocity to take into account the effect of current
velc_h    =  R(:,:,1)'*pp.velc;
nu        =  zeta(1:6);
zeta(1:3) =  zeta(1:3)-velc_h;

%Compute coriolis, drag, and hydrostatic terms with the relative velocity
[c, d, g] =  comp_cdg(J,R,theta,snake,pp,zeta);
%Compute the thrust-configuration matrix
B         =  comp_TCM(J,snake);

%testing with a swimming gait
    phaseramp = .4*pi;
    phase  = linspace(0,(snake.n-2)*phaseramp,snake.n-1)';
    omega  = .8;
    amp    = pi/4;   
    thetad     = 0*amp*sin(omega*t-phase);
    theta_dotd = 0*amp*omega*cos(omega*t-phase);
    thrust     = zeros(snake.n_thruster_tot,1);
    thrust(5)=1;
    thrust(6)=1;
    Kp = 100;
    Kd = 100;
    joint_torque = - Kp*[zeros(6,1); theta-thetad]- Kd*[zeros(6,1); zeta(7:snake.n+5)-theta_dotd]; %PD-controller
%

%Compute the relative acceleration
zeta_dot      =  M\(B*thrust+joint_torque-c-d-g);
%Remove the effect of current
zeta_dot(1:3) = zeta_dot(1:3)-cross(nu(4:6),velc_h);
%Compute the time derivatives of position and orientation
pos_dot   =  R(:,:,1)*nu(1:3);  
quat_dot  =  TransAngQ(quat)*nu(4:6)+1*(1-quat'*quat)*quat; 
%Assemble derivative of the state vector
x_dot = [pos_dot ; quat_dot ; zeta(7:snake.n+5) ; zeta_dot];
end

function varargout = comp_rot_jac(quat,theta,snake)
%This function computes the rotation matrices and body-jacobians for the
%snake robot.
rot = zeros(3,3,snake.n);
rot(:,:,1) = RotQ(quat);

nout = nargout;
 if nout == 2
    jac = zeros(6,5+snake.n,snake.n);
    jac(1:6,1:6,1) = eye(6);
 end

 for i = 2:snake.n
    j              = i-1;                             
    A              = snake.joint(j).A(theta(j));            
    rot(:,:,i)     = rot(:,:,i-1)*A(1:3,1:3);
    
    if nout == 2
        jac(:,:,i)   = Ad_inv(A)*jac(:,:,i-1);
        jac(:,6+j,i) = snake.joint(j).twist;
    end
 end
 if nout == 1
     varargout = rot;
 elseif nout == 2
     varargout = cell(1,2);
     varargout{1} = rot;
     varargout{2} = jac;
 end
 
end

function out = comp_mass(J,snake)
%This function computes the mass matrix of the snake
out = J(:,:,1)'*snake.link(1).M*J(:,:,1);
  for i = 2:snake.n
      out = out + J(:,:,i)'*snake.link(i).M*J(:,:,i);
  end
end

function varargout = comp_cdg(J,R,theta,snake,pp,zeta1,zeta2)
%This function computes the terms c=C(theta,zeta1)zeta2,
%d=D(theta,zeta1)zeta2, and g(eta,theta), i.e. the coriolis, drag and
%hydrostatic forces on the snake. The sign-convention is such that these
%enter the equation of motion on the left-hand side, i.e. the actual force
%in terms of newton's laws is what this script puts out times -1.
nout = nargout;
nin  = nargin;

nu1 = zeta1(1:6);
if nin == 7
nu2 = zeta2(1:6);
else
   nu2 = nu1;
end
    c  = -J(:,:,1)'*W(snake.link(1).M*nu1)*nu2;
xi = zeros(6,1);
 if nout > 1
    d  = J(:,:,1)'*snake.link(1).drag(nu1,nu2);
 end
 if nout > 2
    g  = J(:,:,1)'*snake.link(1).G*R(:,:,1)'*pp.gdir;
 end

 for i=2:snake.n
     j=i-1;
     A        = snake.joint(j).A(theta(j));          
     twist    = snake.joint(j).twist;            
     Adinv    = Ad_inv(A);                       
     ad_tw    = ad(twist); 
     nu1      = Adinv*nu1 + twist*zeta1(6+j);
      if nin  == 7
        nu2   = Adinv*nu2 + twist*zeta2(6+j);
      else
        nu2   = nu1;
      end
     xi       = -ad_tw*zeta1(6+j)*nu2 + Adinv*xi;
     M        = snake.link(i).M;
     
     c        = c + J(:,:,i)'*(M*xi - W(M*nu1)*nu2);
      if nout > 1
          d   = d + J(:,:,i)'*snake.link(i).drag(nu1,nu2);
      end
      if nout > 2
          g   = g + J(:,:,i)'*snake.link(i).G*R(:,:,i)'*pp.gdir;
      end
 end
 if nout == 1
     varargout = c;
 elseif nout == 2
     varargout = cell(1,2);
     varargout{1} = c;
     varargout{2} = d;
 elseif nout == 3
     varargout = cell(1,3);
     varargout{1} = c;
     varargout{2} = d;
     varargout{3} = g;
 end

end

function out = comp_TCM(J,snake)
%This function computes the thrust-configuration matrix for the robot. 
out          = zeros(5+snake.n,snake.n_thruster_tot); 
m            = snake.link(1).n_thruster;
out(:,1:m)   = J(:,:,1)'*snake.link(1).B; 

 for i = 2:snake.n
     if snake.link(i).n_thruster > 0
        m = m + snake.link(i).n_thruster;
        out(:,m+1-snake.link(i).n_thruster:m) = J(:,:,i)'*snake.link(i).B;
    end
 end
end


% Drag
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
function out = slendermass(l,rho,r,masscoeff)
C_a_C = masscoeff(1);
alpha = masscoeff(2);

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

out=out*rho*pi*r^2*C_a_C;
end
%Rigid Body Mass
function out = RBmass(r_g,r,l,m)
% Computes the rigid body mass matrix of a uniform cylinder with a rod
% placed at the bottom to put the center of gravity in the right place. At
% the moment the center of gravity must be placed at x=0.5l y=0. Only the
% z-value is affected by the rod

    d   = r_g(3);
    m_r = abs(d)/r*m;
    m_c = m-m_r;
    
    I_c = m_c*diag([0.5*r^2,0.25*r^2+l^2/3,0.25*r^2+l^2/3]);
    I_r = m_r*[d^2, 0, -0.5*l*d;0, d^2+l^2/3, 0;-0.5*l*d, 0 , l^2/3];
    I_R = I_c + I_r;
    
    out = [m*eye(3), -m*skew(r_g);
           m*skew(r_g), I_R];
end

% Kinematic Control Algorithm

% Dynamic Control Algorithm 

% Various Post Processing
function [fig, h] = snakeplot(X_t,Y_t,Z_t,boxdim,center,snake,projection,visible)

ax = boxdim;

if center
    X_t_avg = sum(X_t)/(snake.n+1);
    Y_t_avg = sum(Y_t)/(snake.n+1);
    Z_t_avg = sum(Z_t)/(snake.n+1);
    ax(1:2) = ax(1:2) + X_t_avg;
    ax(3:4) = ax(3:4) + Y_t_avg;
    ax(5:6) = ax(5:6) + Z_t_avg;   
end

fig = figure('visible',visible);
if projection
    hold on
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'k','LineWidth',3,'linestyle','-')
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'k','marker','.','markersize',3)
    
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'k','LineWidth',3,'linestyle','-')
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'k','marker','.','markersize',3)
    
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'k','LineWidth',3,'linestyle','-')
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'k','marker','.','markersize',3)
end

h=plot3t(X_t,Y_t,Z_t,snake.r,'gr',20);
% Shade the line
set(h, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);
% Set figure rotation
view(3); axis(ax);
grid on
% Set the material to shiny and enable light
material shiny; light('position',[0 0 1 ]);
hold off

end
%
function out = animatesnake(X,Y,Z,snake)
    boxdim = [-3 3 -3 3 -3 3 ];
    center = true;
    projection = true;
    visible = 'off';
    [row, ~] = size(X);
    out(row) = struct('cdata',[],'colormap',[]);
 for i = 1:row
    [fig, ~] = snakeplot(X(i,:),Y(i,:),Z(i,:),boxdim,center,snake,projection,visible);
    out(i) = getframe(fig);
    close all hidden
    disp(num2str(i/row*100))
 end

end
%
function [X, Y, Z] = snake2points(simout,snake)
   pos          = simout(:,1:3);
   quat         = simout(:,4:7);
   theta        = simout(:,8 : 6+snake.n);

   [row, ~]   = size(pos);
   X          = zeros(row,snake.n+1);
   Y          = zeros(row,snake.n+1);
   Z          = zeros(row,snake.n+1);
   for i = 1:row
    Rot_t  = RotQ(quat(i,:));
    pos_t  = pos(i,:);
    H_t    =  [[Rot_t, pos_t'];[0 0 0 1]];
    X(i,1) =  pos_t(1);
    Y(i,1) =  pos_t(2);
    Z(i,1) =  pos_t(3);
    for j=1:snake.n-1
        H_t = H_t*snake.joint(j).A(theta(i,j));
        pos_t = H_t(1:3,4);
        X(i,j+1) = pos_t(1);
        Y(i,j+1) = pos_t(2);
        Z(i,j+1) = pos_t(3);
    end
    pos_t = H_t*[snake.link(snake.n).length,0,0,1]';
    X(i,end) = pos_t(1);
    Y(i,end) = pos_t(2);
    Z(i,end) = pos_t(3);
   end
end
%Used for plotting, not my code.
function hiso=plot3t(varargin)
% PLOT3T Plots a (cylindrical) 3D line with a certain thickness.
%
%   h = plot3t(x,y,z,r,'color',n);
%
%   PLOT3T(x,y,z), where x, y and z are three vectors of the same length,
%   plots a line in 3-space through the points whose coordinates are the
%   elements of x, y and z. With a radius of one and face color blue.
%
%   x,y,z: The line coordinates. If the first line point equals the
%      last point, the line will be closed.
%
%   r: The radius of the line (0.5x the thickness). Can be defined
%       as a single value (default 1), or as vector for every line 
%       coordinate.
%
%   'color': The color string, 'r','g','b','c','m','y','k' or 'w'
%
%
%   n: The number of vertex coordinates used to define the circle/cylinder
%      around the line (default 12). Choosing 2 will give a flat 3D line,
%      3 a triangulair line, 4 a squared line.
%       
%   h: The handle output of the patch element displaying the line. Can be 
%      used to shade the 3D line, see doc Patch Properties
%
%   Example:
%      % Create a figure window
%       figure, hold on;
%      % x,y,z line coordinates
%       x=60*sind(0:20:360); y=60*cosd(0:20:360); z=60*cosd((0:20:360)*2); 
%      % plot the first line
%       h=plot3t(x,y,z,5);
%      % Shade the line
%       set(h, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);
%      % Set figure rotation
%       view(3); axis equal;
%      % Set the material to shiny and enable light
%       material shiny; camlight;
%      % Plot triangular line 
%       h=plot3t(y*0.5,x*0.5,z*0.5,3,'r',3);
%       set(h,'EdgeColor', [0 0 0]);
%      % varying radius of line
%       r=[4 8 4 8 4 8 4 8 4 8 4 8 4 8 4 8 4 8 4];
%      % Plot a flat 3D line
%       plot3t(y*1.2,z*1.2,x*1.2,r,'c',2);
%
% This function is written by D.Kroon University of Twente (August 2008)

% Check Input Arguments
if(length(varargin)<3), error('Not enough input arguments'), end

% Process input : line coordinates
linex=varargin{1}; liney=varargin{2}; linez=varargin{3};
if(~(sum((size(linex)==size(liney))&(size(linex)==size(linez)))==2)),
    error('Input variables x,y,z are not equal in length or no vectors'), end
if(size(linex,1)>1), linex=linex'; end
if(size(liney,1)>1), liney=liney'; end
if(size(linez,1)>1), linez=linez'; end
line=[linex;liney;linez]';

% Process input : radius of plotted line
if(length(varargin)>3), 
    radius=varargin{4}; 
    if(length(radius)==1), radius=ones(size(linex))*radius; end
else
    radius=ones(size(linex));
end

% Process input : color string
if(length(varargin)>4), 
    switch(varargin{5})
        case {'r'}, icolor=[1 0 0];
        case {'g'}, icolor=[0 1 0];
        case {'b'}, icolor=[0 0 1];
        case {'c'}, icolor=[0 1 1];
        case {'m'}, icolor=[1 0 1];
        case {'y'}, icolor=[1 1 0];
        case {'k'}, icolor=[0 0 0];
        case {'w'}, icolor=[1 1 1];
        case {'gr'}, icolor=[.8 .8 .8];
    otherwise
        error('Invalid color string');
    end
else
    icolor=[0 0 1];
end

% Process input : number of circle coordinates
if(length(varargin)>5),
    vertex_num=varargin{6};
else
    vertex_num=12;
end

% Calculate vertex points of 2D circle
angles=0:(360/vertex_num):359.999;

% (smooth cylinder) Buffer distance between two line pieces.
bufdist=max(radius);
linel=sqrt((line(2:end,1)-line(1:end-1,1)).^2+(line(2:end,2)-line(1:end-1,2)).^2+(line(2:end,3)-line(1:end-1,3)).^2);
if((min(linel)/2.2)<bufdist), bufdist=min(linel)/2.2; end

% Check if the plotted line is closed
lclosed=line(1,1)==line(end,1)&&line(1,2)==line(end,2)&&line(1,3)==line(end,3);

% Calculate normal vectors on every line point
if(lclosed)
    normal=[line(2:end,:)-line(1:end-1,:);line(2,:)-line(1,:)];
else
    normal=[line(2:end,:)-line(1:end-1,:);line(end,:)-line(end-1,:)];
end
normal=normal./(sqrt(normal(:,1).^2+normal(:,2).^2+normal(:,3).^2)*ones(1,3));

% Create a list to store vertex points
FV.vertices=zeros(vertex_num*length(linex),3);

% In plane rotation of 2d circle coordinates
jm=0;

% Number of triangelized cylinder elements added to plot the 3D line
n_cylinders=0; 

% Calculate the 3D circle coordinates of the first circle/cylinder
[a,b]=getab(normal(1,:));
circm=normal_circle(angles,jm,a,b);

% If not a closed line, add a half sphere made by 5 cylinders add the line start.
if(~lclosed)
    for j=5:-0.5:1
        % Translate the circle on it's position on the line
        r=sqrt(1-(j/5)^2); 
        circmp=r*radius(1)*circm+ones(vertex_num,1)*(line(1,:)-(j/5)*bufdist*normal(1,:));
        % Create vertex list
        n_cylinders=n_cylinders+1;
        FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
    end
end

% Make a 3 point circle for rotation alignment with the next circle
circmo=normal_circle([0 120 240],0,a,b);  

% Loop through all line pieces.
for i=1:length(linex)-1,
% Create main cylinder between two line points which consists of two connect
% circles.
  
    pnormal1=normal(i,:); pline1=line(i,:);
    
    % Calculate the 3D circle coordinates
    [a,b]=getab(pnormal1);
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(i)+ones(vertex_num,1)*(pline1+bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
  
    pnormal2=normal(i+1,:); pline2=line(i+1,:);
       
    % Translate the circle on it's position on the line
    circmp=circm*radius(i+1)+ones(vertex_num,1)*(pline2-bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];

% Create in between circle to smoothly connect line pieces.

    pnormal12=pnormal1+pnormal2; pnormal12=pnormal12./sqrt(sum(pnormal12.^2));
    pline12=0.5858*pline2+0.4142*(0.5*((pline2+bufdist*pnormal2)+(pline2-bufdist*pnormal1)));  
  
    % Rotate circle coordinates in plane to align with the previous circle
    % by minimizing distance between the coordinates of two circles with 3 coordinates.
    [a,b]=getab(pnormal12);
    jm = fminsearch(@(j)minimize_rot([0 120 240],circmo,j,a,b),jm);              
    
    % Keep a 3 point circle for rotation alignment with the next circle
    [a,b]=getab(pnormal12);
    circmo=normal_circle([0 120 240],jm,a,b);   
    
    % Calculate the 3D circle coordinates
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(i+1)+ones(vertex_num,1)*(pline12);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];

    % Rotate circle coordinates in plane to align with the previous circle
    % by minimizing distance between the coordinates of two circles with 3 coordinates.
    [a,b]=getab(pnormal2);
    jm = fminsearch(@(j)minimize_rot([0 120 240],circmo,j,a,b),jm);              
    
    % Keep a 3 point circle for rotation alignment with the next circle
    circmo=normal_circle([0 120 240],jm,a,b);    
end

% If not a closed line, add a half sphere made by 5 cylinders add the
% line end. Otherwise add the starting circle to the line end.
if(~lclosed)
    for j=1:0.5:5
        % Translate the circle on it's position on the line
        r=sqrt(1-(j/5)^2);
        circmp=r*radius(i+1)*circm+ones(vertex_num,1)*(line(i+1,:)+(j/5)*bufdist*normal(i+1,:));
        % Create vertex list
        n_cylinders=n_cylinders+1;
        FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];
    end
else
    i=i+1;
    pnormal1=normal(i,:); pline1=line(i,:);
    
    % Calculate the 3D circle coordinates
    [a,b]=getab(pnormal1);
    circm=normal_circle(angles,jm,a,b);
    
    % Translate the circle on it's position on the line
    circmp=circm*radius(1)+ones(vertex_num,1)*(pline1+bufdist*pnormal1);

    % Create vertex list
    n_cylinders=n_cylinders+1;
    FV.vertices(((n_cylinders-1)*vertex_num+1):(n_cylinders*vertex_num),:)=[circmp(:,1) circmp(:,2) circmp(:,3)];   
end

% Faces of one meshed line-part (cylinder)
Fb=[[1:vertex_num (1:vertex_num)+1];[(1:vertex_num)+vertex_num (1:vertex_num)];[(1:vertex_num)+vertex_num+1 (1:vertex_num)+vertex_num+1]]'; 
Fb(vertex_num,3)=1+vertex_num; Fb(vertex_num*2,1)=1; Fb(vertex_num*2,3)=1+vertex_num;

% Create TRI face list
FV.faces=zeros(vertex_num*2*(n_cylinders-1),3);
for i=1:n_cylinders-1,
    FV.faces(((i-1)*vertex_num*2+1):((i)*vertex_num*2),1:3)=(Fb+(i-1)*vertex_num);
end

% Display the polygon patch
hiso=patch(FV,'Facecolor', icolor, 'EdgeColor', 'none');

function [err,circm]=minimize_rot(angles,circmo,angleoffset,a,b)
    % This function calculates a distance "error", between the same
    % coordinates in two circles on a line. 
    [circm]=normal_circle(angles,angleoffset,a,b);
    dist=(circm-circmo).^2;
    err=sum(dist(:));
end
function [a,b]=getab(normal)
    % A normal vector only defines two rotations not the in plane rotation.
    % Thus a (random) vector is needed which is not orthogonal with 
    % the normal vector.
    randomv=[0.57745 0.5774 0.57735]; 

    % This line is needed to prevent the case of normal vector orthogonal with
    % the random vector. But is now disabled for speed...
    if(sum(abs(cross(randomv,normal)))<0.001), randomv=[0.58 0.5774 0.56]; end
    
    % Calculate 2D to 3D transform parameters
    a=normal-randomv/(randomv*normal'); a=a/sqrt(a*a');     
    b=cross(normal,a); b=b/sqrt(b*b');
end
function [X,a,b]=normal_circle(angles,angleoffset,a,b)
    % This function rotates a 2D circle in 3D to be orthogonal 
    % with a normal vector.

    % 2D circle coordinates.
    circle_cor=[cosd(angles+angleoffset);sind(angles+angleoffset)]';
    
    X = [circle_cor(:,1).*a(1) circle_cor(:,1).*a(2) circle_cor(:,1).*a(3)]+...
         [circle_cor(:,2).*b(1) circle_cor(:,2).*b(2) circle_cor(:,2).*b(3)];
end
end
%Other
function out = skew(x)
out = [0 -x(3) x(2) ; x(3) 0 -x(1) ; -x(2) x(1) 0 ];
end
function out = Ad_inv(X)
R = X(1:3,1:3);
r = skew(X(1:3,4));
out = [R',-R'*r; zeros(3) ,R'];
end
function out = ad(x)
v = skew(x(1:3));
w = skew(x(4:6));
out = [w v;zeros(3) w];
end
function out = W(x)
v =   skew(x(1:3));
w =   skew(x(4:6));
out = [zeros(3),v;v,w]; 
end
function out = RotQ(x)
S = skew(x(2:4));
out = eye(3) + 2*x(1)*S + 2*S*S;
end
function out = TransAngQ(x)
out = 0.5*[-x(2:4)'; x(1)*eye(3)+skew(x(2:4))];
end
