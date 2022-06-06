function end_coord_3d_time(end_coords)
%%END_COORD_3D_TIME parses the three dimensional matrix, end_coords, to
%%generate a 3D scatter plot of each end bead's postion over time

figure;
for n = 1:2:size(end_coords, 1)
    scatter3(end_coords(n,1,:), end_coords(n,2,:), end_coords(n,3,:));
    if n ==1
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        hold on;
    end
end
%set axes
minx = min(min(end_coords(:,1,:)));
miny = min(min(end_coords(:,2,:)));
minz = min(min(end_coords(:,3,:)));
totmin = min([minx, miny, minz]);
maxx = max(max(end_coords(:,1,:)));
maxy = max(max(end_coords(:,2,:)));
maxz = max(max(end_coords(:,3,:)));
totmax = max([maxx, maxy, maxz]);
xlim([totmin totmax]);
ylim([totmin totmax]);
zlim([totmin totmax]);