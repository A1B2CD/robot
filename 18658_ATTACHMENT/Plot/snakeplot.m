function [fig, h] = snakeplot(X_t,Y_t,Z_t,boxdim,center,snake,projection,visible)

ax = boxdim;

if center
    X_t_avg = sum(X_t)/(snake.n+1);
    Y_t_avg = sum(Y_t)/(snake.n+1);
    Z_t_avg = sum(Z_t)/(snake.n+1);
    ax(1:2) = ax(1:2) + X_t_avg;
    ax(3:4) = ax(3:4) + Y_t_avg;
    ax(5:6) = ax(5:6) + Z_t_avg;   
end

fig = figure('visible',visible);
if projection
    hold on
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'k','LineWidth',3,'linestyle','-')
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'k','marker','.','markersize',3)
    
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'k','LineWidth',3,'linestyle','-')
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'k','marker','.','markersize',3)
    
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'k','LineWidth',3,'linestyle','-')
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'k','marker','.','markersize',3)
end

h=plot3t(X_t,Y_t,Z_t,snake.r,'gr',20);
% Shade the line
set(h, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);
% Set figure rotation
view(3); axis(ax);
grid on
% Set the material to shiny and enable light
material shiny; light('position',[0 0 1 ]);
hold off

end