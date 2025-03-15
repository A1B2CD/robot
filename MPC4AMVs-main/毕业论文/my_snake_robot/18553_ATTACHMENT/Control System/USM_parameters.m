function USM_params() 
%Configuration parameters for the USM modelled in Vortex

%% MANIPULATOR PARAMETERS

num_joints = 8;
num_modules  = 9;
num_thrusters = 7;

% Environment constants
accel_grav    = 9.81;
density_water = 1026;

% Module lengths [m]
lengths = 1e-2 * [62.0;  % 0 - base module (tether + camera)
                  10.4;  % 1 - coupling 1
                  58.4;  % 2 - double module back
                  10.4;  % 3 - coupling 2
                  72.6;  % 4 - center module
                  10.4;  % 5 - coupling 3
                  58.4;  % 6 - double module front
                  10.4;  % 7 - coupling 4
                  37.0]; % 8 - front module

% Vectors from a joint to the next
joint_tr = [lengths, zeros(num_modules, 2)];

% Module radius [m]
radius = 1e-2 * [8.5;  % 0 - base module (tether + camera)
                 8.5;  % 1 - coupling 1
                 8.5;  % 2 - double module back
                 8.5;  % 3 - coupling 2
                 8.5;  % 4 - center module
                 8.5;  % 5 - coupling 3
                 8.5;  % 6 - double module front
                 8.5;  % 7 - coupling 4
                 8.5]; % 8 - front module

% Module displacements [m^3]

volume = 1e-3 * [14.3;  % 0
                  6.0;  % 1
                 12.7;  % 2
                  6.0;  % 3
                  9.8;  % 4
                  6.0;  % 5
                 12.7;  % 6
                  6.0;  % 7
                  7.8]; % 8
% volume = pi*radius.^2.*lengths;
volume_tot = sum(volume);


% Buoyancy vector [kg]
% Vector to specify the positive and negative buoyancy of each module
buoyancy_vector = [1.4,-1.5,1.6,-1.5,0.3,-1.5,1.6,-1.5,1.1]';  


% Module masses [kg]
% Adjusted for positive and negative buoyancy
% mass = [14.07;   % 0     Neutral
%          6.00;   % 1     Negative (-3.64)
%          8.77;   % 2     Positive (+4.49)
%          6.00;   % 3     Negative (-3.64)
%         10.90;   % 4     Positive (+5.58)
%          6.00;   % 5     Negative (-3.64)
%          8.77;   % 6     Positive (+4.49)
%          6.00;   % 7     Negative (-3.64)
%          8.40];  % 8     Neutral

% All modules neutrally buoyant
mass = volume*density_water; % - buoyancy_vector;
mass_tot = sum(mass);



% Joint rotation axes
joint_ax = ['Z','Y','Z','Y','Z','Y','Z','Y']';

% Local velocity twist coordinate vectors for the joints
bodyTwists = zeros(6,num_joints);
for i = 1:num_joints
    if strcmp(joint_ax(i),'Y')
        bodyTwists(:,i) = [0 0 0 0 1 0]';
    elseif strcmp(joint_ax(i),'Z')
        bodyTwists(:,i) = [0 0 0 0 0 1]';
    end
end

% Min/max joint limits
q_min = -65*ones(8,1)*pi/180;
q_max = 65*ones(8,1)*pi/180;

% Module CBs relative joint frames [m]
% Currently NOT EXACT--set to be halfway between joints
module_cb = 1e-2 * [30.3 0 0;  % 0
                     5.2 0 0;  % 1
                    29.2 0 0;  % 2
                     5.2 0 0;  % 3
                    36.2 0 0;  % 4
                     5.2 0 0;  % 5
                    29.2 0 0;  % 6
                     5.2 0 0;  % 7
                    19.3 0 0]; % 8

% Module CMs relative joint frames [m]
module_cm = 1e-2 * [30.3 0 0;  % 0
                     5.2 0 0;  % 1
                    29.2 0 0;  % 2    29.2 0 7;  % 2
                     5.2 0 0;  % 3
                    36.2 0 0;  % 4    36.2 0 7;  % 4
                     5.2 0 0;  % 5
                    29.2 0 0;  % 6    29.2 0 7;  % 6
                     5.2 0 0;  % 7
                    19.3 0 0]; % 8
% module_cm(:,3) = 0; % No restoring



% Moment of inertia, about module CM, along principle axes
% Using standard equation for solid cylinder
% Assuming homogeneous mass distribution

% NOTE: The moment of inertia of each module in Vortex may be auto-computed
% Make sure that the values calculated here are equal to the Vortex values,
% if this is what you want (e.g. if you want to design a controller with
% perfect compensation of nonlinear terms)

% PAY ATTENTION TO THE DEFINITION OF THE PRINCIPAL AXES IN VORTEX
% The x,y,z axes of each module in Vortex may differ, and they are usually
% not equal to the definition used in the calculation below

momentOfInertia = zeros(num_modules,3);

for i = 1:num_modules
    momentOfInertia(i,:) = calculateSolidCylinderInertia(mass(i),lengths(i),radius(i));
end


% Added mass, with respect to module CM
% Using approximations from Schjølberg and Fossen (MCMC 1994)
addedMass = zeros(num_modules,6);

for i = 1:num_modules
    addedMass(i,:) = calculateCylinderAddedMass(mass(i),lengths(i),radius(i),density_water);
end


%% THRUSTER PARAMETERS

% NOTE THAT THE POSITION OF THE CENTER VERTICAL THRUSTER IS DIFFERENT IN
% THE VORTEX MODEL THAN FOR THE PHYSICAL EELY PROTOTYPE

% thruster 1 - back vertical, positive force down
% thruster 2 - back horizontal, positive force right (starboard)
% thruster 3 - longitudinal left side (port), positive force forward
% thruster 4 - longitudinal right side (starboard), positive force forward
% thruster 5 - center vertical, positive force down
% thruster 6 - front horizontal, positive force right (starboard)
% thruster 7 - front vertical, positive force down

thruster_ax = ['Z','Y','X','X','Z','Y','Z']';
thruster_moduleNumber = [3,3,5,5,5,7,7];
f_thr_max = 50 * ones(7,1);


% Import the thruster RPM to force mapping
% NOTE: Make sure that this is the same mapping that is used in the Vortex
% model
thrusterRPMMapping = importdata('vortex_thrusterMapping.csv');


% Thruster frames relative to joint frames [m]
thruster_pos = [0.237,  0,   0;
                0.347,  0,   0;
                0.278, -0.1, 0;
                0.278,  0.1, 0;
                0.488,  0,   0;
                0.237,  0,   0;
                0.347,  0,   0];

% %% THRUSTER PARAMETERS NEW
% % thruster 1 - back vertical, positive force down
% % thruster 2 - back horizontal, positive force right (starboard)
% % thruster 3 - center vertical, positive force down
% % thruster 4 - longitudinal left side (port), positive force forward
% % thruster 5 - longitudinal right side (starboard), positive force forward
% % thruster 6 - front horizontal, positive force right (starboard)
% % thruster 7 - front vertical, positive force down
% 
% 
% % Specify the number of the module to which the thrusters are attached
% thruster_moduleNumber = [3,3,5,5,5,7,7];
% f_thr_max = 50 * ones(7,1);
% 
% 
% % Import the thruster RPM to force mapping
% % NOTE: Make sure that this is the same mapping that is used in the Vortex
% % model
% thrusterRPMMapping = importdata('vortex_thrusterMapping.csv');
% 
% % Thruster frame positions relative to joint frames [m]
% thruster_pos = [0.237,  0,   0;
%                 0.347,  0,   0;
%                 0.488,  0,   0;
%                 0.278, -0.1, 0;
%                 0.278,  0.1, 0;               
%                 0.237,  0,   0;
%                 0.347,  0,   0];
% 
% % Thruster frame rotation angles (Z, Y) relative to joint frames, specified
% % by a rotation about the module Z axis followed by a rotation about the
% % new Y axis
% thruster_rotation = [0,    -pi/2;
%                      pi/2,     0;
%                      0,    -pi/2;
%                      0,        0;
%                      0,        0;                    
%                      pi/2,     0;
%                      0,    -pi/2];

save('usm_params.mat');

end
