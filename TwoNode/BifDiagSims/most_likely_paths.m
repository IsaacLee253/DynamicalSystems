T = 50;
h = 1e-3;
t = 0:h:T;
beta = 0.3;
np = 500;
kmax = 100;
figure; hold on;
alpha = 0.1;
nu1 = 0.006;
deltanu = 0.005;
nu2 = nu1 + deltanu;
sq1 = sqrt(nu1);
sq2 = sqrt(nu2);

EQ = [-sq1 -sq1 -sq1  sq1  sq1  sq1  1.0  1.0  1.0;
      -sq2  sq2  1.0 -sq2  sq2  1.0 -sq2  sq2  1.0];
  
roots = cocoEqs(@bistuni, 'beta', [0 0.8], 0.3, EQ, {'beta','deltanu','nu1'}, [0 deltanu nu1]);

for j = 1:kmax %Find kmax realisations with escape times.
    
    nums = randn(4, 1000000);
    x = zeros(1, length(t)); %Prepare vector to store realisations
    y = zeros(1, length(t));
    xp = zeros(1, floor(length(t)/np));
    yp = zeros(1, floor(length(t)/np));

    x(1) = roots(1,1); %Initial conditions
    y(1) = roots(2,1);
    tx = 0;
    n = 1;
    ni = 1;
    p=1;
%     xesc = 0;
%     yesc = 0;
    ne = 0;

    for ii = t %Start taking time steps.

        if ni>=length(nums)
            nums = randn(4, 4*T/h);
            ni = 1;
        end

        %Evaluate deterministic part using Heun's scheme.
        kx1 = -(x(n)^2 - nu1)*(x(n) - 1) + beta*(y(n)-x(n));
        ky1 = -(y(n)^2 - nu2)*(y(n) - 1);

        %Apply noise
        hkx1 = x(n) + h*kx1 + alpha*nums(1, n)*sqrt(h);
        hky1 = y(n) + h*ky1 + alpha*nums(2, n)*sqrt(h);

        kx2 = -(hkx1^2 - nu1)*(hkx1 - 1) + beta*(hky1-hkx1);
        ky2 = -(hky1^2 - nu2)*(hky1 - 1);

        %Apply heun scheme and noise.
        x(n+1) = x(n) + (h/2)*(kx1+kx2) + alpha*nums(3, n)*sqrt(h);
        y(n+1) = y(n) + (h/2)*(ky1+ky2) + alpha*nums(4, n)*sqrt(h);

        %Step forward
        n = n + 1;
        ni = ni + 1;
        tx = tx + h;

        if mod(n, np) == 0
            xp(p) = x(n);
            yp(p) = y(n);
            p = p + 1;
        end
% 
%         %Check if x has escaped.
%         if x(n) > thresh && xesc == 0
%             xesc = 1;
%         end
% 
%         %Check if y has escaped.
%         if y(n) > thresh && yesc == 0
%             yesc = 1;
%         end
% 
%         %Check if both have escaped.
%         if xesc == 1 && yesc == 1
%             ne = ne + 1;
%         end
% 
%         if ne >= npe
%             break;
%         end

    end
    pl = plot(xp, yp);
    pl.Color = [0, 0.6, 0, 0.1];
end

for i = 1:length(roots)
    switch roots(3, i)
        case 0
            scatter(roots(1, i), roots(2, i), 'o', 'k');
        case 2
            scatter(roots(1, i), roots(2, i), 'x', 'k');
        case 1
            scatter(roots(1, i), roots(2, i), 'd', 'k');
    end
end

%%

function f = bistuni(x, p)

nu1 = p(1,:);
nu2 = nu1 + p(2,:);
beta = p(3,:);


x1 = x(1,:);
x2 = x(2,:);

f = [(-(x1 - 1.0).*(x1.^2 - nu1) + beta.*(x2-x1));
    (-(x2 - 1.0).*(x2.^2 - nu2))];

end