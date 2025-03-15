function theta = angleBetweenVectors(u, v)
%Returns the angle between two vectors in degrees
theta = atan2d(norm(cross(u,v)),dot(u,v));