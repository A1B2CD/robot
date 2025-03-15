function N = calculateRestoringForces(g_moduleCM, R_Ib, n, mass, volume, accel_grav, density_water, p_cm2cb)
%#codegen

% Calculates the total restoring forces and moments with respect to the common
% origin of the transformations in g_moduleCM


N = zeros(6,1);
e_z = [0 0 1]';

for i = 1:n
    RIi = R_Ib*g_moduleCM(1:3,1:3,i);
    F_gi = mass(i)*accel_grav*[RIi'*e_z; zeros(3,1)];
    F_bi = -volume(i)*density_water*accel_grav*[RIi'*e_z; skew(p_cm2cb(i,1:3)')*RIi'*e_z];
    
    Ad_bi_inv = calculateAdjointInverse(g_moduleCM(:,:,i));

    
    % Subtract the contribution for each module to get correct sign for the
    % restoring forces
    N = N - Ad_bi_inv' * (F_gi + F_bi);
end

end

