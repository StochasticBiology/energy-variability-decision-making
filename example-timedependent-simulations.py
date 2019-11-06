# code to plot time-dependent simulations for bifrucation diagram examples

# import necessary libraries
import matplotlib.pyplot as plt
import os
import numpy as np
from scipy import integrate
from PIL import ImageColor
import random

# change the current working directory to .py file location
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# create a directory for script outputs - modify location individually
svgDirectoryLocation = '/Users/rdk316/Dropbox/PhD/publications/energy_variability_decision_making/sci-reports/initial-submission-reviewed/figure-files'
os.chdir(svgDirectoryLocation)
svgDirectory = './svg-figures'
directoryNames = [svgDirectory]
for dirName in range(len(directoryNames)):
    if not os.path.exists(directoryNames[dirName]):
        os.makedirs(directoryNames[dirName])


def H(X, t=0):  # defining ODEs with x1 = X[0], x2 = X[1]
    x1Dot = lambdaValue*a*X[0]**n/(thetaA**n+X[0]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[1]**n)-k*X[0]
    x2Dot = lambdaValue*a*X[1]**n/(thetaA**n+X[1]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[0]**n)-k*X[1]
    return [x1Dot, x2Dot]


def lambdaFunction(energy):  # defining lambda
    return (1+np.exp(8-16*energy))**(-1)


# generate 1000 linearly spaced numbers for x-axes
t = np.linspace(0, 20, 1000)

"""
1 stable steady state example
"""
# fixed parameters
a = 1
b = 1
k = 1
n = 4
thetaA = 0.5
thetaB = 0.5
energy = 0.25
lambdaValue = lambdaFunction(energy)

# create figure
fig = plt.figure(figsize=(8, 7))
ax = plt.subplot(111)
axisMajorTicksX = np.arange(0, 16, 5)
axisMinorTicksX = np.arange(0, 16, 1)
axisMajorTicksY = np.arange(0, 4.5, 1)
axisMinorTicksY = np.arange(0, 4.5, 0.5)

# loop over mesgh of initial conditions
for x0 in np.linspace(0, 4, 11):
    for y0 in np.linspace(0, 4, 11):
        X0 = np.array([x0, y0])

        # solve ODEs
        X, infodict = integrate.odeint(H, X0, t, full_output=True)
        x, y = X.T

        # solve ODEs using soln as initial conditions (check stablity of end point)
        X0_2 = np.array([x[999]+random.uniform(1e-5, 1), y[999]+random.uniform(1e-5, 1)])
        X2, infodict = integrate.odeint(H, X0_2, t, full_output=True)
        x2, y2 = X2.T

        if (round(x[999], 4) == round(x2[999], 4)) & (round(y[999], 4) == round(y2[999], 4)):
            # plot phase portrait
            ax.plot(t, x[:], color='blue', linewidth=0.7)
        else:
            continue

ax.set_xlim([0, 15])
ax.set_ylim([0, 4])

ax.set_xticks(axisMajorTicksX)
ax.set_xticks(axisMinorTicksX, minor=True)
ax.set_yticks(axisMajorTicksY)
ax.set_yticks(axisMinorTicksY, minor=True)
ax.grid(which='minor', alpha=0.2)
ax.grid(which='major', alpha=0.5)
ax.tick_params(axis='both', which='major', labelsize=20)

# save phase portrait
ax.grid(b=True, linewidth=0.8)
save_name = "%s/bif-example-1-stable-state.svg" % svgDirectory
fig.savefig(save_name)


"""
2 stable steady state example
"""
# fixed parameters
a = 1
b = 1
k = 1
n = 4
thetaA = 0.5
thetaB = 0.5
energy = 0.5
lambdaValue = lambdaFunction(energy)

# create figure
fig = plt.figure(figsize=(8, 7))
ax = plt.subplot(111)
axisMajorTicksX = np.arange(0, 16, 5)
axisMinorTicksX = np.arange(0, 16, 1)
axisMajorTicksY = np.arange(0, 4.5, 1)
axisMinorTicksY = np.arange(0, 4.5, 0.5)

# loop over mesgh of initial conditions
for x0 in np.linspace(0, 4, 11):
    for y0 in np.linspace(0, 4, 11):
        X0 = np.array([x0, y0])

        # solve ODEs
        X, infodict = integrate.odeint(H, X0, t, full_output=True)
        x, y = X.T

        # solve ODEs using soln as initial conditions (check stablity of end point)
        X0_2 = np.array([x[999]+random.uniform(1e-5, 1), y[999]+random.uniform(1e-5, 1)])
        X2, infodict = integrate.odeint(H, X0_2, t, full_output=True)
        x2, y2 = X2.T

        if (round(x[999], 4) == round(x2[999], 4)) & (round(y[999], 4) == round(y2[999], 4)):
            # plot phase portrait
            ax.plot(t, x[:], color='blue', linewidth=0.7)
        else:
            continue

ax.set_xlim([0, 15])
ax.set_ylim([0, 4])

ax.set_xticks(axisMajorTicksX)
ax.set_xticks(axisMinorTicksX, minor=True)
ax.set_yticks(axisMajorTicksY)
ax.set_yticks(axisMinorTicksY, minor=True)
ax.grid(which='minor', alpha=0.2)
ax.grid(which='major', alpha=0.5)
ax.tick_params(axis='both', which='major', labelsize=20)
ax.tick_params(direction='in', length=0.1)

# save phase portrait
ax.grid(b=True, linewidth=0.8)
save_name = "%s/bif-example-2-stable-state.svg" % svgDirectory
fig.savefig(save_name)


"""
3 stable steady state example
"""
# fixed parameters
a = 1
b = 1
k = 1
n = 4
thetaA = 0.5
thetaB = 0.5
energy = 0.8
lambdaValue = lambdaFunction(energy)

# create figure
fig = plt.figure(figsize=(8, 7))
ax = plt.subplot(111)
axisMajorTicksX = np.arange(0, 16, 5)
axisMinorTicksX = np.arange(0, 16, 1)
axisMajorTicksY = np.arange(0, 4.5, 1)
axisMinorTicksY = np.arange(0, 4.5, 0.5)

# loop over mesgh of initial conditions
for x0 in np.linspace(0, 4, 11):
    for y0 in np.linspace(0, 4, 11):
        X0 = np.array([x0, y0])

        # solve ODEs
        X, infodict = integrate.odeint(H, X0, t, full_output=True)
        x, y = X.T

        # solve ODEs using soln as initial conditions (check stablity of end point)
        X0_2 = np.array([x[999]+random.uniform(1e-5, 1), y[999]+random.uniform(1e-5, 1)])
        X2, infodict = integrate.odeint(H, X0_2, t, full_output=True)
        x2, y2 = X2.T

        if (round(x[999], 4) == round(x2[999], 4)) & (round(y[999], 4) == round(y2[999], 4)):
            # plot phase portrait
            ax.plot(t, x[:], color='blue', linewidth=0.7)
        else:
            continue

ax.set_xlim([0, 15])
ax.set_ylim([0, 4])

ax.set_xticks(axisMajorTicksX)
ax.set_xticks(axisMinorTicksX, minor=True)
ax.set_yticks(axisMajorTicksY)
ax.set_yticks(axisMinorTicksY, minor=True)
ax.grid(which='minor', alpha=0.2)
ax.grid(which='major', alpha=0.5)
ax.tick_params(axis='both', which='major', labelsize=20)
ax.tick_params(direction='in', length=0.1)

# save phase portrait
ax.grid(b=True, linewidth=0.8)
save_name = "%s/bif-example-3-stable-state.svg" % svgDirectory
fig.savefig(save_name)
