function [ ar ] = dispositions( el )
%DISPOSITIONS(el) gives a matrix with one disposition of el(:) per row 
    n = length(el);
    if (n==1)
        ar = el(1);
        return;
    end
    ar = zeros(factorial(n),n);
    for i=1:n
        from = (i-1)*factorial(n-1)+1;
        to = i*factorial(n-1);
        ar(from:to,1) = repmat(el(i),to-from+1,1);
        new_elements = el;
        new_elements(new_elements==ar(from,1)) = [];
        ar(from:to,2:end) = dispositions(new_elements);
    end

end

