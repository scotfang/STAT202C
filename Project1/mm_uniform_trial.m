function [ term, next_step, new_weight ] = mm_uniform_trial( cur_step, next, w )
%Generate a uniform trial distribution for
%sequential monte-carlo SAW

s_next = size(next);

term = 0;

steps = s_next(1); 
new_weight = w * steps;

k = randi(steps);
next_step = next(k, :);
end

