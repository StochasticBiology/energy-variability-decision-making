# code to calculate the distance between attractors.
import os
import scipy.optimize
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import pandas as pd
from sympy import Matrix
from sympy.abc import rho, phi
import math

# change the current working directory to .py file location
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# fixed parameters
k = 1
thetaA = 0.5
thetaB = 0.5
n = 4

# create a directory for script outputs, after first checking if it already exists
dataDirectory = './data-files'
directoryNames = [dataDirectory]
for dirName in range(len(directoryNames)):
    if not os.path.exists(directoryNames[dirName]):
        os.makedirs(directoryNames[dirName])


def calculateDistance(x1, y1, x2, y2):  # defining distance calc between two points
    dist = math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
    return dist


# create empty dataframe
attractorDistanceDataframe = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB',
                       'Energy', 'MinimumTransitionDistance'])

# import dataframe
data = pd.read_csv("data-files/sigmoid-n%.0f-unique-steady-states.csv" % n)

# loop through a, b and A*
aSteps = np.array([0, 0.5, 1, 1.5, 2, 3])
for aStep in range(len(aSteps)):
    a = aSteps[aStep]
    print('a = ' + str(a))

    bSteps = np.linspace(0, 3, 13)
    for bStep in range(len(bSteps)):
        b = bSteps[bStep]

        energySteps = np.linspace(0, 1, 11)
        for step in range(len(energySteps)):
            energy = round(energySteps[step], 4)

            # sub-dataframe for current parameter set & stable attractors only
            attractorStatesData = data.loc[(data['n'] == n) & (data['a'] == a) &
                                           (data['b'] == b) & (data['Energy'] == energy) & (data['Stability'] == 'Stable')]
            # size of sub-dataframe
            attractorStatesDataSize = len(attractorStatesData.index)

            # calculate minimuum distance --> route depends on sub-dataframe size
            if attractorStatesDataSize == 1:
                MinimumTransitionDistance = 'NaN'
            elif attractorStatesDataSize == 2:
                MinimumTransitionDistance = calculateDistance(attractorStatesData.iloc[0][7], attractorStatesData.iloc[0][8],
                                                              attractorStatesData.iloc[1][7], attractorStatesData.iloc[1][8])
            elif attractorStatesDataSize == 3:
                for g in range(attractorStatesDataSize):
                    if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                        centralAttractor = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][7]])
                        centralAttractorRow = g
                        continue
                l = [calculateDistance(attractorStatesData.iloc[i][7], attractorStatesData.iloc[i][8], centralAttractor[0],
                                       centralAttractor[1]) for i in range(attractorStatesDataSize) if i != centralAttractorRow]
                MinimumTransitionDistance = min(l)
            elif attractorStatesDataSize == 4:
                centralAttractorList = []
                centralAttractorRowList = []
                for g in range(attractorStatesDataSize):
                    if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                        centralAttractorList.append(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                        centralAttractorRowList.append(g)
                        continue
                minDistances = []
                for i in range(len(centralAttractorList)):
                    l = [calculateDistance(attractorStatesData.iloc[j][7], attractorStatesData.iloc[j][8], centralAttractorList[i][0],
                                           centralAttractorList[i][1]) for j in range(attractorStatesDataSize) if j not in centralAttractorRowList]
                    minDistances.append(min(l))
                MinimumTransitionDistance = min(minDistances)
            else:  # exit script execution if number of attractors is > 4 (this is an error)
                print("Number of Attractors = %.0f" % attractorStatesDataSize)
                print("Execution finished due to unexpected number of attractor states.")
                sys.exit()

            # # populate minimum transition distance dataframe
            attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                               energy, MinimumTransitionDistance]
# export dataframes to csv files (without index col)
csvFileName = "data-files/sigmoid-n%.0f-min-transition-dist.csv" % n
export_Dataframe = attractorDistanceDataframe.to_csv(
    csvFileName, index=False, header=True)
