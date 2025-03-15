function sgn = signum(x)

sgn = zeros(length(x),1);

for i = 1:length(x)
    
    if x(i) >= 0
        sgn(i) = 1;
    else
        sgn(i) = -1;
    end
    
end

end
