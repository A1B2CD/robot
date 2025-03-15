function J = J_fromquat(quat)
eta=quat(1);
eps_1=quat(2);
eps_2=quat(3);
eps_3=quat(4);

J=[-eps_1 -eps_2 -eps_3; eta -eps_3 eps_2; eps_3 eta -eps_1; -eps_2 eps_1 eta];
end

