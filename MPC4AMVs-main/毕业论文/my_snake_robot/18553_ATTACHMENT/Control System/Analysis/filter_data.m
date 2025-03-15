function filtered_data = filter_data(data, tollerance)
%Removes large jumps in the data set that often occur because of some
%measurement error.
n = length(data);

largestChange = 0;
diff = zeros(n-1,1);
derivative = zeros(n-1,1);
for i = 1:n-1
    diff(i) = abs(data(i) - data(i+1));
    derivative(i) = data(i+1) - data(i);
    if diff(i) > largestChange
        largestChange = diff(i);
    end
end
der_max = max(derivative);
der_min = min(derivative);
avrChange = median(diff);

n_der = length(derivative);
window = 1;
n_cur = n_der - (2*window);
curvature = zeros(n_cur, 1);
for i = 1+window:n_der-window
    curvature(i) = derivative(i+window) - derivative(i-window);
end
cur_max = max(curvature);
cur_min = min(curvature);
cur_avr = sum(abs(curvature))/(n_der-window);

cur_lim = max([cur_max; abs(cur_min)]);

for i = 1:n_cur
    if abs(curvature(i)) > tollerance*cur_lim
        data(i+1) = data(i);
    end
end

% for i = 1:n-2
%     d = derivative(i) - derivative(i+1);
%     R = abs(d);
%     if R > tollerance*largestChange
%         data(i+1) = data(i);
%     end
% end

filtered_data = data;

end