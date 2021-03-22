close all
clear, clc

N = 1:1:20;
Z = 1;
options = optimoptions('fmincon','Algorithm','sqp');
vals = zeros(1,length(N));
P = [0.95, 0.99, 1];
C_max = 34;
C_min = 0.5;

V_m = 0.5; %ћбит (главный)
V_e = 2; %ћбит (дополнительный)

markers = ["-*" "-*" "-*"];
colors = ["r" "k" "b"];
i = 1; j = 1;
figure();
for ps = P 
    for n = N % Customers
    psi = ones(1, n) * ps; %веро€тность просмотра страницы
    step = (C_max - C_min) / (n - 1); 
    Ci = C_min : step : C_max;
    K_m = ones(1, n) * mean(V_m ./ Ci); %мат ожидание (размер главного объекта / максимально достижима€ скорость)
    K_e = ones(1, n) * mean(V_e ./ Ci); %мат ожидание (размер добавочного объекта / максимально достижима€ скорость)
    
    w = ones(1, n) * 2; %врем€ просмотра страницы
    p = ones(1, n) * 0.5; %врем€ паузы
    % |----z----|----b----|
    lb = zeros(1, 2*n); %нижн€€ граница
    x0 = lb;
    A = [(1/n)*ones(1,n), zeros(1,n)];
    b = Z;
    res = fmincon(@(x)objective(x), x0, A, b, [], [], lb, [],...
            @(x)nonlin_const(x, K_m, K_e, psi, w, p), options);
    vals(i) = mean(res(n+1:end));
    i = i + 1;
    disp(mean(res(n+1:end)));
    end
    
    plot(N, vals, markers(j), 'Color', colors(j), 'MarkerFaceColor', 'b');
    j = j + 1;
    xlabel("Customers");
    ylabel("Expected loading time of additional part of the page");
    grid on; hold on;
    i = 1;
end
legend("psi = 0.95", "psi = 0.99", "psi = 1");
title("Expected loading time of additional part of the page");
