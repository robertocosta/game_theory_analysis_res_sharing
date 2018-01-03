global par;

par.TDPs = [1:0.25:2.25,3,3.75,4,4.25,5:8,8.75,9,9.25,10:11];
par.PPs =  [1:0.25:2.25,3,3.75,4,4.25,5:8,8.75,9,9.25,10:11];
par.n_text_ar = {'2','4','6','6'};
par.m_text_ar = {'1','2','3','2'};

for ind = 1:length(par.n_text_ar)
    par.n_text = par.n_text_ar{ind};
    par.m_text = par.m_text_ar{ind};
    par.n = str2double(par.n_text); % number of channels
    par.m = str2double(par.m_text); % number of channels for each player
    
    % saved variables
    out = cell(length(par.PPs),length(par.TDPs));
    params = cell(length(par.PPs),length(par.TDPs));
    NFMs = cell(length(par.PPs),length(par.TDPs));
    
    % starting the simulations
    tic;
    pc_ind = 0;
    for pc = par.PPs
        pc_ind = pc_ind + 1;
        % current PP assignement
        par.payoffsConst = pc;
        ppc_ind = 0;
        for ppc = par.TDPs
            ppc_ind = ppc_ind + 1;
            % current TDP assignement
            par.plProbConst = ppc;
            
            % running the simulation
            single_simulation;
            
            % saving data
            struc.out_text = out_text;
            struc.payoffs = caos_cel;
            struc.NEs = par.NE;
            struc.ch = channels(:,1);
            struc.worstNE = par.NE(min_payoff_NE_ind,:);
            struc.payoffWorstNE = min_payoff_NE;
            struc.pareto_ch = pareto_ch;
            struc.pareto_payoffs = pareto_payoffs;
            struc.SCPareto = social_cost_pareto;
            struc.SCNE = social_cost_NE;
            struc.PP = par.payoffsConst;
            struc.TDP = par.plProbConst;
            struc.par = par;
            params{pc_ind,ppc_ind} = struc;
            out{pc_ind,ppc_ind} = [par.plProbConst, par.payoffsConst, PoA];
            NFMs{pc_ind,ppc_ind} = normal_form_matrix;
            clearvars min_payoff_NE_ind min_payoff_NE out_text ...
                social_cost_pareto social_cost_NE normal_form_matrix ...
                pareto_ch pareto_payoffs caos_cel channels PoA struc;
        end
        disp(strcat(int2str(pc_ind)," done out of ",...
            int2str(length(par.PPs))));
        toc;
    end

    clearvars pc ppc pc_ind ppc_ind

    save(strcat('mat/grid.',...
        'n_',par.n_text,'.k_',num2str(par.k),'.m_',par.m_text,'.mat'),...
        'out', 'params');
    save(strcat('mat/NFMs.',...
        'n_',par.n_text,'.k_',num2str(par.k),'.m_',par.m_text,'.mat'),...
        'NFMs');
    
end
clearvars ind;

