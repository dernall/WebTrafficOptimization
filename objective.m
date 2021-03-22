function [B] = objective(x)
    B = 0;
    B = sum(x((length(x)/2 + 1):end)) / (length(x)/2);
end

