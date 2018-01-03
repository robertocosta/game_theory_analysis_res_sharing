function savePlot( f,path, name, format )
% savePlot( figure, path, name, format [1:eps, 2:png, 3:pdf] )
global par;
    width = 580;
    height = 420;
    set(f, 'Position', [0 60 width height]);
    f.PaperPositionMode = 'auto';
    if (~exist(path,'dir')), mkdir(path); end
    switch format
        case 1
            print(f,strcat(path,name,par.n_text,par.m_text),'-depsc','-r0');
        case 2
            print(f,strcat(path,name,par.n_text,par.m_text),'-dpng','-r0');
        case 3
            print(f,strcat(path,name,par.n_text,par.m_text),'-dpdf','-r0');
        otherwise
            print(f,strcat(path,name,par.n_text,par.m_text),'-depsc','-r0');
    end
end

