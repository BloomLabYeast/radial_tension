function force_pN = distance_force(dist_array, timestep, num_timesteps)
%%INWARD_FORCE function calculates the inward force based on the drag force
%%of the chromoShake centromere models and the mean velocity after
%%equilibration of given timesteps (equib_force_pn), mean velocity before
%%equilibration (early_force_pN), and mean velocity over all time
%%(total_force_pN).


%% Calculate the drag force
%Stokes drag coefficient based off of default chromoShake parameters
viscosity = 0.001; %Pa*s
drag_radius = 8E-9; %m
stokes_coeff = 6*pi()*viscosity*drag_radius;
mass_damping_ratio = 10^5;
%chromoShake "pins" masses in space by allowing the user to specify an
%increase in the drag force. This is the purpose of allowing the beads to
%have a "mass" in the simulation, as the mass is not used anywhere else in
%the simulator to calcuate force. For masses with the default mass
%of 3.38889E-20, the mass term simply cancels out and drag force is Stoke's
%Law. Howver, the user can alter the "mass" of the masses thus linearly
%increases the drag force of that bead without changing any other
%parameter. Thus increasing "mass" actually increases viscosity felt by
%that individual bead.
mass_damping_coeff = stokes_coeff * mass_damping_ratio;
equib_velocities = dist_array/(timestep*num_timesteps);
force_pN = mass_damping_coeff * equib_velocities * 1E12;