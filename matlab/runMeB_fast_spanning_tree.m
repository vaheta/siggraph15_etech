clear;
close all;

addpath './library'; 
addpath './library/helper_functions/tensor_operators/';
addpath './data'; 

%% load normals
normal_filename = './data/input_for_integrator.mat'; 
load(normal_filename); 
N = poltof_norms; 
nx = -N(:,:,1); % Adjust convex/concave
ny = -N(:,:,2); 
nz = -N(:,:,3);


%% warp normals 
[my_a, my_z] = cartesian_to_spherical(nx,ny,ones(size(nx)));
[nx ny nz] = spherical_to_cartesian(my_a, 0.64*my_z); % found using rough alignment 0.64 refractive index correction.



%% load objmask
startrow = 125; stoprow = 224; 
startcol = 219; stopcol = 276; 
MASK = ones(size(poltof_norms(:,:,1)));
dH = stoprow - startrow + 1;
dW = stopcol - startcol + 1;
maskImg = rgb2gray(imread('norms_face_mask.png'));
objmask = zeros(size(maskImg));
objmask(maskImg == 255) = 1;
objmask_down = imresize(objmask, [dH, dW], 'nearest');



%% warp depth map
if exist('objmask','var')
    objmask_down = imresize(objmask, [dH, dW], 'nearest');
    dmcrop = dm(startrow:stoprow, startcol:stopcol).*objmask_down;
else
    dmcrop = dm(startrow:stoprow, startcol:stopcol);
end

dmtofit = (880 - dmcrop) / 2.2;
dmtofit = dmtofit .* objmask_down;
dmtofit = medfilt2(dmtofit, [3 3]);
dmcrop = dmtofit;
figure
imagesc(dmtofit);

dmcrop = imresize(dmcrop, size(nx), 'nearest')  .* mean(size(nx) ./ size(dmcrop))  .* objmask;
dmcrop(isnan(dmcrop)) = 0;figure
surfl(dmcrop); axis equal;



%% perform integration
% surface = poisson_solver_function_neumann(nx,ny);
lambda = 0.015; 
alpha = 1e-3; 

tic; 
surface = fast_spanning_tree_integrator(nx,ny,dmcrop,lambda,rho,alpha); 
time1 = toc; 

tic; 
% slow optimization with iterations
% surface2 = M_estimator_depth_kadambi(nx,ny,0,dmcrop,lambda*MASK); 
% surface2 = AffineTransformation_depth_kadambi(nx,ny,dmcrop,lambda); 
time2 = toc; 



%% display surface
close all; 
surface = surface .* objmask; % Exclude the boundaries
[height, width] = size(surface);
[X, Y] = meshgrid(1 : width, 1 : height);
viewAng = [41 24];
figure(1); 
myRenderSurface(X, Y, dmcrop, viewAng, 'Kinect');
figure(2); 
myRenderSurface(X, Y, surface, viewAng, ['Fast Optimization ',num2str(time1),' seconds']);

disp(sprintf('runtime for surface integration 1 was %g seconds',time1)); 




%% compare with different integrator
if exist('surface2','var')
    surface2 = surface2 .* objmask; % Exclude the boundaries
    figure(3); 
    myRenderSurface(X, Y, surface2, viewAng, ['Iterative Optimization ',num2str(time2),' seconds']);

    figure(4);
    imagesc(abs(surface-surface2)); title('Difference Image'); 
    disp(sprintf('runtime for surface integration 2 was %g seconds',time2)); 
end

save('./data/output_from_integrator.mat','dmcrop','surface'); 
