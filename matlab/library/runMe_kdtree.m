clc; clear; close all; 

% place this file in library
addpath('./helper_functions/d2n_kdtree/'); 

filename = 'norms_clean_corner.mat'; 
load(filename); 

%---------Computing smooth normals

disp('Computing Smooth Normals...'); 
[Xs, Ys, Zs] = d2n_kdtree(dm); 
[azimuth_smooth, zenith_smooth] = cartesian_to_spherical(Xs, Ys, Zs); 
disp('Done Computing Smooth Normals...'); 

%---------Save Output

save('kdtree_out.mat', 'azimuth_smooth', 'zenith_smooth', 'dm'); 
