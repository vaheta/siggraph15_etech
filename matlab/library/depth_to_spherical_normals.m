function [azimuth, zenith] = depth_to_spherical_normals(dm)

[normx normy normz] = depth_to_normal(dm); 
l = sqrt( normx.^2 + normy.^2 + normz.^2 ); % length of vector
x = -normx./l;
y = normy./l; 
z = normz./l; 

azimuth = atan2(y,x); % use 4 quadrant rule
zenith = acos( z./l ); 


end