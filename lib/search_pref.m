function ind = search_pref( pref, ch )
%SEARCH_PREF search in matrix ch the best free option
    found = false;
    p = 1;
    while (~found)
        ind = find(ch(:,1)==pref(p));
        pl = ch(ind,2);
        where = find(pl==0);
        if (~isempty(where))
            where = where(1);
            break;
        end
        p = p+1;
    end
    if (~isempty(where))
        ind = ind(where);
    else
        ind = -1;
    end
end

