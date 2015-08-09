function [ nX, nY, nZ ] = compute_norm(xCh,yCh,zCh,radius,view_point)
% compute_norm(xCh,yCh,zCh,radius,view_point) computes the normal for
% each point in the map, providing three output channels representing the
% components in the 3 directions. 

% use default values radius=.02 and view_point=[0,0,0]

% relies upon http://www.mathworks.com/matlabcentral/fileexchange/21512

nX = nan(size(xCh));
nY = nX; nZ = nX;
non_nan_idx = ~isnan(xCh(:)) & ~isnan(yCh(:)) & ~isnan(zCh(:));
points = [xCh(non_nan_idx) yCh(non_nan_idx) zCh(non_nan_idx)];
ktree = kdtree_build(points);
[i,j] = ind2sub(size(xCh),find(non_nan_idx));
num_points = length(i);
for k=1:num_points
    idx = kdtree_ball_query(ktree,points(k,:),radius);
    normal = estimate_normal_point(points(idx,:));
    normal = normal ./ norm(normal);
    % check orientation
    if dot(normal,(view_point-points(k,:))) < 0 
        normal = -normal;
    end
    nX(i(k),j(k)) = normal(1);
    nY(i(k),j(k)) = normal(2);
    nZ(i(k),j(k)) = normal(3);
end
kdtree_delete(ktree);
end

function [normal] = estimate_normal_point(neighborhood)
normal = nan(3,1);
[num_points, ncols] = size(neighborhood);
if num_points < 3
    return
end
shifted_neigh = neighborhood - repmat(mean(neighborhood,1),[num_points,1]);
[U,S,V] = svd(shifted_neigh,0);
normal = V(:,3);
end
