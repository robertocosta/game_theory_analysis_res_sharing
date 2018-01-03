function f = plot2D(type)
%PLOT2D (type): type = 1 : TDP in x, type = 2: PP in x
% outputs: f (figure)
    global par;
    out = '';
    load(strcat('mat/grid.n_',par.n_text,'.k_2.m_',par.m_text,'.mat'),...
        'out','params');
    x = zeros(size(out));
    y = zeros(size(out));
    z = zeros(size(out));
    rows = [1,3,5,9,16];
    for i=1:size(out,1)
        for j=1:size(out,2)
            x(i,j) = out{i,j}(1);
            y(i,j) = out{i,j}(2);
            z(i,j) = out{i,j}(3);
        end
    end
    f = figure;
    z_max = 0;
    l = cell(length(rows),1);
    if (type == 1)
        hold on;
        ind=0;
        for i=rows
            ind = ind + 1;
            plot(x(i,:),z(i,:));
            z_max = max([z_max, max(z(i,:))]);
            l{ind} = strcat("PP=",num2str(y(i,1),4));
        end
        legend(l);
        hold off;
        xlabel("TDP: P[Pl.Type = 1] / P[Pl.Type = 2]");
        ylabel("Price of Anarchy");
        title(strcat("Price of Anarchy vs TDP, n=",...
                num2str(par.n),", m=",num2str(par.m)));
    else
        hold on;
        ind=0;
        for i=rows
            ind = ind + 1;
            plot(y(:,i),z(:,i));
            z_max = max([z_max, max(z(:,i))]);
            l{ind} = (strcat("TDP=",num2str(x(1,i),4)));
        end
        legend(l);
        hold off;
        xlabel("PP: Payoff_{best} / Payoff_{worst}");
        ylabel("Price of Anarchy");
        title(strcat("Price of Anarchy vs PP, n=",...
            num2str(par.n),", m=",num2str(par.m)));
    end
    grid on;
    xlim([min(x(:)), max(x(:))]);
    ylim([1,z_max*1.1]);
    legend('location','northwest')
end

