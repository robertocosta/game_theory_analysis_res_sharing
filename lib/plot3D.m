function f = plot3D()
% load data and display a 3D image of PoA wrt TDP and PP.
% outputs: f (figure)
    global par;
    out = '';
    load(strcat('mat/grid.n_',par.n_text,'.k_2.m_',par.m_text,'.mat'),...
        'out');
    x = zeros(size(out));
    y = zeros(size(out));
    z = zeros(size(out));

    for i=1:size(out,1)
        for j=1:size(out,2)
            x(i,j) = out{i,j}(1);
            y(i,j) = out{i,j}(2);
            z(i,j) = out{i,j}(3);
        end
    end

    x = x(:);
    y = y(:);
    z = z(:);
    [~,~,f] = createFit(x, y, z);
    min_z = min(z);
    min_z = min([min_z, 1]);
    max_z = max(z)*1.1;
    zlim([min_z,max_z]);
end

