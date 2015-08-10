clear;
close all;

addpath './library'; 
addpath './library/helper_functions/tensor_operators/';
addpath './data'; 

importfileppm('data/dm.ppm');
dm_kinect = double(dm);


dm = dm_kinect;
%% load normals
normal_filename = './data/input_for_integrator.mat'; 
load(normal_filename); 
N = poltof_norms; 
nx = -N(:,:,1); % Adjust convex/concave
ny = -N(:,:,2); 
nz = -N(:,:,3);


%% warp normals 
[my_a, my_z] = cartesian_to_spherical(nx,ny,ones(size(nx)));
zen_scale = .64; %before was .64
my_a_flat = zeros(size(my_a)); 

polmask = rho;
rho_thres = 0.07; 
polmask(polmask>=rho_thres) = 1;
polmask(polmask<rho_thres) = 0; 

my_a_rho = zeros(size(my_a)); 
my_a_rho(find(polmask)) = my_a(find(polmask)); 

figure; imagesc(my_a_rho); 

[nx ny nz] = spherical_to_cartesian(my_a_rho, zen_scale*my_z); % found using rough alignment 0.64 refractive index correction.



%% load objmask

startrow = 125; stoprow = 151; 
startcol = 353; stopcol = 382; 
% MASK = ones(size(poltof_norms(:,:,1)));
% dH = stoprow - startrow + 1;
% dW = stopcol - startcol + 1;
% maskImg = rgb2gray(imread('norms_face_mask.png'));
% objmask = zeros(size(maskImg));
% objmask(maskImg == 255) = 1;
% objmask_down = imresize(objmask, [dH, dW], 'nearest');



%% warp depth map
if exist('objmask','var')
    objmask_down = imresize(objmask, [dH, dW], 'nearest');
    dmcrop = dm(startrow:stoprow, startcol:stopcol).*objmask_down;
    dmkcrop = dm_kinect(startrow:stoprow, startcol:stopcol).*objmask_down; 
else
    dmcrop = dm_kinect(startrow:stoprow, startcol:stopcol);
    dmkcrop = dm_kinect(startrow:stoprow, startcol:stopcol);
end

dmtofit = (880 - dmcrop) / 2.2;
%dmtofit = dmtofit .* objmask_down;
dmtofit = medfilt2(dmtofit, [3 3]);
dmcrop = dmtofit;
figure
imagesc(dmtofit);

dmcrop = imresize(dmcrop, size(nx), 'nearest')  .* mean(size(nx) ./ size(dmcrop));%  .* objmask;
dmkcrop = imresize(dmkcrop, size(nx), 'nearest')  .* mean(size(nx) ./ size(dmkcrop));%  .* objmask;

dmcrop(isnan(dmcrop)) = 0;figure
surfl(dmcrop); axis equal;



%% perform integration
%surface = poisson_solver_function_neumann(nx,ny);
lambda = 0.01;
alpha = 1e-3; 

dmflatcrop = 1000*ones(size(nx)); 

tic; 
surface = fast_spanning_tree_integrator(nx,ny,dmflatcrop,lambda,rho,alpha); 
time1 = toc; 

tic; 
% slow optimization with iterations
% surface2 = M_estimator_depth_kadambi(nx,ny,0,dmcrop,lambda*MASK); 
% surface2 = AffineTransformation_depth_kadambi(nx,ny,dmcrop,lambda); 
time2 = toc; 

%% mask kinect depth
dmkcrop(dmkcrop<1.6e4) = 0; 
dmkcrop(dmkcrop>1.8e4) = 0; 
dmkcrop_mask = dmkcrop; 
dmkcrop_mask(dmkcrop_mask<=0) = 0; 
dmkcrop_mask(dmkcrop_mask>0) = 1;

offset = dmkcrop_mask.*ones(size(dmkcrop)).*max(dmkcrop(:)); 
dmkcrop = dmkcrop - offset; 

%% display surface
close all;

surface = surface;% .* objmask; % Exclude the boundaries
surface_orig = surface; 

viewAng = [126 50];
figure(1); 
cropIdx = 33; 
dmcrop = dmcrop(cropIdx:size(dmcrop,1),cropIdx:size(dmcrop,2));
dmkcrop = dmkcrop(cropIdx:size(dmkcrop,1),cropIdx:size(dmkcrop,2));
[XX,YY] = meshgrid(1:size(dmkcrop,2),1:size(dmkcrop,1));
myRenderSurface(XX, YY, dmkcrop, viewAng, 'Kinect');
figure(2); 
cropIdx = 33; 


surface = surface(cropIdx:size(surface,1),cropIdx:size(surface,2));

%%
polmask_crop = polmask(cropIdx:size(polmask,1),cropIdx:size(polmask,2)); 
zenith_hat_crop = zenith_hat(cropIdx:size(zenith_hat,1),cropIdx:size(zenith_hat,2)); 
rho_crop = rho(cropIdx:size(rho,1),cropIdx:size(rho,2)); 
[XX,YY] = meshgrid(1:size(surface,2),1:size(surface,1)); 

zz = surface; 
zz=zz-999;
% 
zen_thres = zenith_hat_crop; 
zen_thres(zen_thres<1.05)=0; 
offset = zen_thres .* 5; 
zz = zz - offset; 
%zz(zz<-8)=-1; 

myRenderSurface(XX, YY, zz, viewAng, ['Fast Optimization ',num2str(time1),' seconds']);

disp(sprintf('runtime for surface integration 1 was %g seconds',time1)); 




%% compare with different integrator
if exist('surface2','var')
    surface2 = surface2;% .* objmask; % Exclude the boundaries
    figure(3); 
    myRenderSurface(X, Y, surface, viewAng, ['Iterative Optimization ',num2str(time2),' seconds']);

    figure(4);
    imagesc(abs(surface-surface2)); title('Difference Image'); 
    disp(sprintf('runtime for surface integration 2 was %g seconds',time2)); 
end

save('./data/output_from_integrator.mat','dmcrop','surface'); 
