close all;
clear all;
addpath('lib');
run_simulations;
%{
produce 
    mat/grid.n_*.k_2.m_*.mat
    mat/NFMs.n_*.k_2.m_*.mat
%}
run_plots;
%{
produce
    Paper/img/PP**.png
    Paper/img/TDP**.png
    Paper/img/3d/PoA**.png
    Paper/img/PP**.eps
    Paper/img/TDP**.eps
    Paper/img/3d/PoA**.eps
%}

