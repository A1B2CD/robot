%=========================================================================
% Path generation
%=========================================================================

% waypoints = [0  -15 -15 -25 0 10; %x
%              5  5   -5  -5 -5 -5;     %y
%             -178 -178 -178 -178 -178 -178; %z
%              0.1 2 2 2 2 0.1];    %radius

% waypoints = [0  -20 -20 -35 0 10; %x
%              5  5   -10  -10 -10 -10;     %y
%             -178 -178 -178 -178 -178 -178; %z
%              0.1 2 2 2 2 0.1];    %radius

waypoints = [0  -20 -30 -30 -45 0; %x
             5  5   -2.5  -10 -10 -10;     %y
            -178 -178 -178 -178 -178 -178; %z
             0.1 2 2 2 2 0.1];    %radius

% spiralWP = load('spiralWP.mat');
% waypoints = spiralWP.waypoints;
         
%=========================================================================
% Obstacle generation
%=========================================================================

%Obstacles are represented by classes found in the folder "objects"

%Because Simulink does not support cell arrays the obstacles are generated
%directly as persistant variables in the MATLAB function block
%"Rangefinder" in USMcontrolSystem -> Guidance System -> Sensors

%=========================================================================
% Collision avoidance IK tasks generation
%=========================================================================

%IK tasks for the collision avoidance system are implemented by the class
%"NormTask". 

%For the same reasons as with the obstacles, all NormTask objects that are
%used to represent the kinematic tasks in the CA system are created as
%persistant variables in the MATLAB function block "Inverse Kinematics"
%found in USMcontrolSystem -> Motion Control System -> Kinematic Contoller


%=========================================================================
% Thrust allocation parameters
%=========================================================================


% Weighting of the thrusters
thrustAlloc.W_thr = eye(7);

% Thruster damping matrix to handle singular thruster configurations
thrustAlloc.Q_thr_inv = 0.02 * eye(6);
thrustAlloc.mode = 0;

%=========================================================================
% Kinematic control parameters
%=========================================================================

%Are defined in the NormTask class, see "Collision avoidance IK tasks
%generation" above


%=========================================================================
% Dynamic control parameters
%=========================================================================

Ke_D = diag([0 0 0 0.13 0.13 0.13])*1;
Ke_P = diag([0.5 0.5 0.5 0.13 0.12 0.12])*1;


%=========================================================================
% Path following control parameters
%=========================================================================

delta = 3;
cf = 0.3;
