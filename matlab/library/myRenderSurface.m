function myRenderSurface(X, Y, Z, viewAng, titleText)

surf(X, Y, Z,'FaceColor', [0 0.5 0.8], 'EdgeColor', 'none');
axis off;
axis equal;
% camlight headright; lighting gouraud;
% camlight(45, 45); lighting gouraud;
% ll = [45, 20]; % lighting direction
ll = [45, 20]; 
camlight(ll(1), ll(2)); lighting gouraud;
view(viewAng);
title(titleText);