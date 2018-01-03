% setting the parameters
global par;

par.rndGen = rng;
par.n_iterations_pareto = 20000;
par.pl = 2; % number of users (players)
par.k_text = '2'; % number of categories of the channels
par.k = 2;
par.pref = dispositions(1:par.k); % all possible preferences
%par.pref = unique(par.pref(:,1:par.m), 'rows');
par.types = size(par.pref,1); % number of user types
par.nIterations = 1;

par.typeProbOption = 2; % 1: uniform players distribution, 2: not uniform
pdf = []; % prob. of each type of player
switch (par.typeProbOption)
    case 1 % uniform
        pdf = 1/par.types * ones(par.types,1); 
    case 2 % first choice = type 1 is the most probable choice
        v = 100;
        k = round(par.types/par.k);
        for i=1:par.k
            pdf=[pdf;v/(par.plProbConst^(i-1))*ones(k,1)];
        end
        pdf = pdf / sum(pdf);
    otherwise
        pdf = 1/par.types * ones(par.types,1);
end
par.typePDF = pdf;


par.payoffMax = 10; % sum of the payoffs (constant)
payoffs = par.payoffMax * ones(1,par.k);
for i=2:par.k
    payoffs(i) = payoffs(i) * par.payoffsConst^(i-1);
end
payoffs = payoffs ./ sum(payoffs) .* par.payoffMax;
payoffs = fliplr(payoffs);
par.payoffs = zeros(length(payoffs),par.types);
% payoffs (from best to worst): one row per player type
par.payoffs = repmat(payoffs,par.types,1);



clearvars pdf i k v payoffs;