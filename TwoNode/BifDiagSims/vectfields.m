x = linspace(-0.3, 1.2, 20);
y = linspace(-0.3, 1.2, 20);
nu1 = 0.005;
nu2 = 0.011;
beta = 0.3;
u = zeros(length(x), length(y));
v = zeros(length(x), length(y));

for i = 1:length(x)
    for j = 1:length(y)
        u(i,j) = -(x(i) - 1).*(x(i).^2 - nu1) + beta*(y(j) - x(i));
        v(i,j) = -(y(j) - 1).*(y(j).^2 - nu2);
    end
end

figure(2); hold on;
quiver(x, y, u.',v.');
% startx = [zeros(1, 21)-0.2, zeros(1,21)+1.1, 0.2:0.1:0.7];
% starty = [0:0.05:1, 0:0.05:1, zeros(1,6)+0.2];
% streamline(x, y, u.', v.', startx, starty);