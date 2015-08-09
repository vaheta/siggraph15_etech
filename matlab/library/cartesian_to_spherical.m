function [azimuth, zenith] = cartesian_to_spherical(nx,ny,nz) 
l = sqrt( nx.^2 + ny.^2 + nz.^2 ); 
azimuth = atan2(ny,nx); % use 4 quadrant rule
zenith = acos( nz./l ); 
end 