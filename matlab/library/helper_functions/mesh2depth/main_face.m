clc;
close all;
clear all;

% load surface_cup_0p005_combiN50.mat
% D_kinect = surface;

load surface_face_0p01.mat
D_kinect = surface;
[height, width] = size(D_kinect);
% D_kinect = imresize(D_kinect, [363, 281]);

%
% Make the render-buffers RGB and depth
d_zero = 0;
% height = 363;
% width = 281;
I = zeros (height,width,6); 
I(:,:,5) = d_zero; % Background depth 
% Load Patch object
load face_FV.mat;

% Transform coordinates to [-1..1] range
FV.vertices = FV.vertices-mean(FV.vertices(:));
FV.vertices = FV.vertices ./max(FV.vertices(:));
% Calculate the normals 
FV.normals=patchnormals(FV);
% Set the ModelViewMatrix
FV.modelviewmatrix=[1 0 0 0; 0 1 0 0;0 0 1 0; 0 0 0 1];
% Load the texture
FV.textureimage=im2double(0.6*ones(height,width,3));
% Make texture coordinates in range [0..1]
FV.texturevertices=(FV.vertices(:,1:2)+1)/2;
% Set the material to shiny values
FV.material=[0.3 0.6 0.9 20 1]; % Set the 4-th bit to INF to get Lambertian image
% Set the light position
FV.lightposition=[0.67 0.33 -2 1];
% Set the viewport 
FV.viewport=[64 64 128 128];
FV.enableshading=1;
FV.enabletexture=1;
FV.culling=1;
% Render the patch
J=renderpatch(I,FV); 
%Show the RGB buffer
figure, h=imshow(J(:,:,1:3));
% Rotate the object slowly while showing the render result

%
% transm = transformmatrix(1.9,[3.5 0 1.3],[0 0 0]); % For Caesar
transm = transformmatrix(5.5,[-0.1 0 pi/1.98],[-0.2 0.26 1.1]); % For cup
FV.modelviewmatrix = transm*FV.modelviewmatrix;
J = renderpatch(I,FV); set(h,'CData',J(:,:,1:3)); drawnow('expose');
D = J(:,:,5);

% imwrite(J(:,:,1:3), 'gt.png');
figure(2)
imshow(imread('norms_face.png'));

%%
figure(11)
D_toFit = D;
offset = 7.92;
D_toFit(D_toFit == d_zero) = offset;
D_toFit = D_toFit - offset;
D_toFit(D_toFit < 0) = 0;
D_toFit = D_toFit ./ max(D_toFit(:));
D_toFit = D_toFit .* 10;

imagesc(D_toFit);
axis equal;
colorbar;

figure(12)
imagesc(D_kinect);
axis equal;
colorbar;

%%

% Align this D with the Kinect depth by solving D_kinect = scale*D + offset
% Fitting a first order polynomial
p = polyfit(D_toFit, D_kinect, 1);
D = polyval(p, D_toFit);

figure(13)
imagesc(D);
axis equal;
colorbar;


figure(3)
surfl(D);
hold on;
surfl(D_kinect);
shading interp;
axis equal;

[Nx Ny Nz] = surfnorm(D);
Nimg_gt = zeros(height, width, 3);
Nimg_gt(:,:,1) = Nx;
Nimg_gt(:,:,2) = -Ny;
Nimg_gt(:,:,3) = Nz;
figure(4)
imshow(uint8((Nimg_gt+1)*128));

D_gt = D;

save face_ND_scan.mat D_gt Nimg_gt;