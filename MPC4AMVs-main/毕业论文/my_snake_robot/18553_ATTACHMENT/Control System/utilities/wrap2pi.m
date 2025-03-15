function rad_out = wrap2pi(rad_in)

if abs(rad_in) > pi
    rev = floor((rad_in+pi)/(2*pi));
    rad_out = rad_in - rev*2*pi;
else
    rad_out = rad_in;
end

end
