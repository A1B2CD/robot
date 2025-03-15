function out = Ad_inv(X)
R = X(1:3,1:3);
r = skew(X(1:3,4));
out = [R',-R'*r; zeros(3) ,R'];
end