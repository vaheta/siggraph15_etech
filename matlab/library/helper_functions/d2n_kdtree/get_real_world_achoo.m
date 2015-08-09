function [X,Y,Z] = get_real_world_achoo( dm )

if nargin<1
    load('fulldm.mat'); 
end

if size(dm) ~= [424 512]
    warning('Your depth map must be kinect size'); 
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

end
