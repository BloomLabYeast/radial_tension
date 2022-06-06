%%Summary script for calculate the mean and sem of the inward force of
%%different centromere simulations
%% Define mat files
s.wt.mat = 'WTSpindle_2ns_e2e.mat';
s.noCond.mat = 'noCondensinSpindle_2ns_e2e.mat';
s.noCoh.mat = 'noCohesinSpindle_2ns_e2e.mat';
s.noSMC.mat = 'noCohesinNoCondensinSpindle_2ns_e2e.mat';
s.noCol.mat = 'wt_spindle_s1_noCol_end_coords.mat';
%% Loop through simulations
%Hardcoded variables
equib_timesteps_number = 5000;
timestep = 10^-5; %seconds
names = fieldnames(s);
for n = 1:numel(names)
    [s.(names{n}).equib_force_pN, s.(names{n}).early_force_pN, s.(names{n}).total_force_pN] = ...
        inward_force(s.(names{n}).mat, equib_timesteps_number, timestep);
    %sum the forces of each endbead pair to generate force on single
    %centromere. Index is as follows 1-17, 2-18, 3-19, etc
    index = [1:numel(s.(names{n}).equib_force_pN)/2;...
        (numel(s.(names{n}).equib_force_pN)/2 + 1):numel(s.(names{n}).equib_force_pN)];
    s.(names{n}).cen_equib_force_pN(index(1,:)) = s.(names{n}).equib_force_pN(index(1,:)) + ...
        s.(names{n}).equib_force_pN(index(2,:));
    s.(names{n}).cen_early_force_pN(index(1,:)) = s.(names{n}).early_force_pN(index(1,:)) + ...
        s.(names{n}).early_force_pN(index(2,:));
    s.(names{n}).cen_total_force_pN(index(1,:)) = s.(names{n}).total_force_pN(index(1,:)) + ...
        s.(names{n}).total_force_pN(index(2,:));
    s.(names{n}).mean_cen_equib = mean(s.(names{n}).cen_equib_force_pN);
    s.(names{n}).sem_cen_equib = std(s.(names{n}).cen_equib_force_pN)/...
        sqrt(numel(s.(names{n}).cen_equib_force_pN));
end
%% Generate bar chart with errorbars for collision based simulations
figure;
bar(1:4,abs([s.wt.mean_cen_equib,...
    s.noCond.mean_cen_equib,...
    s.noCoh.mean_cen_equib,...
    s.noSMC.mean_cen_equib]));
set(gca, 'YScale', 'log')
ylabel('Inward Force (pN)');
hold on;
errorbar(1:4,...
    abs([s.wt.mean_cen_equib,...
    s.noCond.mean_cen_equib,...
    s.noCoh.mean_cen_equib,...
    s.noSMC.mean_cen_equib]),...
    [s.wt.sem_cen_equib,...
    s.noCond.sem_cen_equib,...
    s.noCoh.sem_cen_equib,...
    s.noSMC.sem_cen_equib],'.');

%% Generate bar chart with errorbars to compare wt with and without collisions
figure;
bar(1:3,abs([s.wt.mean_cen_equib,s.noCoh.mean_cen_equib,s.noCol.mean_cen_equib]));
ylabel('Inward Force (pN)');
hold on;
errorbar(1:3,...
    abs([s.wt.mean_cen_equib,s.noCoh.mean_cen_equib,s.noCol.mean_cen_equib]),...
    [s.wt.sem_cen_equib,s.noCoh.sem_cen_equib, s.noCol.sem_cen_equib],'.');
xticklabels = {'WT', 'No Cohesin', 'WT No Collisions'};