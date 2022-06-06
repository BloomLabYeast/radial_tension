function s = lp_force_summary(mat_filename)
%%Summary script for calculate the mean and sem of the inward force of
%%different centromere simulations
%% Load mat file
load(mat_filename, 's');
%% Loop through simulations
%Hardcoded variables
equib_timesteps_number = 2000;
timestep = 10^-5; %seconds
names = fieldnames(s);
for n = 1:numel(names)
    %calculate the actual number of timesteps after equilibration
    s.(names{n}).num_timesteps = (size(s.(names{n}).e2e,2)-equib_timesteps_number);
    %[s.(names{n}).equib_force_pN, s.(names{n}).early_force_pN, s.(names{n}).total_force_pN] = ...
    %    lp_inward_force(s.(names{n}).e2e, equib_timesteps_number, timestep);
    %% Force angle calc
    [s.(names{n}).xy_z_ratios, s.(names{n}).xy_dists, s.(names{n}).z_dists] = calc_xy_z_ratios(s.(names{n}).end_coords(:,:,equib_timesteps_number+1), s.(names{n}).end_coords(:,:,end));
    s.(names{n}).xy_z_angles = calc_xy_z_angle(s.(names{n}).end_coords(:,:,equib_timesteps_number+1), s.(names{n}).end_coords(:,:,end));
    [s.(names{n}).mean_angle, s.(names{n}).radial_dist_array, s.(names{n}).axial_dist_array, s.(names{n}).total_dist_array] = end_angles(s.(names{n}).end_coords);
    %% Force in xy vs z
    s.(names{n}).radial_force_pN = distance_force(s.(names{n}).radial_dist_array, timestep, s.(names{n}).num_timesteps);
    s.(names{n}).axial_force_pN = distance_force(s.(names{n}).axial_dist_array, timestep, s.(names{n}).num_timesteps);
    s.(names{n}).total_force_pN = distance_force(s.(names{n}).total_dist_array, timestep, s.(names{n}).num_timesteps);
    % used paired indexing to determine how to sum the supermassive bead
    % force in total_force_pN arrays
    p_idx = pair_end_coords(s.(names{n}).end_coords(:,:,1));
    for i = 1:size(p_idx, 1)
        s.(names{n}).cen_total_force_pN(i,1) = ...
            s.(names{n}).total_force_pN(p_idx(i,1)) ...
            + s.(names{n}).total_force_pN(p_idx(i,2));
        s.(names{n}).cen_radial_force_pN(i,1) = ...
            s.(names{n}).radial_force_pN(p_idx(i,1)) ...
            + s.(names{n}).radial_force_pN(p_idx(i,2));
        s.(names{n}).cen_axial_force_pN(i,1) = ...
            s.(names{n}).axial_force_pN(p_idx(i,1)) ...
            + s.(names{n}).axial_force_pN(p_idx(i,2));
    end
    %sum the forces of each endbead pair to generate force on single
    %centromere. Index is as follows 1-17, 2-18, 3-19, etc
    %index = [1:numel(s.(names{n}).equib_force_pN)/2;...
    %    (numel(s.(names{n}).equib_force_pN)/2 + 1):numel(s.(names{n}).equib_force_pN)];
    %s.(names{n}).cen_equib_force_pN(index(1,:)) = s.(names{n}).equib_force_pN(index(1,:)) + ...
    %    s.(names{n}).equib_force_pN(index(2,:));
    %s.(names{n}).cen_early_force_pN(index(1,:)) = s.(names{n}).early_force_pN(index(1,:)) + ...
    %    s.(names{n}).early_force_pN(index(2,:));
    %s.(names{n}).cen_total_force_pN(index(1,:)) = s.(names{n}).total_force_pN(index(1,:)) + ...
    %    s.(names{n}).total_force_pN(index(2,:));
    %s.(names{n}).mean_cen_equib = mean(s.(names{n}).cen_equib_force_pN);
    %s.(names{n}).sem_cen_equib = std(s.(names{n}).cen_equib_force_pN)/...
    %    sqrt(numel(s.(names{n}).cen_equib_force_pN));
end