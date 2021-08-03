clear

X = linspace(-0.6, 1.4, 301);
v = linspace(1e-3, 10^(-1.5), 301);
V = zeros(length(v), length(X));

%%

for i = 1:length(v)
    for j = 1:length(X)
        vi = v(i);
        Xi = X(j);
        V(j, i) = (1/4)*Xi^4 - (1/3)*Xi^3 - (1/2)*Xi^2*vi + Xi*vi;
    end
end

%%
surf(v, X, V)
xlabel('\nu')
ylabel('X')
zlabel('V')
title('Surface showing the Potential Landscape')
