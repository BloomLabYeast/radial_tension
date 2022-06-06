function S = equib_msd_summary(dir_cell, label_cell, equib_timepoint)
%%equib_msd_summary calculate MSD for all csv files in the directories
%%specified within the dir_cell cell array.
%
%   inputs :
%       dir_cell : A cell array that contains the directorys to parse for
%       coordinate summary CSV files.
%
%       label_cell : A cell array that contains the labels that will
%       represent the directories in dir_cell cell array. Must conform to
%       naming rules for fieldnames of structure arrays.
%
%       equib_timepoint : A scalar variable specifying the time to begin
%       calculating the mean squared displacement. Note, starts at 1 and
%       must be a positive integer.
%
%   outputs :
%       S : A structure array containing the MSDs for all specified
%       directories.
%%NOTE%%
%The old ChromoShake summary did not incorporate equilibration. The new
%MATLAB calc_msd.m allows for removal of a given number of timepoints to
%allow for equilibration. New pipeline directly parses mean coords from the
%*_coord_summs folders

%%NOTE%%
%The parsing loop will NOT parse the csv_files in human readable order!!!

%% Iterate over directories
for n = 1:numel(dir_cell)
    csv_files = dir(fullfile(dir_cell{n}, '*.csv'));
    for f = 1:numel(csv_files)
        coord_mat = parse_coord_summary(...
            fullfile(csv_files(f).folder, csv_files(f).name));
        msd_mat = calc_equib_msd(...
           coord_mat, ...
            equib_timepoint...
            );
        S.(label_cell{n}).taus(:,f) = msd_mat(:,1);
        S.(label_cell{n}).msds(:,f) = msd_mat(:,2);
    end
end

%% Iterate over S and plot data
fnames = fieldnames(S);
sem = @(x) std(x, [], 2)/sqrt(size(x, 2));
for f = 1:numel(fnames)
    if f == 1
        figure;
        hold on;
    end
    msds_mat_nm_sq = S.(fnames{f}).msds * 1E18;
    mean_array = mean(msds_mat_nm_sq, 2);
    sem_array = sem(msds_mat_nm_sq);
    errorbar(1E-5:1E-3:15*1E-3, mean_array(1:100:1500), sem_array(1:100:1500));
end
hold off;
legend(fnames, 'Location', 'northwest');

