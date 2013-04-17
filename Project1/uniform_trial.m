function [ term, new_route, new_weight ] = uniform_trial( route, next, w )
%Generate a uniform trial distribution for
%sequential monte-carlo SAW

s_next = size(next);
cur_w = s_next(1) + 1; %add one for termination
new_weight = w * cur_w;

k = randi(cur_w);
if k > s_next(1)
    term = 1;
    new_route = route;
else
    term = 0;
    new_route = [route; next( k, : )];
end


end

