addpath('./library/'); 
addpath('./data'); 

importfiletiff('data/1.tiff');
importfiletiff('data/2.tiff');
importfiletiff('data/3.tiff');
load('data/dm.mat');
dm = double(dm);
graych(:,:,1) = rgb2gray(x1);
graych(:,:,2) = rgb2gray(x2);
graych(:,:,3) = rgb2gray(x3);


%% Runme_Fuser

addpath('./library/helper_functions/d2n_kdtree/'); 
addpath('./library/'); 
addpath('./data'); 

% Defining the refractive index. We use the same value for all the scenes
refr_idx = 1.5;

% (Scene specific)
% This value is used to define the maximum angle of polarizer used in the
% measurements. It is assumed that the starting angle was 0 and the step is
% equal for all the measurements (e.g. 0, 30, 60, 90, 120, 150).
max_angle = 90;

% (Scene specific) 
% Defining the coordinates on the photos and on the depth map to crop the object and resize
% ratio to resize the cropped photos.
% For depth map the cropping region in z-direction (depth, in mm) is also 
% defined, everything out of that zone is changed to NaN.

[imsize_y, imsize_x, imsize_z] = size(x1);

im_x_begin = 1;
im_x_end = imsize_x;
im_y_begin = 1;
im_y_end = imsize_y;
resize_ratio = 1;

% dm_x_begin = 347;
% dm_x_end = 380;
% dm_y_begin = 118;
% dm_y_end = 151;
% dm_z_begin = 1000;
% dm_z_end = 1200;

% Cropping the object from the photos so that it is aligned with the 
% depth map and resizing the image to about 1000px 
% on the biggest side so that the processing is fast enough.

grch = graych(im_y_begin:im_y_end, im_x_begin:im_x_end, :);
grch = imresize(grch, resize_ratio);

% Changing max_angle to be a correct input for polarization2normals
% function. Calculating estimates for azimuth angle, zenith angle and degree
% of polarization from images.

max_angle = max_angle + max_angle/(size(grch,3) - 1);
[azimuth_hat, zenith_hat, rho] = polarization2normals(grch, max_angle, refr_idx);
zenith_hat = medfilt2 (zenith_hat, [5,5]);


% Creating the mask of the object
% 
% objmask = dm(dm_y_begin:dm_y_end, dm_x_begin:dm_x_end);
% objmask(objmask>dm_z_end) = NaN;
% objmask(objmask <= dm_z_begin) = NaN;
% objmask = ones(size(objmask)) - isnan(objmask);
% objmask(objmask == 0) = NaN;

% 
[NX, NY, NZ] = surfnorm (dm);
[azimuth_smooth, zenith_smooth] = cartesian_to_spherical(NX,NY,NZ);

% Cropping the part of the depth map and azimuth/zenith maps that were
% generated using the depth map.

azimuth_smooth = (azimuth_smooth(2:20, 2:20));
azimuth_smooth = imresize( azimuth_smooth, size(azimuth_hat) ,'nearest');
zenith_smooth = zenith_smooth(2:20, 2:20);
zenith_smooth = imresize( zenith_smooth, size(zenith_hat) ,'nearest');
dm = imresize( dm, size(azimuth_smooth) ); 
% Running fuser (the function that does dismabiguation of azimuth angle).

[ azimuth_disamb, ch_mask ] = fuser( azimuth_hat, zenith_hat, rho, azimuth_smooth, zenith_smooth); 

% Calculating normals from disambiguated azimuth and polarization zenith.

[poltof_grad, poltof_norms] = normals(-azimuth_disamb, zenith_hat); 

% Calculating normals from polarization azimuth and polarization zenith.

[pol_grad, pol_norms] = normals(azimuth_hat, zenith_hat); 

% Saving the output.

save('./data/input_for_integrator.mat','azimuth_disamb','azimuth_hat','azimuth_smooth',...
    'dm','pol_grad','pol_norms','poltof_grad','poltof_norms','zenith_hat','zenith_smooth','rho','refr_idx'); 
