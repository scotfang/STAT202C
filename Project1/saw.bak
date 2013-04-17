function [k_dist, max_grid] = saw(N, m, trial)
%SAW self-avoiding walk estimation with square
%grid of size N
%trial - function with parameters
    %route
    %next - matrix of next spaces to take
    %w - current weight of path
    %returns [terminate, new_route, new_weight]

k_dist = zeros(m, 2); %[length, w]
%k_dist = zeros(m, 3);
max_grid = [];
max_len = 0;
for i=1:m
    [grid, route,w] = gen_route(N, trial);
    r_dim = size(route);
    %k_dist(i,:) = [r_dim(1), w, sum(grid(:))];
    k_dist(i,:) = [r_dim(1), w];
    grid_len = sum(grid(:));
    if grid_len > max_len
       max_grid = grid;
       max_len = grid_len;
    end
        
    %grid
end
end

function [grid, route, w] = gen_route(N, trial)
%generate a SAW with route 'route' and weight 'w'
%under trial distribution 'trial'


dim = N+1;
grid = zeros(dim);
grid(1,1) = 1;
route = [1,1];
w = 1;
dirs = [ 0,1; 0,-1; 1,0; -1,0 ];
term = 0;

while term == 0
    %directions
    next = zeros(4,2) - 1;  %next spots
    
    for i = 1:4
        n = route(end,:) + dirs(i,:);
        if valid(n, grid)
            next(i,:) = n;
        end 
    end
    
    next = next(next>=0);
  
    if isempty(next)
       term = 1;
    else   
       next = reshape(next, length(next)/2, 2);
       [term, route, w] = trial(route, next, w);
    end
    x = route(end,1);
    y = route(end, 2);
    grid(x,y) = 1;
end
end

function [r] = valid(t, grid)
%check if t is within grid boundaries
x = t(1);
y = t(2);
if x > length(grid) || x < 1
    r = 0;
    return;
end
if y > length(grid) || y < 1
    r = 0;
    return;
end
if grid(x,y) == 0
    r = 1;
else
    r = 0;
end
end