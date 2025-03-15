function M_RB = calculateInertiaMatrixRB(g_moduleCM, num_modules, mass, momentOfInertia, addedMass, addedInertia)
%#codegen

% Calculates the total rigid body single body inertia matrix (M_11) about the common origin
% defined by the transformations in g_moduleCM


M_RB = zeros(6,6);


for i = 1:num_modules
    Ad_bi_inv = calculateAdjointInverse(g_moduleCM(:,:,i));
    
    M_i = diag([mass(i)*ones(1,3)+addedMass(i,:), momentOfInertia(i,:)+addedInertia(i,:)]);
    
    M_RB = M_RB + Ad_bi_inv' * M_i * Ad_bi_inv;
end

end

