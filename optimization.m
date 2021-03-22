close all;
clear all;
clc;

   
n = 10:10:100; % Customers
Z = 10000;
options = optimoptions('fmincon','Algorithm','sqp');

for N in n:
    psi = ones(1, N) * 0.9999;
    K_m = ones(1, N) * 50;
    K_e = ones(1, N) * 50;

    w = ones(1, N) * 3;
    p = ones(1, N) * 5;
% |----z----|----b----|
    lb = zeros(1, 2*N);
    x0 = lb;
    A = [(1/N)*ones(1,N), zeros(1,N)];
    b = [Z];
    res = fmincon(@(x)objective(x), x0, A, b, [], [], lb, [],...
              @(x)nonlin_const(x, K_m, K_e, psi, w, p), options)
end