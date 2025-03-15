classdef NormTask < handle
   properties
      Active %Boolean. True if the set-based task is active
      Gain %CLIK gain
      Weights %Weights used if weighted pseudo-inverse is applied
      SetBased %Boolean. True if set-based task
      J %Task Jacobian
      J_inv %Inverse of task jacobian
      Sigma_des %Desired distance from point
      Sigma_actual %Actual distance from point
      Sigma_tilde %sigma_des - sigma_actual
      Sigma_ref_dot %(sigma_des_dot - Gain*sigma_tilde) from CLIK equation
      Sigma_des_dot %Derivative of desired value
   end
   methods
       function obj = NormTask(setBased, sigma_des, gain, W)
           if nargin > 0
               obj.SetBased = setBased;
               obj.Sigma_des = sigma_des;
               obj.Gain = gain;
               obj.Weights = W;
               obj.Sigma_des_dot = 0;
               
               obj.Active = 0;
               if setBased == 0 %Equality constraints are always active
                   obj.Active = 1;
               end
           else
               error('Enter setBased, sigma_des, gain and weights');
           end
       end
       
       function out = update(obj, Jpos, point, pos, orientation, travel_dir)
           
            W_inv = diag(1./obj.Weights);

            diff_I = point - pos;
            R_I_f = orientation;
            diff_f = R_I_f'*diff_I;
            obj.J = diff_f'/norm(diff_f)*Jpos;

            %Pseudo-Inverse
            obj.J_inv = obj.J'/(obj.J*obj.J');
            %Weighted pseudo-inverse
            %J1_inv = W_inv*J1'/(J1*W_inv*J1');

            obj.Sigma_actual = sqrt(diff_f'*diff_f); %Actual distance to point
            obj.Sigma_tilde = obj.Sigma_des - obj.Sigma_actual;
            
            obj.Sigma_ref_dot = obj.Sigma_des_dot - obj.Gain*obj.Sigma_tilde;
            
            if obj.SetBased == 1 %Check if the constraint is active
                if obj.Sigma_actual < obj.Sigma_des || obj.Active == 1
                    obj.Active = 1;
                    p_obst = R_I_f'*(point-pos); %Vector from point on USM to point to avoid
                    p_travel = R_I_f'*(travel_dir-pos); %Vector from point on USM to desired location
                    if p_obst'*p_travel <= 0 && obj.Sigma_actual >= obj.Sigma_des
                        obj.Active = 0;
                    end
                end
            end
            
            out = 1;
       end
   end
   
end