function rotZ = rotationZ(angle)

cos_angle = cos(angle);
sin_angle = sin(angle);

rotZ = [ cos_angle -sin_angle 0; sin_angle cos_angle 0; 0 0 1 ];

end