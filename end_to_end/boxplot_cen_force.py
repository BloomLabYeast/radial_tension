import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.stats import kruskal

df = pd.read_csv('directional_force.csv')

# split the df into loop size with uniform persistence length
df_lp50 = df.loc[df.persistenceLength == 50]
# split the df into persistence length with uniform loop size
df_loop10 = df.loc[df.loopSize == 10]

# boxplot of total force vs loop size
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_lp50.loopSize, y=df_lp50.totalForce)
ax.set_ylim(0, 11)
ax.set_title('Centromere Masses')
ax.set_ylabel('Force (pN)')
ax.set_xlabel('Loop Size (kb)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('total_cen_force_vs_loopsize_boxplot.tif', dpi=600)
plt.close(fig)

# boxplot of total force vs persistence length
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_loop10.persistenceLength, y=df_loop10.totalForce)
ax.set_ylim(0, 11)
ax.set_title('Centromere Masses')
ax.set_ylabel('Force (pN)')
ax.set_xlabel('Persistence Length (nm)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('total_cen_force_vs_lp_boxplot.tif', dpi=600)
plt.close(fig)

# boxplot of axial force vs loop size
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_lp50.loopSize, y=df_lp50.axialForce)
ax.set_ylim(0, 4)
ax.set_title('Centromere Masses')
ax.set_ylabel('Axial Force (pN)')
ax.set_xlabel('Loop Size (kb)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('axial_cen_force_vs_loopsize_boxplot.tif', dpi=600)
plt.close(fig)

# boxplot of axial force vs persistence length
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_loop10.persistenceLength, y=df_loop10.axialForce)
ax.set_ylim(0, 4)
ax.set_title('Centromere Masses')
ax.set_ylabel('Axial Force (pN)')
ax.set_xlabel('Persistence Length (nm)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('axial_cen_force_vs_lp_boxplot.tif', dpi=600)
plt.close(fig)

# boxplot of radial force vs loop size
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_lp50.loopSize, y=df_lp50.radialForce)
ax.set_ylim(0, 10)
ax.set_title('Centromere Masses')
ax.set_ylabel('Radial Force (pN)')
ax.set_xlabel('Loop Size (kb)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('radial_cen_force_vs_loopsize_boxplot.tif', dpi=600)
plt.close(fig)

# boxplot of axial force vs persistence length
fig = plt.figure(figsize=(3.25, 2.437))
ax = sns.boxplot(x=df_loop10.persistenceLength, y=df_loop10.radialForce)
ax.set_ylim(0, 10)
ax.set_title('Centromere Masses')
ax.set_ylabel('Radial Force (pN)')
ax.set_xlabel('Persistence Length (nm)')
plt.subplots_adjust(left=0.2, bottom=0.2)
ax.figure.savefig('radial_cen_force_vs_lp_boxplot.tif', dpi=600)
plt.close(fig)

# Prep for the Kruskal-Wallis non-parametric test
total_size_h, total_size_p = kruskal(
    df_lp50.loc[df_lp50.loopSize == 6].totalForce,
    df_lp50.loc[df_lp50.loopSize == 10].totalForce,
    df_lp50.loc[df_lp50.loopSize == 15].totalForce,
    df_lp50.loc[df_lp50.loopSize == 20].totalForce,
    df_lp50.loc[df_lp50.loopSize == 23].totalForce
)

total_lp_h, total_lp_p = kruskal(
    df_loop10.loc[df_loop10.persistenceLength == 5].totalForce,
    df_loop10.loc[df_loop10.persistenceLength == 50].totalForce,
    df_loop10.loc[df_loop10.persistenceLength == 200].totalForce,
    df_loop10.loc[df_loop10.persistenceLength == 500].totalForce
)

axial_size_h, axial_size_p = kruskal(
    df_lp50.loc[df_lp50.loopSize == 6].axialForce,
    df_lp50.loc[df_lp50.loopSize == 10].axialForce,
    df_lp50.loc[df_lp50.loopSize == 15].axialForce,
    df_lp50.loc[df_lp50.loopSize == 20].axialForce,
    df_lp50.loc[df_lp50.loopSize == 23].axialForce
)

axial_lp_h, axial_lp_p = kruskal(
    df_loop10.loc[df_loop10.persistenceLength == 5].axialForce,
    df_loop10.loc[df_loop10.persistenceLength == 50].axialForce,
    df_loop10.loc[df_loop10.persistenceLength == 200].axialForce,
    df_loop10.loc[df_loop10.persistenceLength == 500].axialForce
)

radial_size_h, radial_size_p = kruskal(
    df_lp50.loc[df_lp50.loopSize == 6].radialForce,
    df_lp50.loc[df_lp50.loopSize == 10].radialForce,
    df_lp50.loc[df_lp50.loopSize == 15].radialForce,
    df_lp50.loc[df_lp50.loopSize == 20].radialForce,
    df_lp50.loc[df_lp50.loopSize == 23].radialForce
)

radial_lp_h, radial_lp_p = kruskal(
    df_loop10.loc[df_loop10.persistenceLength == 5].radialForce,
    df_loop10.loc[df_loop10.persistenceLength == 50].radialForce,
    df_loop10.loc[df_loop10.persistenceLength == 200].radialForce,
    df_loop10.loc[df_loop10.persistenceLength == 500].radialForce
)
print(f"Loop size P-value: {total_size_p}, Total")
print(f"Persistence Length P-value: {total_lp_p}, Total")

print(f"Loop size P-value: {axial_size_p}, Axial")
print(f"Persistence Length P-value: {axial_lp_p}, Axial")

print(f"Loop size P-value: {radial_size_p}, Radial")
print(f"Persistence Length P-value: {radial_lp_p}, Radial")

