function out = TransAngQ(x)
out = 0.5*[-x(2:4)'; x(1)*eye(3)+skew(x(2:4))];
end