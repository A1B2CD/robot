function addedMass = calculateCylinderAddedMass(mass,length,radius,density_water)
% returned as a 6-element vector
addedMass(1) = 0.1*mass;
addedMass(2) = pi*density_water*radius^2*length;
addedMass(3) = pi*density_water*radius^2*length;
addedMass(4) = 0;
addedMass(5) = 1/12*pi*density_water*radius^2*length^3;
addedMass(6) = 1/12*pi*density_water*radius^2*length^3;

end