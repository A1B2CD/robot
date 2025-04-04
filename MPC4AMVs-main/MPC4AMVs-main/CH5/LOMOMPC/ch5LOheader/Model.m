classdef (Abstract) Model < handle
    properties
        X
        U
    end
    methods(Abstract)
        Xplus = dynamics_discrete(obj,X,U,dt)
    end
    methods
        function obj = setState(obj,X)
            obj.X = X;
        end
        
        function obj = setControl(obj,U)
            obj.U = U;
        end
        
        function getState(obj)
            fprintf('System State: \n')
            disp(obj.X)
        end
        
        function getControl(obj)
            fprintf('Control Input: \n')
            disp(obj.U)
        end
    end
    
end