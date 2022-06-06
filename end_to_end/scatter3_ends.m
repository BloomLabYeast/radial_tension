%Simple script for plotting the motion of the end beads over time.

for n = 1:64
if n == 1
figure;
scatter3(end_coords(n,1,:), end_coords(n,2,:), end_coords(n,3,:));
hold on;
else
scatter3(end_coords(n,1,:), end_coords(n,2,:), end_coords(n,3,:));
end
end