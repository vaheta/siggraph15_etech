function [grad, norms] = normals (phi, theta)
ymax = size(phi, 1); 
xmax = size(phi, 2);
px = zeros(ymax,xmax);
py = zeros(ymax,xmax);
pz = zeros(ymax,xmax);
grad = zeros(ymax,xmax,3);
norms = zeros(ymax,xmax,3);
for y = 1:ymax
    for x = 1:xmax
        px(y,x) = cos(phi(y,x)) * sin(theta(y,x));
        py(y,x) = sin(phi(y,x)) * sin(theta(y,x));
        pz(y,x) = cos(theta(y,x));
        norms(y,x,:) = [px(y,x), py(y,x), pz(y,x)];
        grad(y,x,:) = [-px(y,x)/pz(y,x), -py(y,x)/pz(y,x), -1];
    end
end