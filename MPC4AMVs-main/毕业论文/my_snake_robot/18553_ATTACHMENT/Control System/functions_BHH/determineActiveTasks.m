function activeTasks = determineActiveTasks(tasks)

nTasks = numel(tasks);
activeTasks = zeros(1,nTasks);
for i = 1:nTasks
    T = tasks{i};
    if T.Active == 1
        activeTasks(i) = 1;
    end
end

end