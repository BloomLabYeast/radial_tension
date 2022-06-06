function end_to_end_bass(file)
%%END_TO_END Calculates the end to end distance of the sister centromeres
%%in the model.

%% Generate the end bead index from header of out file
%Use GREP from system to quickly parse file
disp('Grepping now...')
[~,all_masses] = system(sprintf('grep "mass " %s', file));
mass_cell = strsplit(strip(all_masses), '\n');
clear all_masses;
split_mass_cell = cellfun(@(c) strsplit(strip(c)),mass_cell,'UniformOutput', false);
size_idx = cellfun(@(c) size(c,2) == 7, split_mass_cell);
split_mass_cell = split_mass_cell(size_idx);
end_log_rev = cellfun(@(c) strcmp('3.38889e-015',c{3}), split_mass_cell);
end_log = fliplr(end_log_rev);
end_idx = find(end_log);

%% Pre-allocate the matrix size
[~, time_str] = system(sprintf('grep "Time " %s | wc -l', file));
time_num = str2double(time_str);
coord_num = numel(end_idx);
end_coords = zeros([coord_num, 3, time_num]);

%% Open file and loop through contents to pull out end coordinates over time
disp('Parsing file now...');
fid = fopen(file);
time_tog = false;
time_counter = 0;
coord_counter = 1;
line_counter = 0;
while ~feof(fid)
    line = fgetl(fid);
    line_counter = line_counter + 1;
    if time_tog && ismember(line_counter, end_idx)
        ismember(line_counter, end_idx);
        line_cell = strsplit(strtrim(line));
        line_array = cellfun(@str2double,line_cell);
        end_coords(coord_counter,:, time_counter) = line_array;
        coord_counter = coord_counter + 1;
    end
    if contains(line, 'Time ')
        time_tog = true;
        time_counter = time_counter + 1;
        coord_counter = 1;
        line_counter = 0;
        progress = time_counter/time_num*100;
        fprintf('%d%%\n', progress);
    end
end
fclose(fid);
name_cell = strsplit(file, '.');
save(sprintf('%s_e2e.mat', name_cell{1}),'end_coords');
%% Calcuate end to end distance over time of each chromatid
%pre-allocate
e2e = zeros([32, size(end_coords,3)]);
for n = 1:size(end_coords,3)
    e2e(:, n) = sqrt(sum((end_coords(1:2:end,:,n) - end_coords(2:2:end,:,n)).^2,2));
end
%% save data
save(sprintf('%s_e2e.mat', name_cell{1}),'e2e', 'end_coords');

