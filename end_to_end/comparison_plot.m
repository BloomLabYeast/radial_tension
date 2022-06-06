%Script for comparing centromere separation of pericentric models
%WT
load('WTSpindle_2ns_e2e.mat')
errorbar((0:size(e2e,2)-1).*10^-5,mean(e2e)*10^9,std(e2e)/sqrt(32)*10^9)
xlabel('Simulation Time (Seconds)');
ylabel('Mean Centromere Separation (nm)');
hold on;
%No Condensin
load('noCondensinSpindle_2ns_e2e.mat');
errorbar((0:size(e2e,2)-1).*10^-5,mean(e2e)*10^9,std(e2e)/sqrt(32)*10^9)
%No Cohesin
load('noCohesinSpindle_2ns_e2e.mat')
errorbar((0:size(e2e,2)-1).*10^-5,mean(e2e)*10^9,std(e2e)/sqrt(32)*10^9)
%No SMC
load('noCohesinNoCondensinSpindle_2ns_e2e.mat')
errorbar((0:size(e2e,2)-1).*10^-5,mean(e2e)*10^9,std(e2e)/sqrt(32)*10^9)
%legend
hold off;
legend({'WT', 'No Condensin', 'No Cohesin', 'No SMC'});