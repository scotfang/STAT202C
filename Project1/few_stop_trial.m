function [ term, next_step, new_weight ] = few_stop_trial( cur_step, next, w )
%Generate a uniform trial distribution for
%sequential monte-carlo SAW

s_next = size(next);

STOP_PCT = 8;
%2 percent stop probability
if randi(100) <= STOP_PCT
    term = 1;
    next_step = [0,0];
    new_weight = w*(100/STOP_PCT);
    return
end
term = 0;

steps = s_next(1); 
new_weight = w * (100/(100-STOP_PCT))*(steps);

k = randi(steps);
next_step = next(k, :);
end

