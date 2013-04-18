function [K_DIST, MAX_GRID] = saw(N, m, trial)
%SAW self-avoiding walk estimation with square
%grid of size N
%trial - function with parameters
    %route
    %next - matrix of next spaces to take
    %w - current weight of path
    %returns [terminate, new_route, new_weight]

%k_dist = zeros(m, 3);

WORKERS = 2;
sub_m = round(m/WORKERS);

spmd (WORKERS)
    k_dist = zeros(sub_m, 2); %[length, w]
    max_grid = [];
    max_len = 0;
    for i=1:sub_m
        if mod(i, 10^4) == 0
            disp(['lab', num2str(labindex), ' sample ', num2str(i),'/',num2str(sub_m)]);
        end
        [grid, route_len, w] = gen_route(N, trial);
        assert(route_len == round(route_len))
        %route_len
        %w
        k_dist(i,:) = [route_len, w];
        %assert(route_len == sum(grid(:)));
        if route_len > max_len
           max_grid = grid;
           max_len = route_len;
        end
        %grid
    end
    %k_dist
end

K_DIST = zeros(sub_m*WORKERS, 2);
MAX_LEN = 0;
MAX_GRID = [];
for w = 1:WORKERS
    r_start = (w-1)*sub_m + 1;
    r_end = r_start + sub_m - 1;
    K_DIST(r_start:r_end,:) = k_dist{w};
  
    if max_len{w} > MAX_LEN
       MAX_GRID = max_grid{w}; 
    end
end

%K_DIST
%for i = 1:sub_m*WORKERS
    %assert(round(K_DIST(i,1))==K_DIST(i,1)) 
%end

end

function [grid, route_len, w] = gen_route(N, trial)
%generate a SAW with route 'route' and weight 'w'
%under trial distribution 'trial'


dim = N+1;
grid = zeros(dim);
grid(1,1) = 1;
%route = [1,1];
route = zeros( (N+1)^2, 2 );
route(1,:) = [1,1];
w = 1;
dirs = [ 0,1; 0,-1; 1,0; -1,0 ];
term = 0;

ri = 1;
while term == 0
    %directions
    next = zeros(4,2) - 1;  %next spots
    
    for i = 1:4
        %n = route(end,:) + dirs(i,:);
        n = route(ri,:) + dirs(i,:);

        if valid(n, grid)
            next(i,:) = n;
        end
        
    end
    
    next = next(next>=0);
  
    if isempty(next)
       term = 1;
    else   
       next = reshape(next, length(next)/2, 2);
       [term, next_step, w] = trial(route(ri,:), next, w);
    end
    
    %x = route(end,1);
    %y = route(end, 2);
    
    if term == 0
        x = next_step(1);
        y = next_step(2);
        ri = ri + 1;
        grid(x,y) = 1;
        route(ri,:) = next_step;
    end
    
end
route_len = ri;
%assert(route_len == sum(grid(:)));
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
