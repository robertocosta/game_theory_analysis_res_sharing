function s = print_nfm(m)
%PRINT_NFM Summary of this function goes here
%   Detailed explanation goes here
s = cell(size(m,1),1);
%m = m.*4;
for i=1:size(m,1)
    row = "";
    for j=1:size(m,2)
        cel = strcat("(",num2str(m(i,j,1),2),",",num2str(m(i,j,2),2),"),");
        row = strcat(row,cel);
    end
    s{i} = row;
end
%s = s(2:end);

