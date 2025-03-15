
classdef Obstacle
   properties
      Center
      Rotation
      Translation
      R_active
      Bbox
      Bbox_width
      Bbox_height
      Children
   end
   methods
       function obj = Obstacle(val)
           if nargin > 0
               obj.Center = val;
           end
       end
   end
end