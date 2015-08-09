function [surface] = surfplotter(norms,type)
if nargin<2
    type='fc'
end

% [H,W,~] = size(norms);
gx = norms(:,:,1);
gy = norms(:,:,2);
gx(:,end) = 0;
gy(end,:) = 0;
ymax = size(norms, 1);
xmax = size(norms, 2);
norms1 = zeros(ymax,xmax,3);
for y = 1:ymax
    for x = 1:xmax
        if (norms(y,x,3) ~= 0)
            norms1(y,x,:) = [-norms(y,x,1)/norms(y,x,3), -norms(y,x,2)/norms(y,x,3), -1];
        else
            norms1(y,x,:) = [0, 0, -1];
        end
    end
end
% disp('============================================');

if strcmp(type,'fc')
    disp('Frankot-Chellappa Algorithm')
    surface = frankotchellappa(gx,gy);
    surface = surface - mean(surface(:,end));
elseif strcmp(type,'poisson')
    surface = poisson_solver_function_neumann(gx,gy);
    surface = surface - mean(surface(:,end));
elseif strcmp(type,'m')
    disp('M estimator');
    surface = M_estimator(gx,gy,0);
    surface = surface - mean(surface(:,end));
elseif strcmp(type,'affine'); 
    [surface,D11,D12,D22] = AffineTransformation(gx,gy);
    surface = surface - mean( surface(:,end) );
end


% 
% disp('M estimator');
% r_M = M_estimator(gx,gy,0);
% r_M = r_M - mean(r_M(:,end));

% disp('Least squares solution by solving Poisson Equation')
% r_ls = poisson_solver_function_neumann(gx,gy);
% r_ls = r_ls - mean(r_ls(:,end));
% 
% disp('Affine transformation of gradients using Diffusion tensor')
% [x,D11,D12,D22] = AffineTransformation(gx,gy);
% x = x - mean(x(:,end));

mydisplay(surface);
axis on;title( sprintf('Surface using %s integrator', type) ); 

% mydisplay(r_M);
% axis on;title('M estimator');

% mydisplay(r_ls);
% axis on;title('Least Squares');
% 
% mydisplay(x);
% axis on;title('Affine Transformation');

% [mse_ls] = calculate_mse(dm,fc,0.01);
% disp(sprintf('FC: MSE = %f',mse_ls));
% 
% [mse_ls] = calculate_mse(dm,r_M,0.01);
% disp(sprintf('M estimator: MSE = %f',mse_ls));
% 
% [mse_ls] = calculate_mse(dm,r_ls,0.01);
% disp(sprintf('LS: MSE = %f',mse_ls));
% 
% [mse_ls,rmse_ls] = calculate_mse(dm,x,0.01);
% disp(sprintf('Affine Transformation: MSE = %f',mse_ls));

end