function out = Ad_inv(X)
%%% 伴随逆矩阵（adjoint inverse matrix）
R = X(1:3,1:3);
r = skew(X(1:3,4));
out = [R',-R'*r; zeros(3) ,R'];
end