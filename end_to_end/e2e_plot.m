%Simple script for plotting the change in end to end distance over time
for n = 1:32
if n == 1
plot(e2e(n,:)*10^9);
hold on;
else
plot(e2e(n,:)*10^9);
end
end

xlabel('Time Steps');
ylabel('Centromere to Centromere Distance (nm)');