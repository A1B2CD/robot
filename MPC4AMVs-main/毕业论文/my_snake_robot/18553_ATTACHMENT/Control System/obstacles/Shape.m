
classdef Shape
   properties
      Center
      Rotation
   end
   methods
       function obj = Shape(center,rot)
           if nargin == 2
               obj.Center = center;
               obj.Rotation = rot;
           elseif nargin == 1
               obj.Center = center;
               obj.Rotation = zeros(3,3);
           else
               obj.Center = zeros(3,1);
               obj.Rotation = zeros(3,3);
           end
       end
   end
end