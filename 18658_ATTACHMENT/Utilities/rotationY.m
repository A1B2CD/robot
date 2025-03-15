function rotY = rotationY(angle)

cos_angle = cos(angle);
sin_angle = sin(angle);

rotY = [ cos_angle 0 sin_angle; 0 1 0; -sin_angle 0 cos_angle ];

end