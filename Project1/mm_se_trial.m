function [ term, next_step, new_weight ] = nw_trial( cur_step, next, w )
%Generate a trial distribution favoring NW paths for
%sequential monte-carlo SAW

s_next = size(next);
P = zeros(s_next(1),1)';

for i = 1:s_next(1)
    if sum(next(i,:) - cur_step) > 0
        P(i) = 1.5;
    else
        P(i) = 1;
    end
end

k = gendist(P, 1, 1);

term = 0;
next_step = next( k, : );
new_weight = w * (sum(P)/P(k));
end
