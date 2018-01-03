clear all; close all;
addpath('lib');
global par;

par.n_text_ar = {'2','4','6','6'};
par.m_text_ar = {'1','2','3','2'};

for ind = 1:length(par.n_text_ar)
    par.n_text = par.n_text_ar{ind};
    par.m_text = par.m_text_ar{ind};
    par.n = str2double(par.n_text); % number of channels
    par.m = str2double(par.m_text); % number of channels for each player
    f = plot3D;
    view(60,60);
    savePlot(f,'Paper/img/3d/','PoA',1);
    savePlot(f,'Paper/img/3d/','PoA',2);
    view(60,90);
    savePlot(f,'Paper/img/3d/','top_PoA',1);
    savePlot(f,'Paper/img/3d/','top_PoA',2);
    g = plot2D(1);
    savePlot(g,'Paper/img/','TDP',1);
    savePlot(g,'Paper/img/','TDP',2);
    g = plot2D(2);
    savePlot(g,'Paper/img/','PP',1);
    savePlot(g,'Paper/img/','PP',2);
end
clearvars ind f g;