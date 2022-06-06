function [angle, radial_dist, axial_dist, total_dist] = end_angles(end_coords)
%%END_ANGLES parses the three dimensional matrix, end_coords, to determine
%%the mean angles of motion of each end bead. The motion is described as
%%the radial motion (hypotenus of x and y in centromere simulaton) and the
%%axial motion (z in the centromere simulation). The radial motion is set
%%to Y and the axial motion is set to X, such that the larger the angle,
%%the more radial the motion. The angle can only be between 0 and 90
%%degrees.

%% Pre-allocate Distance Vectors
radial_dist = zeros([size(end_coords,1),1]);
axial_dist = zeros([size(end_coords,1),1]);
total_dist = zeros([size(end_coords,1),1]);
%% Loop through each end bead
for n = 1:size(end_coords, 1)
    deltax = end_coords(n,1,1) - end_coords(n,1,end);
    deltay = end_coords(n,2,1) - end_coords(n,2,end);
    deltaz = end_coords(n,3,1) - end_coords(n,3,end);
    total_dist(n) = sqrt(deltax^2 + deltay^2 + deltaz^2);
    radial_dist(n) = sqrt(deltax^2 + deltay^2);
    axial_dist(n) = abs(end_coords(n,3,1) - end_coords(n,3,end));
end

angle = rad2deg(atan2(mean(radial_dist), mean(axial_dist)));
