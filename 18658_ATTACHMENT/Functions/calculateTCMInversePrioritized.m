function [TCM_inv_linear,TCM_inv_angular] = calculateTCMInversePrioritized(TCM,Q_inv)


% Calculates the inverse TCM
% The inverse TCM multiplied by the desired forces and moments in N and Nm
% will give the thruster efforts in N
% The desired forces and moments are defined according to SNAME, [X Y Z K M N]
% Scaling is required to have inputs/outputs with other denominations


% OUTPUTS
% TCM_inv - weighted pseudo-inverse of TCM, maps desired total forces and
% moments on the overall CM to the individual thruster forces

TCM_linear = TCM(1:3,:);
TCM_angular = TCM(4:6,:);

% NOTE: Singular value based damping factor Q_inv would be beneficial
% Calculate pseudo-inverse of the TCM
TCM_inv_linear = TCM_linear'/(TCM_linear*TCM_linear' + Q_inv(1:3,1:3));
TCM_inv_angular = TCM_angular'/(TCM_angular*TCM_angular' + Q_inv(4:6,4:6)*diag([100 1 1]));

TCM_inv_linear(abs(TCM_inv_linear) < 1e-15) = 0;
TCM_inv_angular(abs(TCM_inv_angular) < 1e-15) = 0;

end


