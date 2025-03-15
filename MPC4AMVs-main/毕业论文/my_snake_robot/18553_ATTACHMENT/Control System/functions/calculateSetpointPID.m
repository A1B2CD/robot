function tau_pid = calculateSetpointPID(eta_error, eta_error_int, eta_dot, Kp, Kd, Ki)
% PID controller for setpoint regulation

tau_pid = Kp * eta_error + Kd * eta_dot + Ki * eta_error_int;

end
