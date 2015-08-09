function [ azimuth_disamb, optmask ] = fuser( azimuth_hat, zenith_hat, ro, azimuth_smooth, zenith_smooth)
addpath('./library'); 

%FUSER Summary of this function goes here
%   Detailed explanation goes here
[n1 n2] = size(azimuth_hat);
Mask = zeros(n1,n2); 
valid = find(ro>=0); 
Mask(valid) = 1; 
indices = find(Mask);

%[azimuth_smooth, zenith_smooth] = depth_to_spherical_normals(dmSmooth); 
% [ymax, xmax] = size(dmSmooth);
azimuth_disamb = azimuth_hat;
zenith_disamb = zenith_hat;
patch_size = 5;
ch_mask=zeros(n1,n2);
for ii=1:numel(indices)
    [xx, yy] = ind2sub([n1 n2], indices(ii));
    if (xx == 1) && (yy == 1)
        xx = 1;
    end
    thisAzimuth = azimuth_hat(xx,yy);
    patch_linear_idx = getNeighbors( azimuth_hat, xx, yy, patch_size );
    patchMask = Mask(patch_linear_idx); 
    
    % Do for Azimuth
    thisAzimuthPatch = azimuth_hat(patch_linear_idx);
    thisAzimuthSmoothPatch = azimuth_smooth(patch_linear_idx);
    
    error = norm( patchMask.* (thisAzimuthPatch - thisAzimuthSmoothPatch ) );
    error_pi_min = norm( patchMask.* ( (thisAzimuthPatch - pi) - thisAzimuthSmoothPatch ) );
    error_pi_plus = norm( patchMask.* ( (thisAzimuthPatch + pi) - thisAzimuthSmoothPatch ) );
    er = cat(1, abs(error), abs(error_pi_min), abs(error_pi_plus));
    if (min(er) == abs(error_pi_min)) && (thisAzimuth>=0) 
%         thisAzimuth = thisAzimuth - pi;
%         azimuth_disamb(xx,yy) = thisAzimuth;
        ch_mask(xx,yy) = 1;
    elseif (min(er) == abs(error_pi_plus))  && (thisAzimuth<=0) 
%         thisAzimuth = thisAzimuth + pi;
%         azimuth_disamb(xx,yy) = thisAzimuth;
        ch_mask(xx,yy) = 1;
    elseif (abs(thisAzimuth - azimuth_smooth(xx,yy))>=2)
%         thisAzimuth = azimuth_smooth(xx,yy);
%         azimuth_disamb(xx,yy) = thisAzimuth;
        ch_mask(xx,yy) = 1;
    end
end

% Now let's optimize the mask
[gx, gy] = gradient(azimuth_hat);
EdgeMap(:,:,1) = abs(gx); % x direction
EdgeMap(:,:,2) = abs(gy); % y direction

% Optimization 
opts.lambda = 0.1;
opts.alpha = 1;
opts.epsilon = 1e-4;

optmask = computeOptim_hang(ch_mask, EdgeMap, opts);
optmask = round(optmask);

for ii=1:numel(indices)
    [xx, yy] = ind2sub([n1 n2], indices(ii));
    thisAzimuth = azimuth_hat(xx,yy);
    if (optmask(xx,yy) == 1) && (thisAzimuth>=0) 
        thisAzimuth = thisAzimuth - pi;
        azimuth_disamb(xx,yy) = thisAzimuth;
    elseif (optmask(xx,yy) == 1)  && (thisAzimuth<=0) 
        thisAzimuth = thisAzimuth + pi;
        azimuth_disamb(xx,yy) = thisAzimuth;
%     elseif (abs(thisAzimuth - azimuth_smooth(xx,yy))>=2.5)
%         thisAzimuth = azimuth_smooth(xx,yy);
%         azimuth_disamb(xx,yy) = thisAzimuth;
    end
end

end

