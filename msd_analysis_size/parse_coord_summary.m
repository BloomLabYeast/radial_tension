function coord_mat = parse_coord_summary(csv_filename)
%%parse_coord_summary parses the csv files generated by coord_summary.cpp
%%and places them into a single matrix.
%
%   inputs :
%       csv_filename : a character array specifying the CSV file to parse
%
%   output :
%       coord_mat : A matrix where each row is a time point printout of a
%       ChromoShake simulation. The columns are Time, mean x, mean y, and
%       mean z coordinate.
%
%   Note: Header is removed so only the time and coordiantes are in the
%   coord_mat variable

coord_mat = readmatrix(csv_filename);