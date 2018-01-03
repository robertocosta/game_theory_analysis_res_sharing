function tab = avg_table( cel, pdf )
%AVG_TABLE Summary of this function goes here
%   Detailed explanation goes here
    n = size(cel{1,1},1);
    tab = zeros(n,n,2);
    for i=1:size(cel,1)
        for j=1:size(cel,2)
            tmp = cel{i,j};
            tab(:,:,1) = tab(:,:,1) + pdf(i)*tmp(:,:,1);
            tab(:,:,2) = tab(:,:,2) + pdf(j)*tmp(:,:,2);
        end
    end

end

