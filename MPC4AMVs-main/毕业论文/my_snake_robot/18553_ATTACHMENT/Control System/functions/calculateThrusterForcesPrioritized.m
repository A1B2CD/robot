function [f_thr] = calculateThrusterForcesPrioritized(TCM_L,TCM_inv_L,TCM_inv_A, tau_c, n_thr)
%#codegen

% TCM_L - linear motion part of the TCM
% TCM_inv_L - inverse of the linear motion part of the TCM
% TCM_inv_A - inverse of the angular motion part of the TCM

tau_L = tau_c(1:3);
tau_A = tau_c(4:6);

f_thr = TCM_inv_L * tau_L + (eye(n_thr)-TCM_inv_L*TCM_L)*TCM_inv_A*tau_A;



end