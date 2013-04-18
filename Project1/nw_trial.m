function [ term, next_step, new_weight ] = nw_trial( cur_step, next, w )
%Generate a trial distribution favoring NW paths for
%sequential monte-carlo SAW

STOP_PCT = 5;

s_next = size(next);
P = zeros(s_next(1)+1,1)';
for i = 1:s_next(1)
    if sum(next(i,:) - cur_step) < 0
        P(i) = 1.5;
    else
        P(i) = 1;
    end
end

%probability of stopping
P(end) = (STOP_PCT*sum(P)) / (100-STOP_PCT) ;
%disp(P/sum(P))
%disp(P)
k = gendist(P, 1, 1);

if k > s_next(1)
    term = 1;
    next_step = [0,0];
else
    term = 0;
    next_step = next( k, : );
end

new_weight = w * (sum(P)/P(k));
end

