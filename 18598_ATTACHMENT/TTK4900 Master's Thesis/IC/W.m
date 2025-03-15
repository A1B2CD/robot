function out = W(x)
v =   skew(x(1:3));
w =   skew(x(4:6));
out = [zeros(3),v;v,w]; 
end