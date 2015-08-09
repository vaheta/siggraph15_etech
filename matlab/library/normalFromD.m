function Nimg_gt = normalFromD(D)
[Nx, Ny, Nz] = surfnorm(D);
Nimg_gt = zeros(size(D, 1), size(D, 2), 3);
Nimg_gt(:,:,1) = Nx;
Nimg_gt(:,:,2) = -Ny;
Nimg_gt(:,:,3) = Nz;