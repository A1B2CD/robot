function out = animatesnake(X,Y,Z,snake)
    boxdim = [-3 3 -3 3 -3 3 ];
    center = true;
    projection = true;
    visible = 'off';
    [row, ~] = size(X);
    out(row) = struct('cdata',[],'colormap',[]);
 for i = 1:row
    [fig, ~] = snakeplot(X(i,:),Y(i,:),Z(i,:),boxdim,center,snake,projection,visible);
    out(i) = getframe(fig);
    close all hidden
    disp(num2str(i/row*100))
 end

end