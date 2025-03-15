function [TCM] = calculateTCM(g_thrusters,n_thr)
%#codegen

% Calculates the thruster configuration matrix (TCM)
% with respect to the common origin of the transformation matrices in
% g_thrusters.


% OUTPUTS
% TCM - thruster configuration matrix, maps thruster forces to total forces
% and moments


TCM = zeros(6,n_thr);

for i = 1:n_thr
    G = g_thrusters(:,:,i);
    rotMtrx = G(1:3,1:3);
    pos = G(1:3,4);
    
    % Indexes only the first column of rotMtrx, because the thrusters are
    % assumed to act along the X axes of the thruster frames
    TCM(:,i) = [rotMtrx(:,1); skew(pos)*rotMtrx(:,1)];
end


end


