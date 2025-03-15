function out = Ad(X)
R = X(1:3,1:3);
r = skew(X(1:3,4));
out = [R, r*R; zeros(3), R];
end

%MWK