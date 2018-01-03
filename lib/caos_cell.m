function  payoff_cell = caos_cell(ch)
global par;
    if (par.pl~=2)
        return;
    end
    payoff_cell = cell(par.types);
    payoffs = par.payoffs(1,:);
    for a=1:par.types
        for b=1:par.types
            % types of the players have been assigned (a,b)
            % output payoff matrix:
            payoff = zeros(par.nActions,par.nActions,2);
            % preferences of the two players
            pref_A = par.pref(a,:);
            pref_B = par.pref(b,:);
            % payoff computation
            for i = 1:par.nActions
                for j=1:par.nActions
                    % for each couple of strategies
                    for k=1:par.m
                        % for each action in the strategy of player 1
                        channel_type = ch(par.actions(i,k),1);
                        busy_channel = ... % player 2 wants my ch.
                            find(par.actions(i,k) == par.actions(j,:),1);
                        if (isempty(busy_channel)) % if no collision
                            payoff(i,j,1) = payoff(i,j,1) + ...
                                payoffs(find(channel_type==pref_A,1));
                        end
                        % otherwise the payoff is 0, and nothing is done
                    end
                    for k=1:par.m
                        % for each action in the strategy of player 2
                        channel_type = ch(par.actions(j,k),1);
                        busy_channel = ... % player 1 wants my ch.
                            find(par.actions(j,k) == par.actions(i,:),1);
                        if (isempty(busy_channel)) % if no collision
                            payoff(i,j,2) = payoff(i,j,2) + ...
                                payoffs(find(channel_type==pref_B,1));
                        end
                    end
                end
            end
            payoff_cell{a,b} = payoff;
        end
    end
end

