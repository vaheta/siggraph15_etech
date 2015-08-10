function [NX, NY, NZ] = d2n_kdtree(dm) 
% input is dm in mm

%---------convert depth map to meters
dm = dm./1000; % convert depth map to meters. 
[yres,xres] = size(dm); 

%---------mask off zero entries
dm(dm==0) = NaN; 
Mask = ~isnan(dm); 

%---------get real world coordinates.
[X,Y,Z] = get_real_world_achoo(dm); 

%---------call microsoft function for plane principal analysis
radius= 0.02; 
view_point= [0,0,0]; 
[NX,NY,NZ] = surfnorm( X,Y,Z);

%---------display surface normals
N = zeros(yres, xres, 3);
N(:, :, 1) = NX;
N(:, :, 2) = NY;
N(:, :, 3) = -NZ; % Adjust the coordinate system

N(isnan(N)) = 0;

% figure;
% imshow(uint8((N+1)*128))

end 