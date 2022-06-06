function xy_z_angles = calc_xy_z_angle(start_coords, final_coords)
%%CALC_XY_Z_ANGLE Finds the angles between the XY-distance and the
%%Z-distance for each mass
%
%   Inputs:
%
%       start_coords = 2D matrix where each row is a mass and the columns
%       represend the X, Y, and Z coordinates, respectively, of the
%       starting postions of the masses of interest.
%
%       final_coords = 2D matrix where each row is a mass and the columns
%       represend the X, Y, and Z coordinates, respectively, of the
%       final postions of the masses of interest.
%
%   Output:
%
%       xy_z_angles = A vector of angles, in degrees, of the XY-distance
%       traveled over the Z-distance traveled of each mass. The larger the
%       angle value the greater the ratio of XY-distance to Z-distance.

subs = start_coords - final_coords;
xy_dists = sqrt(subs(:,1).^2 + subs(:,2).^2);
z_dists = abs(subs(:,3));
xy_z_ratios = xy_dists./z_dists;
xy_z_angles = rad2deg(atan(xy_z_ratios));
