%% Define Link Properties
% Drag = 0 (no drag), drag = 1 (compute drag)

%Link 1, base module (tether + camera), module nr. 1.
link(1).name = '1';%'base module';
link(1).length = 0.62;
link(1).vol = 0.0143;   %体积
link(1).mass = link(1).vol*pp.denw;   %体积*水密度
link(1).r_grav = [0.5 0 0]'*link(1).length - [0 0 0.5]'*snake.r;   % 表示 重心的位置 (x,y,z)  相对于固定坐标系
%浮力与重力的不同：重力作用点（重心）的计算可能考虑了连杆的实际质量分布，特别是如果连杆的密度不是均匀的，或者连杆的形状导致质量分布不均。
%在这种情况下，重心可能不会位于连杆的几何中心。
%而浮心的计算通常假设连杆完全浸没在水中，且连杆的体积分布是均匀的，因此浮心通常位于连杆的几何中心
link(1).r_buoy = [0.5 0 0]'*link(1).length + [0 0 0]'*snake.r; %[1.4 0 0]';  %
link(1).M_R  = RBmass(link(1).r_grav,snake.r,link(1).length,link(1).mass); %Rigid body mass  刚体质量: r_grv length  mass
link(1).M_A  = slendermass(link(1).length,pp.denw,snake.r,masscoeff); %Added mass  附加质量 : length 水密度 半径  附加质量系数矩阵
link(1).drag = 1;
link(1).n_thruster = 0;   %推进器数量 0
link(1).t_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thurster axis 推进器方向 没有推进器 所以 无轴   因为推进器最多的是3 个,所以3维数组
link(1).r_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thruster position 推进器位置

%Link 2, coupling 1, 2, 3 and 4, module nr. 2, 4, 6, 8.
link(2).name = '2';%'coupling without thursters';
link(2).length = 0.104;
link(2).vol = 0.006; 
link(2).mass = link(2).vol*pp.denw;
link(2).r_grav = [0.5 0 0]'*link(2).length - [0 0 0.5]'*snake.r;
link(2).r_buoy = [0.5 0 0]'*link(2).length + [0 0 0]'*snake.r;%[-1.5 0 0]';
link(2).M_R  = RBmass(link(2).r_grav,snake.r,link(2).length,link(2).mass); %Rigid body mass
link(2).M_A  = slendermass(link(2).length,pp.denw,snake.r,masscoeff); %Added mass
link(2).drag = 1;
link(2).n_thruster = 0;
link(2).t_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thurster axis
link(2).r_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thruster position

%Link 3, double module back, module nr. 3.
link(3).name = '3';%'double module back';
link(3).length = 0.584;
link(3).vol = 0.0127; 
link(3).mass = link(3).vol*pp.denw;
link(3).r_grav = [0.5 0 0]'*link(3).length - [0 0 0.5]'*snake.r;
link(3).r_buoy = [0.5 0 0]'*link(3).length + [0 0 0]'*snake.r;%[1.6 0 0]';
link(3).M_R  = RBmass(link(3).r_grav,snake.r,link(3).length,link(3).mass); %Rigid body mass
link(3).M_A  = slendermass(link(3).length,pp.denw,snake.r,masscoeff); %Added mass
link(3).drag = 1;
link(3).n_thruster = 2;
link(3).t_thrust     = [[0 0 1]' [0 1 0]' [0 0 0]']; %Thurster axis
link(3).r_thrust     = [[0.237 0 0]' [0.347 0 0]' [0 0 0]']; %Thruster position

%Link 4, center module, module nr. 5. 
link(4).name = '4';%'center module';
link(4).length = 0.726;
link(4).vol = 0.0098; 
link(4).mass = link(4).vol*pp.denw;
link(4).r_grav = [0.5 0 0]'*link(4).length - [0 0 0.5]'*snake.r;
link(4).r_buoy = [0.5 0 0]'*link(4).length + [0 0 0]'*snake.r;%[0.3 0 0]';
link(4).M_R  = RBmass(link(4).r_grav,snake.r,link(4).length,link(4).mass); %Rigid body mass
link(4).M_A  = slendermass(link(4).length,pp.denw,snake.r,masscoeff); %Added mass
link(4).drag = 1;
link(4).n_thruster = 3;
link(4).t_thrust     = [ [1 0 0]' [1 0 0]' [0 0 1]']; %Thurster axis
link(4).r_thrust     = [ [0.278 -0.1 0]' [0.278 0.1 0]' [0.488 0 0]']; %Thruster position

%Link 5, double module front, module nr. 7
link(5).name = '5';%'double module front';
link(5).length = 0.584;
link(5).vol = 0.0127;
link(5).mass = link(5).vol*pp.denw;
link(5).r_grav = [0.5 0 0]'*link(5).length - [0 0 0.5]'*snake.r;
link(5).r_buoy = [0.5 0 0]'*link(5).length + [0 0 0]'*snake.r;%[1.6 0 0]';
link(5).M_R  = RBmass(link(5).r_grav,snake.r,link(5).length,link(5).mass); %Rigid body mass
link(5).M_A  = slendermass(link(5).length,pp.denw,snake.r,masscoeff); %Added mass
link(5).drag = 1;
link(5).n_thruster = 2;
link(5).t_thrust     = [ [0 1 0]' [0 0 1]' [0 0 0]']; %Thurster axis
link(5).r_thrust     = [ [0.237 0 0]' [0.347 0 0]' [0 0 0]']; %Thruster position

%Link 6, front module, module nr. 9.
link(6).name = '6';%'front module';
link(6).length = 0.37;
link(6).vol = 0.0078; 
link(6).mass = link(6).vol*pp.denw;
link(6).r_grav = [0.5 0 0]'*link(6).length - [0 0 0.5]'*snake.r;
link(6).r_buoy = [0.5 0 0]'*link(6).length + [0 0 0]'*snake.r;%[1.1 0 0]';
link(6).M_R  = RBmass(link(6).r_grav,snake.r,link(6).length,link(6).mass); %Rigid body mass
link(6).M_A  = slendermass(link(6).length,pp.denw,snake.r,masscoeff); %Added mass
link(6).drag = 1;
link(6).n_thruster = 0;
link(6).t_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thurster axis
link(6).r_thrust     = [ [0 0 0]' [0 0 0]' [0 0 0]']; %Thruster position




