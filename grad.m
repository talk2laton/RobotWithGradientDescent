function g = grad(fun, t)
dt = 1e-4;
g = zeros(size(t));
ft = fun(t);
for n = 1:numel(t)
    tp = t; tp(n) = tp(n) + dt;
    g(n) = (fun(tp) - ft)/dt;
end