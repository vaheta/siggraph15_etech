function [angErr, angDiffMap] = calcAngErr(N1, N2)

[height, width, dims] = size(N1);
N1 = reshape(N1, [height*width, 3]);
N2 = reshape(N2, [height*width, 3]);

angErr = mean(real(acos(dot(N1, N2, 2))) * 180/pi);
angDiffMap = reshape(real(acos(dot(N1, N2, 2))) * 180/pi, [height, width]);