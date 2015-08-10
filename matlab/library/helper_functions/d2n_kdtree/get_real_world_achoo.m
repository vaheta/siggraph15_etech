function [X,Y,Z] = get_real_world_achoo( dm )

if nargin<1
    load('fulldm.mat'); 
end

if size(dm) ~= [480 640]
    warning('Your depth map must be kinect size'); 
end

x_res = 640; 
y_res = 480; % pixels

fov_x = 57; % degrees
fov_y = 43; % degrees

focal_x = x_res/(2*tand(fov_x/2)); 
focal_y = y_res/(2*tand(fov_y/2)); 

u_center = floor(x_res/2); 
v_center = floor(y_res/2); 


[UU, VV]=meshgrid(1:x_res,1:y_res);

% UU = uint16(UU);
% VV = uint16(VV);

X = dm .* (UU - u_center) * (1/focal_x); 
Y = dm .* (v_center - VV) * (1/focal_y);  
Z = dm; 

end
