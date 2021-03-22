function [c,ceq] = nonlin_const(x, k_m, k_e, psi, w, p)

    ceq = [];
    N = length(x)/2;
    c = 0;
    
    for i=1:N
        c = c + (k_m(i) + psi(i)*k_e(i)) / (x(i) + psi(i)*x(i+N) + psi(i)*w(i) + p(i));
    end
    
    c = c - 1;

end

