clc;
close all;
clear all;

% load surface_face_0p005.mat % Ours
% load surface_face_0p01.mat % Ours
% load surface_face_0p02.mat % Ours
addpath('./library'); 
load('./data/output_from_integrator.mat'); 


D_ours = surface;
D_kinect = dmcrop;
[height, width] = size(D_ours);
[X, Y] = meshgrid(1 : width, 1 : height);

% load('face_ND_scan.mat') % D_gt
% D_gt = imresize(D_gt, [height, width]);

maskImg = rgb2gray(imread('norms_face_mask.png'));

objmask = zeros(size(maskImg));
objmask(maskImg >128) = 1;
% D_gt = D_gt .* objmask;
D_ours = D_ours .* objmask;
D_kinect = D_kinect .* objmask;

%% Surface
viewAng = [53 30];



figure(1)
myRenderSurface(X, Y, D_kinect, viewAng, 'Kinect');

figure(2)
myRenderSurface(X, Y, D_ours, viewAng, 'Polarization-Enhanced Final Output');

% figure(3)
% myRenderSurface(X, Y, D_gt, viewAng, 'GT');