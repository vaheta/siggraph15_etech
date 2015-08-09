function [normx normy normz] = spherical_to_cartesian(azimuth,zenith)

normx = 1*sin(zenith) .* cos(azimuth); 
normy = 1*sin(zenith) .* sin(azimuth); 
normz = 1*cos(zenith); 

l = sqrt( normx.^2 + normy.^2 + normz.^2 ); 
normx = normx./l; 
normy = normy./l; 
normz = normz./l;

end