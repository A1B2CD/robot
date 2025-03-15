function [deviation, dev_tot] = calculate_path_deviation(waypoints, pb_I, T, index)

pb_I = pb_I(index:end, :);
n = length(pb_I);
deviation = zeros(n, 3);
activeWP = 2;
transitionWP = 1;

criticalZone = zeros(n,5);
dTest = zeros(n,2);

for i = 1:n
    %Active waypoint switching process
    wpa = waypoints(1:3,activeWP)';
    R_wp = waypoints(4,activeWP);
    wp_diff = pb_I(i,:) - wpa;
    wp_dist = norm(wp_diff);
    if wp_dist <= R_wp
        transitionWP = activeWP;
        activeWP = activeWP + 1;
    end
    
    %Check if in transition between waypoints or not
    wp_transition = waypoints(1:3, transitionWP)';
    R_transition = waypoints(4, transitionWP)*1.2;
    transition_diff = pb_I(i,:) - wp_transition;
    transition_dist = norm(transition_diff);
    
    %In transition, find shortest distance to both lines
    if transition_dist <= R_transition
        wp1 = waypoints(1:3, transitionWP - 1)';
        wp2 = waypoints(1:3, transitionWP)';
        wp3 = waypoints(1:3, transitionWP + 1)';
        
        l1 = wp2 - wp1;
        n1 = l1/norm(l1);
        d1 = (wp1 - pb_I(i,:)) - ((wp1 - pb_I(i,:))*n1')*n1;
        
        l2 = wp3 - wp2;
        n2 = l2/norm(l2);
        d2 = (wp2 - pb_I(i,:)) - ((wp2 - pb_I(i,:))*n2')*n2;
        
        %Calculate point on path
        pop1 = pb_I(i,:) + d1;
        pop2 = pb_I(i,:) + d2;
        
        %Check if it is between two waypoints
        v1 = pop1 - wp1;
        v2 = pop2 - wp2;
        
        c1 = v1(1)/l1(1); %c must be in range [0 1] for the point to be between two WP
        c2 = v2(1)/l2(1);
        
        path1 = 1;
        path2 = 1;
        if c1 > 1 || c1 < 0
            path1 = 0;
        end
        if c2 > 1 || c2 < 0
            path2 = 0;
        end
        
        criticalZone(i,1) = path1;
        criticalZone(i,2) = path2;
        
        if path1 == 0 && path2 == 0
            deviation(i,:) = transition_diff;
        elseif path1 == 0
            deviation(i,:) = d2;
        elseif path2 == 0
            deviation(i,:) = d1;
        else
            deviation(i,:) = d1;
            if norm(d2) < norm(d1)
                deviation(i,:) = d2;
            end
        end
        dTest(i,1) = norm(d1);
        dTest(i,2) = norm(d2);
        criticalZone(i,3) = norm(d1);
        criticalZone(i,4) = norm(d2);
        criticalZone(i,5) = norm(deviation(i,:));
    else
        %Calculate distance to active path
        wp1 = waypoints(1:3,activeWP - 1)';
        wp2 = waypoints(1:3,activeWP)';
        l = wp2 - wp1;
        n1 = l/norm(l);
        %Find shortest distance from base module to desired path
        deviation(i,:) = (wp1 - pb_I(i,:)) - ((wp1 - pb_I(i,:))*n1')*n1; %Perpendicular vector from base to path
        criticalZone(i,5) = norm(deviation(i,:));
    end
end

%Calculate total deviation distance
dist = zeros(n,1);
for j = 1:n
    dist(j) = norm(deviation(j,:));
end
dev_tot = sum(dist)*T;

end