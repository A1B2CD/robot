function out = ad_operator(x)
v = skew(x(1:3));
w = skew(x(4:6));
out = [w v;zeros(3) w];
end