function [ term, new_route, new_weight ] = few_stop_trial( route, next, w )
%Generate a uniform trial distribution for
%sequential monte-carlo SAW

s_next = size(next);

term = 0;
STOP_PCT = 2;
%2 percent stop probability
if randi(100) <= STOP_PCT
    term = 1;
    new_route = route;
    new_weight = w*100/STOP_PCT;
    return
end

steps = s_next(1); 
new_weight = w * (100/(100-STOP_PCT))*(steps);

k = randi(steps);
    new_route = [route; next( k, : )];

end

