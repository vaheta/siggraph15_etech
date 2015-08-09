% function [graych, redch, bluech, greench] = rawproc(folder, minmax, step_size)
warning('off','all')
warning
folder = 'C:\Users\vahet_000\Pictures\DSLR_test85';
minmax = 350;
step_size = 10;
cutx1 = 1;
cutx2 = 4272;
cuty1 = 1;
cuty2 = 2848;


listing = dir(folder);
numoffiles = size(listing,1) - 2;

% if (numoffiles ~= minmax/step_size)
%     error('Wrong minmax or step_size');
% end

for i = 1:(numoffiles+2)
    if (strcmp(listing(i).name, '.') == 1) || (strcmp(listing(i).name, '..') == 1)
        continue
    end
    filepath = strcat(folder,'\', listing(i).name);
    importfile(filepath);
    [~,f_name,~] = fileparts(listing(i).name);
    command = strcat('[ymax xmax zmax] = size(', f_name, ');');
    eval(command);
    break
end
graych = zeros(cuty2-cuty1+1, cutx2-cutx1+1, numoffiles);
k = 0;
for i=1:(numoffiles+2)
    if (strcmp(listing(i).name, '.') == 1) || (strcmp(listing(i).name, '..') == 1)
        k = k + 1;
        continue
    end
    filepath = strcat(folder,'\', listing(i).name);
    importfile(filepath);
    [~,f_name,~] = fileparts(listing(i).name);
    
    command = strcat('graych(:,:,i-k) = rgb2gray(', f_name, '(cuty1:cuty2, cutx1:cutx2, :));');
    eval(command);

    command = ['clear ' f_name];
    eval(command);
end
save('graych.mat','graych','-v7.3');
clear graych;

redch = zeros(cuty2-cuty1+1, cutx2-cutx1+1, numoffiles);
k = 0;
for i=1:(numoffiles+2)
    if (strcmp(listing(i).name, '.') == 1) || (strcmp(listing(i).name, '..') == 1)
        k = k + 1;
        continue
    end
    filepath = strcat(folder,'\', listing(i).name);
    importfile(filepath);
    [~,f_name,~] = fileparts(listing(i).name);
    
    command = strcat('redch(:,:,i-k) = ', f_name, '(cuty1:cuty2, cutx1:cutx2,1);');
    eval(command);

    command = ['clear ' f_name];
    eval(command);
end

save('redch.mat','redch','-v7.3');
clear redch;

bluech = zeros(cuty2-cuty1+1, cutx2-cutx1+1, numoffiles);
k = 0;
for i=1:(numoffiles+2)
    if (strcmp(listing(i).name, '.') == 1) || (strcmp(listing(i).name, '..') == 1)
        k = k + 1;
        continue
    end
    filepath = strcat(folder,'\', listing(i).name);
    importfile(filepath);
    [~,f_name,~] = fileparts(listing(i).name);
    
    command = strcat('bluech(:,:,i-k) = ', f_name, '(cuty1:cuty2, cutx1:cutx2,3);');
    eval(command);

    command = ['clear ' f_name];
    eval(command);
end

save('bluech.mat','bluech','-v7.3');
clear bluech;

greench = zeros(cuty2-cuty1+1, cutx2-cutx1+1, numoffiles);
k = 0;
for i=1:(numoffiles+2)
    if (strcmp(listing(i).name, '.') == 1) || (strcmp(listing(i).name, '..') == 1)
        k = k + 1;
        continue
    end
    filepath = strcat(folder,'\', listing(i).name);
    importfile(filepath);
    [~,f_name,~] = fileparts(listing(i).name);
    
    command = strcat('greench(:,:,i-k) = ', f_name, '(cuty1:cuty2, cutx1:cutx2,2);');
    eval(command);

    command = ['clear ' f_name];
    eval(command);
end

save('greench.mat','greench','-v7.3');
clear greench;
clear command f_name filepath folder i listing minmax numoffiles step_size xmax ymax zmax cutx1 cutx2 cuty1 cuty2 k;