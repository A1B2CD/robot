DOCUMENTATION FOR THE MSC THESIS OF BJØRN HÅVARD HOFFMANN

This document serves as an extremely short documentation for the control system created in MATLAB/Simulink and how to use it with the Vortex simulation software.

ANIMATION
An animation of the the USM performing collision avoidance can be seen by running CAanmination.m in the Analysis subfolder.

HOW TO RUN SIMULATIONS
1. Make sure that Vortex Studio and the Simulink extension is installed.
2. Check that the files VortexLoadBlockset.m and VortexStartupScript.m have paths to the directory where the Vortex Simulinkextension is installed.
3. Open the simulink model of the control system: USMcontrolSystem.slx
4. In the "Vortex USM interface" subsystem: doubleclick the "Vortex Simulink" block and set the Path variable to '..\Source code\Control System\Vortex-Simulink-interface-velocity.json' (.. represents where you have stored the files)
5. Open controlParameters.m and set the desired parameters:
	- Waypoints that define the path to follow
	- Obstacles -> Comments describe where to define these
	- Collision avoidance tasks -> Comments describe where to define these
	- Dynamic Control parameters
	- Path following control parameters
6. Choose to use the path following or collision avoidance controller: 
Funtionallity to activate the CA system when needed and pass it a proper goal position based on the path the USM was following when an obstacle was encountered 
has not been fully implemented. The CA system is thus activated (to test CA) or deactivated (to test path following) by setting the variable "CA_active" in 
the block "Collision Avoidance Monitor" in USMcontrolSystem -> Guidance System.
7. Open Vortex Studio, and open the file "Eelume prototype test scene.vxscene" in '..\Source code\Vortex Model\'.
8. Move the camera to the USM by first leftclicking "Eelume protoype" under "Scene" in the left menu (Explorer), and then pressing "shift+F".
9. Start the Vortex simulation by pressing the play button in Vortex Studio.
10. Start the control system by running the simulink model (USMcontrolSystem.mdl).


FOLDERS
Control System: contains all MATLAB/Simulink files
	- functions: Main functions used in MATLAB function blocks in the Simulink model - created by Jørgen Sverdrup-Thygeson
	- utilities: Utility functions used in MATLAB function blocks in the Simulink model - created by Jørgen Sverdrup-Thygeson
	- validation: Validation functions used in MATLAB function blocks in the Simulink model - created by Jørgen Sverdrup-Thygeson
	
	- functions_BHH: Main functions used in MATLAB function blocks in the Simulink model - created by Bjørn Håvard Hoffmann
	- utilities_BHH: Utility functions used in MATLAB function blocks in the Simulink model - created by Bjørn Håvard Hoffmann
	- obstacles: Classes that are used to create an environment with obstacles to test the CA system - created by Bjørn Håvard Hoffmann
	- Analysis: Functions used to make plots and analyse the results. Not essential for the system. - created by Bjørn Håvard Hoffmann

