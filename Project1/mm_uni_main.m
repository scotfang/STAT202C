N = 10
m_start = 10^5;
m_end = 10^6;
m_points = 3
MM = 1
WORKERS = 2
th = @(route,next,w) mm_uniform_trial(route,next,w);
trial_str = 'mm_uniform'

m_step = round((m_end-m_start)/m_points);
M_TARGET = m_start:m_step:m_end;
%M_TARGET = [10^5]
K = zeros( length(M_TARGET), 1);

%function handle for uniform trial
MAX_GRID = [];
hist_bins = zeros((N+1)^2, 1);

ki = 1;
M = [];
for m_target = M_TARGET 
    disp(['starting it',num2str(ki),' m=', num2str(m_target), ' ...'])
    
    [k_dist, max_grid] = saw(N, m_target, th, MM, WORKERS);
    dist_size = size(k_dist);
    %k_dist
    %Actual m may differ from M_TARGET due to rounding
    %or rejections
    m = dist_size(1);
    
    sum_dist = sum(k_dist);
    
    %k_dist
    K(ki) = (1/m)*sum_dist(2);
    
    if sum(max_grid(:)) > sum(MAX_GRID(:))
        MAX_GRID = max_grid;
    end
    
    M(ki) = m;
    
    %have to weight the histogram    
    for i = 1:dist_size(1)
        hist_bins(k_dist(i,1)) = hist_bins(k_dist(i,1)) + k_dist(i,2);
    end
    ki = ki + 1;
    
end

M
if MM == 1
    M_TARGET
end

K
%max_len = max(K(:,3))
max_len = sum(MAX_GRID(:))
MAX_GRID


figure(1);
loglog(M,K,'s-')
%plot(log(M),log(K),'s-')
saveas(1, ['loglog_', trial_str,'.jpeg']);
figure(2);
bar(hist_bins)
saveas(2, ['hist_', trial_str,'.jpeg']);
