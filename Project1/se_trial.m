function [ term, new_route, new_weight ] = se_trial( route, next, w )
%Generate a trial distribution favoring SE paths for
%sequential monte-carlo SAW

s_next = size(next);

switch ([x,y]) 
    case 

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

