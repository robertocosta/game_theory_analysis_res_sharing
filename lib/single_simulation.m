% Runs Pareto's Optimum and NE simulations
global par; % parameters
parameter_set; % setting the parameters
%% Pareto's optimum simulation
pareto_payoff_mean = zeros(par.pl,par.n_iterations_pareto);
for i=1:par.n_iterations_pareto
    par.plTy = round(rng_from_pdf(par.typePDF,par.pl)); % assigning types
    par.playersPref = par.pref(par.plTy,:);
    % channels var.: i-th row: [type, index of the player using it]
    if (round (par.n/par.k) == (par.n/par.k))
        channels = [repmat((1:par.k)',par.n/par.k,1),zeros(par.n,1)];
    else
        disp(...
        "Warning: some kinds of channel are more frequent than others");
        tmp = repmat((1:par.k)',floor(par.n/par.k),1);
        channels = [vertcat(tmp, (par.k-mod(par.n,par.k)+1:par.k)'),...
            zeros(par.n,1)];
        clearvars tmp;
    end
    % One player per time chooses the best free channel for him
    [pareto_ch, pareto_payoffs] = pareto(channels);
    % The total payoffs are saved
    pareto_payoff_mean(:,i) = pareto_payoffs;
end
% averaging the payoffs of all the simulations
pareto_payoffs = mean(pareto_payoff_mean,2);
% computing the social cost
social_cost_pareto = sum(pareto_payoffs);
clearvars i pareto_payoff_mean;

%% BNE
% number of possible actions by each player
par.nActions = nchoosek(par.n,par.m);
% actual possible actions
par.actions = sortrows(combnk(1:par.n,par.m));
% Computnig the payoffs from any couple of actions by the 2 players
caos_cel = caos_cell(channels);
% Computing all possible strategies (set of actions) for each player
% the following 2 lines give memory problems, so they have been substituted
% strategies = [perms(1:par.nActions);(1:par.nActions)'*ones(1,par.nActions)];
% strategies = sortrows(unique(strategies(:,1:par.types),'rows'));
strategies = permn(1:par.nActions,par.types);
par.strategies = strategies;
% computing the normal form matrix
normal_form_matrix = zeros(size(strategies,1),size(strategies,1),par.pl);
for i = 1:size(strategies,1)
    for j = 1:size(strategies,1)
        for k = 1:size(strategies,2)
            for l = 1:size(strategies,2)
                normal_form_matrix(i,j,1) = normal_form_matrix(i,j,1) + ...
                    par.typePDF(k)*par.typePDF(l)*...
                    caos_cel{k,l}(strategies(i,k),strategies(j,l),1);
                normal_form_matrix(i,j,2) = normal_form_matrix(i,j,2) + ...
                    par.typePDF(k)*par.typePDF(l)*...
                    caos_cel{k,l}(strategies(i,k),strategies(j,l),2);
            end
        end
    end
end
out_text = strcat("PP=",num2str(par.payoffsConst),...
    ";TDP=",num2str(par.plProbConst));

% best responses computation
br = zeros(size(normal_form_matrix));
% player 1 best responses
maxs = repmat(max(normal_form_matrix(:,:,1),[],1),[size(br(:,:,1),1),1]);
br(:,:,1)=(normal_form_matrix(:,:,1) == maxs );
% player 2 best responses
maxs = repmat(max(normal_form_matrix(:,:,2),[],2),[1,size(br(:,:,1),1)]);
br(:,:,2)=(normal_form_matrix(:,:,2) == maxs);
% best response for both players
br = br(:,:,1).*br(:,:,2);
[NEa, NEb] = find(br);
NE = horzcat(NEa,NEb);
par.NE = NE;
clearvars NEa NEb br maxs i j k l;

% finding minimum payoff from NE
min_payoff_NE = inf;
min_payoff_NE_ind = 0;
for i = 1:size(NE,1)
    % p = payoffs for the i-th NE
    p = [normal_form_matrix(NE(i,1),NE(i,2),1), ...
        normal_form_matrix(NE(i,1),NE(i,2),2)];
    if sum(p)<sum(min_payoff_NE)
        min_payoff_NE = p;
        min_payoff_NE_ind = i;
    end
end
social_cost_NE = sum(min_payoff_NE);
% computing the price of anarchy
PoA = social_cost_pareto / social_cost_NE;

out_text = vertcat(out_text,strcat("Min payoff BNE:",...
    mat2str(min_payoff_NE,4)),...
    strcat("BNE pl. 1 action: [",...
    mat2str(par.actions(strategies(NE(min_payoff_NE_ind,1),1),:),2),",",...
    mat2str(par.actions(strategies(NE(min_payoff_NE_ind,1),2),:),2),"]"),...
    strcat("BNE pl. 2 action: [",...
    mat2str(par.actions(strategies(NE(min_payoff_NE_ind,2),1),:),2),",",...
    mat2str(par.actions(strategies(NE(min_payoff_NE_ind,2),2),:),2),"]"),...
	strcat("PoA=",num2str(PoA,5)));
disp(out_text);
clearvars strategies NE i p;
