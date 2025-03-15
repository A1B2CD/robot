function out = RotQ(x)
S = skew(x(2:4));
out = eye(3) + 2*x(1)*S + 2*S*S;
end