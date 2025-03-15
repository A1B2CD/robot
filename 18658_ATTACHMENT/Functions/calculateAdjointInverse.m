function Ad_g = calculateAdjointInverse(g)

rotation = g(1:3,1:3);
pos = g(1:3,4);

Ad_g = [rotation', -rotation'*skew(pos); zeros(3,3), rotation'];

end
