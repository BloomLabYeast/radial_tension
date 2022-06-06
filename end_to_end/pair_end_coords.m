function paired_array = pair_end_coords(first_coords)

distance_square_mat = zeros(64);
for i = 1:size(first_coords, 1)
    for j = 1:size(first_coords, 1)
        if i == j
            distance_square_mat(i,j) = nan;
        else
            distance_square_mat(i,j) = norm(...
                first_coords(i,:) - first_coords(j,:)...
                );
        end
    end
end
[~, arg_min_array] = min(distance_square_mat);
total_paired_array = [1:size(first_coords, 1);arg_min_array]';
paired_array = total_paired_array(1:size(total_paired_array, 1)/2, :);