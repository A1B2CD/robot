function [g_moduleCM] = calculateModuleTransformations(g_joints, num_modules, module_cm)

% Calculating the transformations from the USM base frame, F_b = F_0,
% to the MODULE CENTER OF MASS FRAMES, F_CM_i
% Calculated sequentially from the tail module and forward
% Assumes that the distance from the previous joint to the module CM is
% stored in module_cm


g_moduleCM = zeros(4,4,num_modules);


for i = 1:num_modules
    g_translationCM = [eye(3), module_cm(i,:)'; zeros(1,3), 1];
    
    if i == 1
        g_moduleCM(:,:,i) = g_translationCM;
    else
        g_moduleCM(:,:,i) = g_joints(:,:,i-1) * g_translationCM;
    end
end 


end