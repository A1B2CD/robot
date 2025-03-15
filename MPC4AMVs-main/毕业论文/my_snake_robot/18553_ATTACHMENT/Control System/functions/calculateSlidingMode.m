
function [tau_smc, s] = calculateSlidingMode(pos_tilde, eta_tilde, eps_tilde, R_Ib, nu_base, nu_d, K, Kd, lambda_b, bndLayer)
% Simple sliding mode controller that returns the commanded forces and
% moments for the base

sgn_eta_tilde = signum(eta_tilde);
Lambda = blkdiag(lambda_b*R_Ib', sgn_eta_tilde*eye(3));

nu_ref = nu_d - Lambda * [pos_tilde; eps_tilde];

%nu_base(nu_base<0.01) = 0;

s = nu_base - nu_ref;

tau_smc = Kd * s + K * saturation(s,bndLayer);

end
