clear; clc; close all;
cd ..
system ('./ard.sh')
%system ('./depth.sh')
cd matlab/

addpath('./library/'); 
addpath('./data'); 

importfiletiff('data/1.tiff');
importfiletiff('data/2.tiff');
importfiletiff('data/3.tiff');
importfileppm('data/dm.ppm');
%load('data/dm.mat');
dm = double(dm);
dm_cropped = dm(85:193 , 321:405  );
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
ze1 = medfilt2 (zenith_hat, [5,5]);
az = medfilt2(azimuth_hat, [5,5]);

zel = zenith_hat;
az = azimuth_hat;

keep = 0.05;
ze1(abs(ze1)<keep*max(abs(ze1(:))))=0;
az(abs(az)<keep*max(abs(az(:))))=0;


 [grad, norms] = normals(azimuth_hat, ze1);
 
 %%
 figure
 subplot(1,3,1); imagesc(zenith_hat); title('Zenith Angle')
 subplot(1,3,2); imagesc(azimuth_hat); title('Azimuth Angle')
 subplot(1,3,3);
 
ze1 = medfilt2 (zenith_hat, [5,5]);
az = medfilt2(azimuth_hat, [5,5]);
 bump = zeros(size(zenith_hat,1),size(zenith_hat,2),3);
bump(:,:,1) = zenith_hat;
bumpt(:,:,2) = azimuth_hat;
bump(:,:,2) = azimuth_hat;
bump(:,:,3)=1; 
 
imagesc(bump); title('normal map'); 
 
 final = surfplotter(norms,'affine');
 drawnow
 
 %%
 figure(gcf);

 view_theta = linspace(-30,30,100);
 for vv = 1:length(view_theta)
    view([1*cos(view_theta(vv)*pi/180),1*sin(view_theta(vv)*pi/180),0])
    %camroll(-90);
    pause(.1)
 end
 
%  %%
%  
%  ha = [];
%  figure;
%   ha(1) = subplot(1,2,1)
%   surfl(final); axis ij; shading interp; colormap gray; axis off;
%   view([45,45,0]);
%     
%   ha(2) = subplot(1,2,2)
%   imagesc(dm_cropped)
  
%   
% surfl(final);axis ij;shading interp;colormap gray;axis off;
%   ha(2) = subplot(1,2,2)
%   
%   
%   
% surfl(dm_cropped); zlim([1104,1105]); axis ij; shading interp; colormap gray; axis off;
%  
%  linkaxes(ha,'xy');