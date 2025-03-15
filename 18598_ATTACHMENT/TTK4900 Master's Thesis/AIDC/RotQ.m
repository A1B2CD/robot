function out = RotQ(x)
S = skew(x(2:4));
out = eye(3) + 2*x(1)*S + 2*S*S;  %%%  四元数 变成  旋转矩阵  公式
end