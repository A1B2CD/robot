function [TCM_inv] = calculateTCMInverseSVD(TCM,threshold)
%#codegen

% Calculates the inverse TCM using singular value decomposition to remove
% singular DOFs

% This is actually the same as pinv(TCM,threshold)


[U,S,V] = svd(TCM);

Sinv = zeros(7,6);
Svec = diag(S);

% DOFs with singular values larger than threshold is inverted. The remaining
% elements on the major diagonal of Sinv are left equal to 0, thus ignoring
% the singular DOF
for i = 1:length(Svec)
    if Svec(i) > threshold
        Sinv(i,i) = 1/Svec(i);
    end
end

TCM_inv = V*Sinv*U';

% Just to make the output more readable
TCM_inv(abs(TCM_inv) < 1e-15) = 0;


end


