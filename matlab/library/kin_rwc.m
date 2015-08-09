function [ azimuth, zenith, X, Y, Z ] = kin_rwc( dm )
%KIN_RWC Summary of this function goes here
%   Detailed explanation goes here
if size(dm) ~= [424 512]
    error('Your depth map must be kinect size'); 
end

x_res = 512; 
y_res = 424; % pixels

fov_x = 69; % degrees
fov_y = 58; % degrees

focal_x = x_res/(2*tand(fov_x/2)); 
focal_y = y_res/(2*tand(fov_y/2)); 

u_center = floor(x_res/2); 
v_center = floor(y_res/2); 


[UU, VV]=meshgrid(1:x_res,1:y_res);

X = dm .* (UU - u_center) * (1/focal_x); 
Y = dm .* (v_center - VV) * (1/focal_y);  
Z = dm; 

[normx, normy, normz] = surfnorm(X,Y,Z);

l = sqrt( normx.^2 + normy.^2 + normz.^2 ); % length of vector
x = -normx./l;
y = normy./l; 
z = normz./l; 

azimuth = atan2(y,x); % use 4 quadrant rule
zenith = acos( z./l ); 

end

