% Final script in force analysis pipeline for exporting data to CSV file

% load size mat-file
x = lp_force_summary('loopSize_2021.mat');
% load lp mat-file
y = lp_force_summary('lp_e2e.mat');
% merge into master structural array
s = cell2struct(...
    [struct2cell(x);struct2cell(y)],...
    [fieldnames(x);fieldnames(y)]...
    );
clear x y s_lp s_size;
% iterate over structural array to construct table
counter = 0;
fnames = fieldnames(s);
for f = 1:numel(fieldnames(s))-1
    counter = counter + numel(s.(fnames{f}).cen_total_force_pN);
end
persistenceLength = zeros(counter, 1);
loopSize = zeros(counter, 1);
radialForce = zeros(counter, 1);
axialForce = zeros(counter, 1);
totalForce = zeros(counter, 1);
idx = 1;
for f = 1:numel(fieldnames(s))
    if startsWith(fnames{f}, 'size')
        split_cell = strsplit(fnames{f}, '_');
        split_array = str2double(strsplit(split_cell{2}, 'kb'));
        my_loopSize = split_array(1);
        for i = 1:size(s.(fnames{f}).cen_axial_force_pN, 1)
            persistenceLength(idx) = 50;
            loopSize(idx) = my_loopSize;
            axialForce(idx) = s.(fnames{f}).cen_axial_force_pN(i,1);
            radialForce(idx) = s.(fnames{f}).cen_radial_force_pN(i,1);
            totalForce(idx) = s.(fnames{f}).cen_total_force_pN(i,1);

            idx = idx + 1;
        end
    elseif startsWith(fnames{f}, 'lp')
        split_cell = strsplit(fnames{f}, '_');
        split_cell = strsplit(split_cell{2}, 'nm');
        my_lp = str2double(split_cell{1});
        for i = 1:size(s.(fnames{f}).cen_axial_force_pN, 1)
            if my_lp == 50
                continue
            end
            persistenceLength(idx) = my_lp;
            loopSize(idx) = 10;
            axialForce(idx) = s.(fnames{f}).cen_axial_force_pN(i,1);
            radialForce(idx) = s.(fnames{f}).cen_radial_force_pN(i,1);
            totalForce(idx) = s.(fnames{f}).cen_total_force_pN(i,1);
            idx = idx + 1;
        end
    end
end
T = table(loopSize, persistenceLength, axialForce, radialForce, totalForce);
clearvars -except T
writetable(T, 'directional_force.csv');
