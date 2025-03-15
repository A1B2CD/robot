function [g_moduleCM] = calculateModuleTransformations(g_joints, num_modules, module_cm)

% Calculating the transformations from the USM base frame, F_b = CM of center module,
% to the MODULE CENTER OF MASS FRAMES, F_CM_i
% Assumes that the distance from the previous joint to the module CM is
% stored in module_cm


g_moduleCM = zeros(4,4,num_modules);

%Edited to use center as base: Length of rear module approx 55cm + joint =>
%cm at -30cm

for i = 1:num_modules
    g_translationCM = [eye(3), module_cm(i,:)'; zeros(1,3), 1];
    
    if i == 1
        g_translationCM = [eye(3), [-0.3 0 0]'; zeros(1,3), 1];
        g_moduleCM(:,:,i) = g_joints(:,:,i) * g_translationCM;
    else
        g_moduleCM(:,:,i) = g_joints(:,:,i-1) * g_translationCM;
    end
end 

% g1 = g_moduleCM(:,:,1);
% g2 = g_moduleCM(:,:,2);
% g3 = g_moduleCM(:,:,3);
% g4 = g_moduleCM(:,:,4);
% g5 = g_moduleCM(:,:,5);
% g6 = g_moduleCM(:,:,6);
% g7 = g_moduleCM(:,:,7);
% g8 = g_moduleCM(:,:,8);
% g9 = g_moduleCM(:,:,9);

bp = 0;

end