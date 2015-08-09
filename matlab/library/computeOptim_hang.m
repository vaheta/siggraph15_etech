function [DepthOut] = computeOptim_hang(MaskIn, EdgeMap, opts)

lambda = opts.lambda; % smoothness
epsilon = opts.epsilon;
alpha = opts.alpha; % the effects of contrast, larger means shaper edges

[M, N] = size(MaskIn);

% Weight
%w = ones(M, N);
ed = EdgeMap(:,:,1).^2 + EdgeMap(:,:,2).^2;
ed = ed - min(ed(:));
ed = ed/max(ed(:));
w = 1 - ed;
% figure; imshow(w); title('weight');
Weight = sparse(N*M, N*M);
Weight = spdiags(w(:), 0, Weight);

% construct A
A = sparse(M*N, M*N);

Dx = - 1./ (EdgeMap(:,:,1).^alpha+ epsilon);
Dy = - 1./ (EdgeMap(:,:,2).^alpha+ epsilon);
A = spdiags(Dy(:) , -1, A);
A = A .* kron(eye(N), sparse(toeplitz([1,1, zeros(1,M-2)]))) ;
A = spdiags(Dx(:) , -M, A);
A = A + A';

% A's main diagonals
A = spdiags(-sum(A, 2), 0, A);
% spy(A);

% add weight
A = Weight + lambda * A;

% RHS
b = w(:) .* MaskIn(:);

%% Solving the equation
X = A\b;

DepthOut = reshape(X, [M, N]);

