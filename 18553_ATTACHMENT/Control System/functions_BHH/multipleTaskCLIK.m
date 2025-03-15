function Q = multipleTaskCLIK(tasks, combinations, dim)
%Calculates a set Q of size(combinations,1) possible system velocites

nTasks = numel(tasks);
nCombinations = size(combinations,1);
Q = zeros(dim, nCombinations);
Jx = [1];

for i = 1:nCombinations
    c = combinations(i,:);
    init = 0;
    N = eye(dim);
    for j = 1:nTasks
        if c(j) == 1
            T = tasks{j};
            J = T.J;
            J_inv = T.J_inv;
            sigma_ref_dot = T.Sigma_ref_dot;
            q_des = J_inv*sigma_ref_dot;
            Q(:,i) = Q(:,i) + N*q_des;
            if init == 0
                init = 1;
                Jx = T.J;
                Jx_inv = T.J_inv;
            else
                Jx = [Jx; T.J];
                Jx_inv = Jx'/(Jx*Jx');
            end
            N = eye(dim) - Jx_inv*Jx;
        end
    end
end

end