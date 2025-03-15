%% This script is used to load parameters and prepare for Vortex simulations

%Add all the required subfolders to the execution path
initializePath;

%Parameters that describe the geometry of the USM as it is modelled in Vortex
USM_parameters;
modelParams = load('usm_params.mat');

%Set the desired control parameers
controlParameters;

%Parameters that facillitate the communication between Simulink and Vortex
vortexParameters;

%Make the Vortex Simulinkblock ready
VortexLoadBlockset;
VortexStartupScript; 