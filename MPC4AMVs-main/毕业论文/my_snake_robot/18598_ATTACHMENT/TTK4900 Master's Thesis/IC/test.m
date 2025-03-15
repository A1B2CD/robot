function [h_ee,valve_dot]= test(omega_ee,omega_ee_dot,pos_ee,grip,valve_pos)
x=pos_ee(1);
xe=valve_pos(1);
J_v=-2  ;
my_v=-20;
if  abs(omega_ee(1))>0.01 && grip==1
    my_ee=[J_v*omega_ee_dot(1)+my_v*omega_ee(1); 0;0];
else
    my_ee=[0 0 0]';
end
f_ee=[0 0 0]';


if (x-xe)>0
    f_ee(1)=-20*(x-xe);
end

h_ee=[f_ee;my_ee];


if grip==true
    valve_dot=omega_ee(1);
else
    valve_dot=0;
end
end
