classdef Sphere < Shape
   properties
      Radius
   end
   methods
       function obj = Sphere(center, radius)
           obj@Shape(center);
           if nargin > 0
               obj.Radius = radius;
           else
               obj.Radius = 1;
           end
       end
       
       function d = distanceTo(obj, p)
           d = norm(p - obj.Center) - obj.Radius;
       end
       
       function s = closestSurfacePointTo(obj, p)
           v = p - obj.Center;
           s = obj.Center + v/norm(v)*obj.Radius;
       end
       
       function draw(obj)
           %Plot center
           scatter3(obj.Center(1), obj.Center(2), obj.Center(3), 'r*');
           hold on;
           %Plot sphere
           r = obj.Radius;
           [x,y,z] = sphere(50);
           x0 = obj.Center(1); y0 = obj.Center(2); z0 = obj.Center(3);
           x = x*r + x0;
           y = y*r + y0;
           z = z*r + z0;
           lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
           surface(x,y,z,'FaceColor', 'red','EdgeColor',lightGrey)
       end
   end
end