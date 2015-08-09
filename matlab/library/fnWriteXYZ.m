function fnWriteXYZ(dm,OUTPUT_FILENAME,startx,stopx,starty,stopy,objmask)

if nargin<7
    objmask = ones(size(dm)); 
end

addpath ./library/
addpath ./library/d2n_kdtree/
% normal_filename = 'norms_cup.mat';
% load(normal_filename); 
% 
% [~,savename] = fileparts(normal_filename);
% OUTPUT_FILENAME=[savename,'_depth','.xyz'];

% dm = dm(196:233,250:281).*objmask; % this is for cup
dm = dm./1000; 
[XX,YY,ZZ] = get_real_world_achoo2(dm,startx,stopx,starty,stopy);

% XX = XX(startx:stopx,starty:stopy).*objmask;
% YY = YY(startx:stopx,starty:stopy).*objmask;
% ZZ = ZZ(startx:stopx,starty:stopy).*objmask;


xx = vec(XX);
yy = vec(YY);
zz = vec(ZZ);

fid = fopen(OUTPUT_FILENAME,'w');


for ii=1:numel(xx)
    if zz(ii)<=0
        continue
    end
    
    thisLine = [xx(ii) yy(ii) zz(ii)];
    fprintf(fid,'%f %f %f\n', thisLine);
end

fclose(fid);

clear fid

end

