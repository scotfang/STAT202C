%matlabpool
N = 4
m_start = 10^4;
m_end = 10^5;
m_points = 3;
m_step = round((m_end-m_start)/m_points);

th = @(route,next,w) se_trial(route,next,w);
trial_str = 'se'

M = m_start:m_step:m_end;
K = zeros( length(M), 1);

%function handle for uniform trial
MAX_GRID = [];
hist_bins = zeros((N+1)^2, 1);

ki = 1;
for m = M 
    disp(['starting it',num2str(ki),' m=', num2str(m), ' ...'])
    
    [k_dist, max_grid] = saw(N, m, th);
    sum_dist = sum(k_dist);
    
    %k_dist
    K(ki) = (1/m)*sum_dist(2);
    
    if sum(max_grid(:)) > sum(MAX_GRID(:))
        MAX_GRID = max_grid;
    end
   
    %have to weight the histogram
    dist_size = size(k_dist);
    for i = 1:dist_size(1)
        hist_bins(k_dist(i,1)) = hist_bins(k_dist(i,1)) + k_dist(i,2);
    end
    ki = ki + 1;
end
%matlabpool close
M
K = K'
%max_len = max(K(:,3))
max_len = sum(MAX_GRID(:))
MAX_GRID


figure(1);
%loglog(M,K,'s-')
plot(log(M),log(K),'s-')
saveas(1, ['loglog_', trial_str,'.jpeg']);
figure(2);
bar(hist_bins)
saveas(2, ['hist_', trial_str,'.jpeg']);
