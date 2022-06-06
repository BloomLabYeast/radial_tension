% need to run scripts to compile all data into Python-readable form
lp_root = '/Users/lawrimor/University of North Carolina at Chapel Hill/Biology Bloom Lab - Documents/Radial Tension/Figures_5_6_chromoShake/3001_timepoint_outfiles/lp';
size_root = '/Users/lawrimor/University of North Carolina at Chapel Hill/Biology Bloom Lab - Documents/Radial Tension/Figures_5_6_chromoShake/3001_timepoint_outfiles/size';

lp_names = {...
    '5nm_trim.out', ...
    '50nm_trim.out', ...
    '200nm_trim.out', ...
    '500nm_trim.out' ...
    };

size_names = {...
    'WTspindle_0_5.out', ...
    'WTspindle_1_5.out', ...
    'WT_spindle_loops2.out', ...
    'WTspindle_2_25_coh220.out' ...
    };
cd(lp_root);
parfor n = 1:numel(lp_names)
    end_to_end_bass(lp_names{n});
end
cd(size_root);
parfor n = 1:numel(size_names)
    end_to_end_bass(size_names{n});
end

%% Run inward force calculation and build structural array
for n = 1:numel(lp_names)
    name_cell = strsplit(lp_names{n}, '.');
    basename = name_cell{1};
    fname = strcat('lp_', basename);
    matfile = fullfile(lp_root, strcat(basename, '_e2e.mat'));
    load(matfile);
    S.(fname).e2e = e2e;
    S.(fname).end_coords = end_coords;
    clear e2e end_coords
end
