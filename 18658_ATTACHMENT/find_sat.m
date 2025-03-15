function theta_max = find_sat(shape, n_joints, alpha)
    switch shape
        case 1
            theta_max = pi/n_joints;
        case 2
            theta_max = pi/sum((1/n_joints)*(n_joints:-1:1));
        case 3
            theta_max = pi/sum(exp(-alpha*(0:1:n_joints-1)));
        otherwise
            theta_max = pi/2;
    end
    
    theta_max = min(theta_max, pi/2); %cap at max joint angle
end