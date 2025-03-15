num_joints = param.num_joints;
num_modules = param.num_modules;

joint_tr = param.joint_tr;
joint_ax = param.joint_ax;

module_cm = param.module_cm;

mass = param.mass;
addedMass = param.addedMass(1:3,1:3,:);
momentOfInertia = param.momentOfInertia;
addedInertia = param.addedMass(4:6,4:6,:);


[g_joints, g_joints_home] = calculateJointTransformations(q, num_joints, joint_tr, joint_ax);

[g_moduleCM] = calculateCMTransformations(g_joints, num_modules, module_cm);

M = calculateInertiaMatrix(g_moduleCM, num_modules, mass, momentOfInertia, addedMass, addedInertia);
