classdef Cylinder < Shape
   properties
      Radius
      Height
      CenterLine
      CenterBottom
      CenterTop
   end
   methods
       function obj = Cylinder(center_bottom, center_top, radius)
           obj@Shape(0);
           if nargin > 0
               obj.Radius = radius;
               obj.CenterBottom = center_bottom;
               obj.CenterTop = center_top;
               obj.CenterLine = center_top - center_bottom;
               obj.Height = norm(obj.CenterLine);
               obj.Center = center_bottom + 0.5*obj.CenterLine;
           end
       end
       
       function d = distanceTo(obj, p)
           d = norm(p - obj.closestSurfacePointTo(p));
       end
       
       function s = closestSurfacePointTo(obj, p)
           n = obj.CenterLine/norm(obj.CenterLine);
           %Find normal from p to the cylinder center line
           normal = (obj.CenterBottom - p) - ((obj.CenterBottom - p)'*n)*n;
           pointOnCL = p + normal;
           %obj.CenterBottom + c*n = pointOnCL;
           center = obj.CenterBottom + 0.5*(obj.CenterTop - obj.CenterBottom);
           vec = pointOnCL - center;
           c = norm(vec);
           if c > obj.Height/2 %d is "outside" the cylinder
               %Closest point is on the top or bottom surface
               distToCenterLine = norm(normal);
               dir = n'*vec;
               if dir < 0 %Bottom surface
                   if distToCenterLine < obj.Radius
                       s = obj.CenterBottom - normal;
                   else
                       s = obj.CenterBottom - obj.Radius*(normal/norm(normal));
                   end
               else
                   if distToCenterLine < obj.Radius
                       s = obj.CenterTop - normal;
                   else
                       s = obj.CenterTop - obj.Radius*(normal/norm(normal));
                   end
               end 
           else %d is "inside" the cylinder
               %Subtract radius from the normal
               distToCenterLine = norm(normal);
               factor = (distToCenterLine - obj.Radius)/distToCenterLine;
               s = p + factor*normal;
           end
       end
       
       function draw(obj, r_ca)
           %Plot centers
%            scatter3(obj.CenterBottom(1), obj.CenterBottom(2), obj.CenterBottom(3), 'r*');
%            hold on;
%            scatter3(obj.CenterTop(1), obj.CenterTop(2), obj.CenterTop(3), 'r*');
          
           %Unit cylinder with center in [0;0;0.5]
           [x,y,z] = cylinder(obj.Radius);
           %Stretch
           z = z*obj.Height;
           z_center = (z(2,1) - z(1,1))/2;
           %Move center to origin
           z = z - z_center;
           
           %Disc for top and bottom
           th = 0:pi/50:2*pi;
           xc = obj.Radius * cos(th);
           yc = obj.Radius * sin(th);
           n_disc = length(xc);
           discTop = [xc; yc; ones(1,n_disc)*z(2,1); ones(1,n_disc)];
           discBottom = [xc; yc; ones(1,n_disc)*z(1,1); ones(1,n_disc)];
           
           %Rotate and translate
           t = obj.Center;
           k = cross([0;0;1]*obj.Height,obj.CenterLine);
           k = k/norm(k);
           u = obj.CenterLine;
           v = [0;0;1];
           theta = atan2d(norm(cross(u,v)),dot(u,v))*pi/180;
           if abs(theta) > 0
               quaternion = [cos(theta/2); k*sin(theta/2)];
               R = quat2rotm(quaternion');
           else
               R = eye(3);
           end
           n = size(x,2);
           pointsBottom = [x(1,:); y(1,:); z(1,:); ones(1,n)];
           pointsTop = [x(2,:); y(2,:); z(2,:); ones(1,n)];
           T = [R t; [0 0 0 1]];
           pointsBottom_rotated = T*pointsBottom;
           pointsTop_rotated = T*pointsTop;
           x = [pointsBottom_rotated(1,:); pointsTop_rotated(1,:)];
           y = [pointsBottom_rotated(2,:); pointsTop_rotated(2,:)];
           z = [pointsBottom_rotated(3,:); pointsTop_rotated(3,:)];
           
           discTop_rotated = T*discTop;
           discBottom_rotated = T*discBottom;

           %Plot
           lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
           faceColor = [255/255 255/255 0/255];
           a = 1;
           if r_ca == 1
               a = 0;
           end
           surface(x,y,z,'FaceColor', faceColor,'EdgeColor',lightGrey, 'FaceAlpha', a);
           fill3(discTop_rotated(1,:), discTop_rotated(2,:), discTop_rotated(3,:), faceColor, 'FaceAlpha', a);
           fill3(discBottom_rotated(1,:), discBottom_rotated(2,:), discBottom_rotated(3,:), faceColor, 'FaceAlpha', a);
       end
   end
end