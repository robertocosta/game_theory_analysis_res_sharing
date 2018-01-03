function [ ch, pay ] = pareto( ch )
%pareto(ch): one player per time
% version 1: on every iteration, each player chooses 1 channel
% version 2: on every iteration, each player chooses m channel
    global par;
    pay = zeros(par.pl,1);
    for i=1:par.m % from 1 to # of ch. for each player
        for j=1:par.pl
            % find the best free channel
            ch_ind = search_pref(par.playersPref(j,:),ch);
            if (ch_ind>0)
                pay_ind = find(par.playersPref(j,:)==ch(ch_ind,1));
                pay_ind = pay_ind(1);
                ch(ch_ind,2) = j; % set player j to channel ch_ind
                pay(j) = pay(j) + par.payoffs(j,pay_ind);
            else
                disp('Error: channel busy');
            end
        end
    end
    
end

