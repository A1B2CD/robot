function [TCM_inv] = calculateTCMInverse(TCM,Q_inv)


% Calculates the inverse TCM
% The inverse TCM multiplied by the desired forces and moments in N and Nm
% will give the thruster efforts in N
% The desired forces and moments are defined according to SNAME, [X Y Z K M N]
% Scaling is required to have inputs/outputs with other denominations


% OUTPUTS
% TCM_inv - weighted pseudo-inverse of TCM, maps desired total forces and
% moments on the overall CM to the individual thruster forces


% Calculate pseudo-inverse of the TCM
TCM_inv = TCM'/(TCM*TCM' + Q_inv);
TCM_inv(abs(TCM_inv) < 1e-15) = 0;

end


