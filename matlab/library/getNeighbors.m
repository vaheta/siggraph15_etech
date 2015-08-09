function [lidx] = getNeighbors(A, m, n, psize)
% Achuta Kadambi, 2012. 
% An efficient way to get neighbors of Matrix. 
% psize is the size of square patch (must be odd).  
% m and n are the coordinates of the center of the patch. 
% EXAMPLE USAGE
% A = rand(7,7); 
% lidx = getNeighbors(A, 4, 4, 3);

if nargin<4
    psize = 3; % default is 3 cross 3 patch
end

r=floor(psize/2);
[M N] = meshgrid(m+(-r:r), n+(-r:r));

mxM = max( vec(M) ); 
miM = min( vec(M) ); 
mxN = max( vec(N) ); 
miN = min( vec(N) ); 

[rows cols] = size(A); 
if miM<1 || miN<1 || mxM>rows || mxN>cols 
    lidx = sub2ind(size(A),m,n); 
    return
end

nidx=numel(M);
lidx=zeros(nidx,1);
for i=1:nidx
    lidx(i)=sub2ind(size(A),M(i),N(i));
end

end

