function out = RBmass(r_g,r,l,m)
% Computes the rigid body mass matrix of a uniform cylinder with a rod
% placed at the bottom to put the center of gravity in the right place. At
% the moment the center of gravity must be placed at x=0.5l y=0. Only the
% z-value is affected by the rod

    d   = r_g(3);
    m_r = abs(d)/r*m;
    m_c = m-m_r;
    
    I_c = m_c*diag([0.5*r^2,0.25*r^2+l^2/3,0.25*r^2+l^2/3]);
    I_r = m_r*[d^2, 0, -0.5*l*d;0, d^2+l^2/3, 0;-0.5*l*d, 0 , l^2/3];
    I_R = I_c + I_r;
    
    out = [m*eye(3), -m*skew(r_g);
           m*skew(r_g), I_R];
end