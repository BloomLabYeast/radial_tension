function [xy_z_ratios, xy_dists, z_dists] = calc_xy_z_ratios(start_coords, final_coords)
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
%       xy_z_ratios = A vector of ratios of the XY-distance traveled
%       over the Z-distance traveled of each mass.
%
%       xy_dists = A vector of distances that each mass traveled in XY. XY
%       is the norm of the distance traveled in X and Y.
%
%       z_dists = A vector of distances that each mass traveled in the Z
%       dimension.

subs = start_coords - final_coords;
xy_dists = sqrt(subs(:,1).^2 + subs(:,2).^2);
z_dists = abs(subs(:,3));
xy_z_ratios = xy_dists./z_dists;
