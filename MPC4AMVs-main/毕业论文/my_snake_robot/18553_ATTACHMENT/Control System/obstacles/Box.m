classdef Box < Shape
   properties
      Corners
      Width
      Height
      Depth
      Edges
      Faces
      Normals
      FaceCenters
      FaceUnitVectors
   end
   methods
       function obj = Box(c1, c2, c3, depth)
           obj@Shape();
           if nargin > 0
               obj.Width = norm(c2 - c1);
               obj.Height = norm(c3 - c2);
               obj.Depth = depth;
               
               %Find edge vectors and rotation
               e1 = (c2 - c1)*0.5;
               e2 = (c3 - c2)*0.5;
               k = cross(e2,e1);
               e3 = k/norm(k)*depth*0.5;
               obj.Center = c1 + e1 + e2 + e3;
               obj.Edges = [e1 e2 e3];
               e1_n = e1/norm(e1);
               e2_n = e2/norm(e2);
               e3_n = e3/norm(e3);
               obj.Rotation = [e1_n e3_n e2_n];
               obj.FaceUnitVectors = [-e3 e2; e3 e2; %Left Right
                                        e1 e3; e1 -e3; %Top Bottom
                                        -e1 e2; e1 e2]; %Back Front
               
               
               %Find face normals
               n1 = -e1/norm(e1); %Left/-right
               n2 = e2/norm(e2); %Top/-bottom
               n3 = e3/norm(e3); %Back/-front
               obj.Normals = [n1 -n1 n2 -n2 n3 -n3];
               obj.Faces =  [1 2 3 4; 5 6 7 8; %Left Right
                             1 4 8 5; 2 3 7 6; %Top Bottom
                             4 8 7 3; 1 5 6 2]; %Back Front
                         
               obj.Corners = findCorners(obj);
               
               c = obj.Center;
               e1 = obj.Edges(:,1);
               e2 = obj.Edges(:,2);
               e3 = obj.Edges(:,3);
               obj.FaceCenters = [c - e1, c + e1, c + e2, c - e2, c + e3, c - e3];
                        %Left %Right %Top %Bottom %Back %Front
          
           end
       end
       
       function corners = findCorners(obj)
           c = obj.Center;
           e1 = obj.Edges(:,1);
           e2 = obj.Edges(:,2);
           e3 = obj.Edges(:,3);
           corners_left = [c - e1 + e2 - e3, c - e1 - e2 - e3, c - e1 - e2 + e3, c - e1 + e2 + e3];
           corners_right = [c + e1 + e2 - e3, c + e1 - e2 - e3, c + e1 - e2 + e3, c + e1 + e2 + e3];
           corners = [corners_left corners_right];
       end
       
       function d = distanceTo(obj, p)
           d = norm(p - obj.closestSurfacePointTo(p));
       end
       
       function s = closestSurfacePointTo(obj, p)
           nFaces = 6;
           closestFace = -1;
           for i = 1:nFaces
               faceCenter = obj.FaceCenters(:,i);
               n = obj.Normals(:,i);
               v = p - faceCenter;
               dot = n'*v;
               if dot >= 0
                   closestFace = i;
               end
           end
           %Project point onto the closest face of the box
           n = obj.Normals(:, closestFace);
           faceCenter = obj.FaceCenters(:,closestFace);
           v = p - faceCenter;
           v_par = v'*n*n/norm(n);
           v_norm = v - v_par;
           p_surf = faceCenter + v_norm;
           
           %Distance along face unit vectors
           index = i*3 - 2;
           e1 = obj.FaceUnitVectors(index:index + 2,1);
           e1_n = e1/norm(e1);
           u1 = v_norm'*e1_n*e1_n;
           
           e2 = obj.FaceUnitVectors(index:index + 2,2);
           e2_n = e2/norm(e2);
           u2 = v_norm'*e2_n*e2_n;
           
           %Find direction
           a = v_norm'*e1;
           b = v_norm'*e2;
           a = a/abs(a);
           b = b/abs(b);
           
           if norm(u1) > norm(e1) %Outside face, the closest point is along the edge
               if norm(u2) > norm(e2) %Closest point is a corner
                   s = faceCenter + a*e1 + b*e2;
               else
                   s = faceCenter + a*e1 + u2;
               end
           elseif norm(u2) > norm(e2) %Closest point is on an edge
               if norm(u1) > norm(e1) %Closest point is a corner
                   s = faceCenter + a*e1 + b*e2;
               else
                   s = faceCenter + b*e2 + u1;
               end
           else %Point is on face
               s = p_surf;
           end
           
           bp = 0;
           
       end
       
       function draw(obj)
           %scatter3(obj.Corners(1,:), obj.Corners(2,:), obj.Corners(3,:), 'filled');
           %hold on;
           %plot3(obj.Corners(1,:), obj.Corners(2,:), obj.Corners(3,:));
           faceColor = [255/255 255/255 0/255];
           V = [obj.Corners(1,:)' obj.Corners(2,:)' obj.Corners(3,:)'];
           F = [1 2 3 4; 5 6 7 8; %Left right
               1 4 8 5; 2 3 7 6; %Top bottom
               3 4 8 7; 2 1 5 6]; %Back front
           patch('Faces',F,'Vertices',V, 'EdgeColor', 'black', 'FaceColor', faceColor, 'LineWidth', 0.5)
           xlabel('x');
           ylabel('y');
           zlabel('z');
           %axis equal
       end
   end
end