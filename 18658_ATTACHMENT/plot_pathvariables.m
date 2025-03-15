
figure()
   subplot 311 % cross-track errors
       plot(pos_Ie.time, pos_Ie.signals.values(:,2:3), x.time, x.signals.values(:,2:3), [x.time(1) x.time(end)], [0 0], '--')
       title('Cross-track error')
       legend('y_{e}', 'z_{e}', 'y_{b}', 'z_{b}')
       grid minor
       xlabel('Time [s]')
       ylabel('[m]')
    
   subplot 312 % surge of end-effector and base
        plot(vel_Ie_e.time, vel_Ie_e.signals.values(:,1), x.time, x.signals.values(:,7+snake.n),[x.time(1) x.time(end)],[guidance.u_d guidance.u_d],'--')
        title('Surge')
        legend('Head','Tail','Reference')
        grid minor
        xlabel('Time [s]')
        ylabel('[m/s]')
        
   subplot 313
        plot(vel_Ie_e.time, vel_Ie_e.signals.values(:,2:3), x.time, x.signals.values(:,8+snake.n:9+snake.n))
        title('Sway & heave')
        legend('End-effector v', 'End-effector w', 'Base v', 'Base w')
        grid minor
        xlabel('Time [s]')
        ylabel('[m/s]')
        
             
figure()
   subplot 311 % body x-axis directions
        x_b = squeeze(Rot_Ie.signals.values(:,1,:));
        plot(Rot_Ie.time, x_b)
        hold on
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(heading_ref.time, heading_ref.signals.values, '--')
        hold off
        title('End-effector x-axis in world frame')
        legend('x','y','z') %,'x_{ref}','y_{ref}','z_{ref}')
        grid minor
        xlabel('Time [s]')
       
   subplot 312 
        plot(error_angle.time, error_angle.signals.values, [error_angle.time(1) error_angle.time(end)], [0.0175 0.0175], '--')
        title('Angle between current and desired pointing direction')
        grid minor
        xlabel('Time [s]')
        
   subplot 325 %angular velocity of end-effector
        plot(vel_Ie_e.time, vel_Ie_e.signals.values(:,4:6))
        hold on
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(omega_ref.time, omega_ref.signals.values, '--')
        hold off
        title('End-effector angular velocity')
        legend('x', 'y', 'z')
        grid minor
        xlabel('Time[s]')
        ylabel('[rad/s]')
          
   subplot 326
        eul = rotm2eul(Rot_Ie.signals.values);
        plot(Rot_Ie.time, eul(:,3))
        title('End-effector roll')
        grid minor
        xlabel('Time [s]')
        ylabel('[rad]')
    
        
 figure()
     subplot 321 % y angles
        plot(x.time, x.signals.values(:,find(snake.joint_vec==2)+7))
        hold on
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(joint_setpoints.time, joint_setpoints.signals.values(:,find(snake.joint_vec==2)), '--')
        hold off
        title('Joints actuated about y-axis')
        legend('Joint 1','Joint 2','Joint 3','Joint 4')
        grid minor
        xlabel('Time [s]')
        ylabel('[rad]')
        ylim([-pi/2 pi/2])
        
   subplot 322 % z angles
        plot(x.time, x.signals.values(:,find(snake.joint_vec==3)+7))
        hold on
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(joint_setpoints.time, joint_setpoints.signals.values(:,find(snake.joint_vec==3)), '--')
        hold off
        title('Joints actuated about z-axis')
        legend('Joint 1','Joint 2','Joint 3','Joint 4')
        grid minor
        xlabel('Time [s]')
        ylabel('[rad]')
        ylim([-pi/2 pi/2])
    
 subplot 323 % y torques
        jointTorqueValues = jointTorques.signals.values(:,7:end);
        plot(jointTorques.time, jointTorqueValues(:,find(snake.joint_vec==2)))
        title('Joint torques about y-axis')
        legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4')
        grid minor
        xlabel('Time [s]')
        %ylabel('[N]')
        
 subplot 324 % z torques
        jointTorqueValues = jointTorques.signals.values(:,7:end);
        plot(jointTorques.time, jointTorqueValues(:,find(snake.joint_vec==3)))
        title('Joint torques about z-axis')
        legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4')
        grid minor
        xlabel('Time [s]')
        %ylabel('[N]')
        
        
    subplot 313 % thruster use
        plot(thrusterForces.time, thrusterForces.signals.values)
        title('Thruster forces')
        legend('Thruster 1', 'Thruster 2', 'Thruster 3', 'Thruster 4', 'Thruster 5', 'Thruster 6', 'Thruster 7')
        grid minor
        xlabel('Time [s]')
        ylabel('[N]')