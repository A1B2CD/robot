clear all

syms l1 l2 l3 l4 l5 l6 l7 l8 l9 real
syms q1 q2 q3 q4 q5 q6 q7 q8 real

y = [0 1 0]';
z = [0 0 1]';

X1 = [-cross(z,[l1 0 0]');z];
X2 = [-cross(y,[l2 0 0]');y];
X3 = [-cross(z,[l3 0 0]');z];
X4 = [-cross(y,[l4 0 0]');y];
X5 = [-cross(z,[l5 0 0]');z];
X6 = [-cross(y,[l6 0 0]');y];
X7 = [-cross(z,[l7 0 0]');z];
X8 = [-cross(y,[l8 0 0]');y];

X1_hat = [skew(X1(4:6)), X1(1:3); zeros(1,4)];
X2_hat = [skew(X2(4:6)), X2(1:3); zeros(1,4)];
X3_hat = [skew(X3(4:6)), X3(1:3); zeros(1,4)];
X4_hat = [skew(X4(4:6)), X4(1:3); zeros(1,4)];
X5_hat = [skew(X5(4:6)), X5(1:3); zeros(1,4)];
X6_hat = [skew(X6(4:6)), X6(1:3); zeros(1,4)];
X7_hat = [skew(X7(4:6)), X7(1:3); zeros(1,4)];
X8_hat = [skew(X8(4:6)), X8(1:3); zeros(1,4)];

ge_home = [eye(3), [l9 0 0]';zeros(1,3),1];

ge = expm(X1_hat*q1)*expm(X2_hat*q2)*expm(X3_hat*q3)*expm(X4_hat*q4)*expm(X5_hat*q5)*expm(X6_hat*q6)*expm(X7_hat*q7)*expm(X8_hat*q8)*ge_home;
%ge = simplify(ge)

l1 = 0.3;
l2 = 0.4;
l3 = 0.8;
l4 = 0.9;
l5 = 1.4;
l6 = 1.5;
l7 = 1.9;
l8 = 2.0;
l9 = 2.3;

ge = subs(ge)

q1 = 10;
q2 = 10;
q3 = -10;
q4 = -15;
q5 = 5;
q6 = 7;
q7 = 12;
q8 = -33;

l89 = l9 - l8;
l78 = l8 - l7;
l67 = l7 - l6;
l56 = l6 - l5;
l45 = l5 - l4;
l34 = l4 - l3;
l23 = l3 - l2;
l12 = l2 - l1;
l01 = l1;

tic
g01 = [rotationZ(q1) [l01 0 0]';zeros(1,3),1];
g12 = [rotationY(q2) [l12 0 0]';zeros(1,3),1];
g23 = [rotationZ(q3) [l23 0 0]';zeros(1,3),1];
g34 = [rotationY(q4) [l34 0 0]';zeros(1,3),1];
g45 = [rotationZ(q5) [l45 0 0]';zeros(1,3),1];
g56 = [rotationY(q6) [l56 0 0]';zeros(1,3),1];
g67 = [rotationZ(q7) [l67 0 0]';zeros(1,3),1];
g78 = [rotationY(q8) [l78 0 0]';zeros(1,3),1];
g8e = [eye(3) [l89 0 0]';zeros(1,3),1];

(g01*g12)*(g23*g34)*(g45*g56)*(g67*g78)*g8e;
toc

tic
double(subs(ge));
toc

X1_hat = double(subs(X1_hat));
X2_hat = double(subs(X2_hat));
X3_hat = double(subs(X3_hat));
X4_hat = double(subs(X4_hat));
X5_hat = double(subs(X5_hat));
X6_hat = double(subs(X6_hat));
X7_hat = double(subs(X7_hat));
X8_hat = double(subs(X8_hat));
ge_home = double(subs(ge_home));

tic
(expm(X1_hat*q1)*expm(X2_hat*q2))*(expm(X3_hat*q3)*expm(X4_hat*q4))*(expm(X5_hat*q5)*expm(X6_hat*q6))*(expm(X7_hat*q7)*expm(X8_hat*q8))*ge_home;
toc


