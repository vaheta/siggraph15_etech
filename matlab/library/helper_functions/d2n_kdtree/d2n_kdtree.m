function [NX, NY, NZ] = d2n_kdtree(dm, radius) 
% input is dm in mm

if nargin<2
    radius = 0.02; 
end

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
[NX,NY,NZ] = compute_norm( X, Y, Z, radius, view_point );

%---------display surface normals
N = zeros(yres, xres, 3);
N(:, :, 1) = NX;
N(:, :, 2) = NY;
N(:, :, 3) = -NZ; % Adjust the coordinate system

N(isnan(N)) = 0;

% figure;
% imshow(uint8((N+1)*128))

end 