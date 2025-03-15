%=========================================================================
% Thrust allocation parameters
%=========================================================================

% Thruster damping matrix to handle singular thruster configurations
thrustAlloc.Q_thr_inv = 0.02 * eye(6);
thrustAlloc.mode = 4;

%Mode = 0: Standard damped inverse TCM
%Mode = 1: Thrust allocation with prioritized linear motion (DOF 1-3)
%Mode = 2: Thrust allocation with inverse TCM using SVD

%Mode = 3: Damped inverse TCM with only longitudinal thrusters enabled
%Mode = 4: Simple PI wrt to surge using longitudinal thrusters only

%=========================================================================
% Path-following control parameters
%=========================================================================

ctrlSettings.surge = 1; %Control surge of base = 0, end-effector = 1
ctrlSettings.TCM = 1; %same as above, TCM wrt base or end-effector

ctrlSettings.M_A = 1; %Use full mass matrix in control laws = 1, rigid body mass only = 0

guidance.u_d = 0.5;
guidance.k_cross = guidance.u_d/15; % reference "steepness", the greater k, the less gentle approach to path
% the dividend simulates a lookahead-distance

guidance.testMode = 0; %Test mode for attitude, 0 = normal guidance, 1 = constant reference
guidance.constRef = [0; 1; 0]; %Constant reference direction to be used in test mode. Does not have to be normalised

jointCtrl.shape = 2; %Body curve, uniform = 1, linear = 2, exponential = 3, straight = 4
jointCtrl.alpha = 0.7;

% gains in calculation of base angle
jointCtrl.k_psi = 2;
jointCtrl.k_psid = 3;

% joint PD-controller gains
jointCtrl.k_qP = 30;
jointCtrl.k_qD = 50; 


jointCtrl.hydrostComp = 1; %Compensate for hydrostatic forces in joints, off = 0, on = 1
jointCtrl.torqueSat = 0; % Saturate joint torque, off = 0, on = 1


switch thrustAlloc.mode
    case 4 %PI for surge
        velCtrl.kP = diag([100 0 0]);
        velCtrl.kI = diag([5 0 0]); 
        attCtrl.kP = diag([0 0 0]);
        attCtrl.kD = diag([0 0 0]);
    otherwise
        velCtrl.kP = diag([0.2 0.1 0.1]);
        velCtrl.kI = diag([0.01 0 0]);
        attCtrl.kP = diag([0 0.2 0.2]);
        attCtrl.kD = diag([0 1.3 1.3]);    
end
