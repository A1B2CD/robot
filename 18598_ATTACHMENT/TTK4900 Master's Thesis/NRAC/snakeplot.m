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
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'Color',[.4 .4 .4],'LineWidth',3,'linestyle','-')
    plot3(X_t,Y_t,ax(5)*ones(1,snake.n+1),'Color',[.4 .4 .4],'marker','.','markersize',3)
    
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'Color',[.4 .4 .4],'LineWidth',3,'linestyle','-')
    plot3(X_t,ax(4)*ones(1,snake.n+1),Z_t,'Color',[.4 .4 .4],'marker','.','markersize',3)
    
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'Color',[.4 .4 .4],'LineWidth',3,'linestyle','-')
    plot3(ax(2)*ones(1,snake.n+1),Y_t,Z_t,'Color',[.4 .4 .4],'marker','.','markersize',3)
end

h=plot3t(X_t,Y_t,Z_t,snake.r,'s',20);

xlabel('x', 'interpreter','latex','fontsize',18)
ylabel('y','interpreter','latex','fontsize',18)
zlabel('z','interpreter','latex','fontsize',18)
text(2,-0.1,3,'Head','Color','k','FontSize',16)
text(0.1,2,1.3,'Tail','Color','k','FontSize',16)

% Shade the line

set(h, 'FaceLighting','phong','SpecularColorReflectance', 0, 'SpecularExponent', 50, 'DiffuseStrength', 1);

% Set figure rotation
view(3); axis(ax);
grid on
% Set the material to shiny and enable light

material shiny; light('position',[0 0 1 ]);

hold off

end