nus = [0.001; 0.007];
betas = [0 0.1; 0 0];
x0 = -sqrt(nus);
p0 = {nus, betas, sum(betas, 2)};
thresh = 0.8;
kmax = 1000;
alpha = 0.03;
h = 1e-3;
nw = 32;

% nw = 8, time = 160s
% nw = 16, time = 84s
% nw = 32, time = 46s

tic
parGetEsc(@bistable, x0, p0, kmax, thresh, alpha, h, nw)
toc


function f = bistable(x, p)

f = -(x - 1).*(x.^2 - p{1}) + p{2}*x - p{3}.*x;

end