function sat = saturation(x,e)

sat = zeros(length(x),1);

for i = 1:length(x)
    
    if x(i) > e(i)
        sat(i) = 1;
    elseif x(i) < -e(i)
        sat(i) = -1;
    else
        sat(i) = x(i)/e(i);
    end
    
end

end
