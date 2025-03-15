function Ad_g = calculateAdjoint(g)


rotation = g(1:3,1:3);
pos = g(1:3,4);

Ad_g = [rotation, skew(pos)*rotation; zeros(3,3), rotation];

end
