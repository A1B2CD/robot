function [f_thr] = calculateThrusterForces(TCM_inv, tau_c)
%#codegen

% Calculate thruster forces
% Assumption: Neglecting the dynamics of the thrusters. The thrusters
% immediately produces the commanded force
f_thr = TCM_inv * tau_c;


end