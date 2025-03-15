function eulerangles = rot2euler(R)


phi   = atan2(R(3,2),R(3,3));
theta = -asin(R(3,1));
psi   = atan2(R(2,1),R(1,1));

eulerangles = [phi;theta;psi];

end