# scipy.optimize.root:
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.root.html
# https://stackoverflow.com/questions/30630382/scipy-optimize-root-does-not-converge-in-python-while-matlab-fsolve-works-why

# stability check with trace and determinant
# https://ocw.mit.edu/courses/mathematics/18-03sc-differential-equations-fall-2011/unit-iv-first-order-systems/qualitative-behavior-phase-portraits/MIT18_03SCF11_s34_5text.pdf

# subbing values into sympy Matrix
# https://docs.sympy.org/latest/tutorial/basic_operations.html

# eigenvectors with scipy.linalg
# https://www.math.ubc.ca/~pwalls/math-python/linear-algebra/eigenvalues-eigenvectors/


import os
import scipy.optimize
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import pandas as pd
from timeit import default_timer as timer
import math
# import Tkinter
# import tkMessageBox
import sys

# for jacobian
from sympy import Matrix
from sympy.abc import rho, phi


def calculateDistance(x1, y1, x2, y2):
    dist = math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
    return dist


attractorDistanceDataframe = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB',
                       'Energy', 'MinimumTransitionDistance'])
"""
fixed parameters
"""
k = 1
thetaA = 0.5
thetaB = 0.5

start = timer()

"""
Take the filename of your script, convert it to an absolute path, then extract the directory
of that path, then change the current working directory to that directory
"""
os.chdir(os.path.dirname(os.path.abspath(__file__)))

nSteps = np.array([4])  # linspace(1, 4, 4)
for nStep in range(len(nSteps)):
    n = nSteps[nStep]
    print('\nn = ' + str(n))

    data = pd.read_csv("data-files/unique-steady-states-n%.0f.csv" % n)
    # print(data.head())

    aSteps = np.array([0, 0.5, 1, 1.5, 2, 3])  # np.array([2])  #
    for aStep in range(len(aSteps)):
        a = aSteps[aStep]
        print('a = ' + str(a))

        bSteps = np.linspace(0, 3, 13)  # np.array([0.25])  #
        for bStep in range(len(bSteps)):
            b = bSteps[bStep]
            print('b = ' + str(b))

            energySteps = np.linspace(0, 1, 11)
            for step in range(len(energySteps)):
                energy = round(energySteps[step], 4)
                # print(energy)

                attractorStatesData = data.loc[(data['n'] == n) & (data['a'] == a) &
                                               (data['b'] == b) & (data['Energy'] == energy) & (data['Stability'] == 'Stable')]
                # print(attractorStatesData)

                attractorStatesDataSize = len(attractorStatesData.index)

                if attractorStatesDataSize == 1:
                    MinimumTransitionDistance = 'NaN'
                elif attractorStatesDataSize == 2:
                    # print(stableMatches[0][0], stableMatches[0][1],
                    #       stableMatches[1][0], stableMatches[1][1])
                    MinimumTransitionDistance = calculateDistance(attractorStatesData.iloc[0][7], attractorStatesData.iloc[0][8],
                                                                  attractorStatesData.iloc[1][7], attractorStatesData.iloc[1][8])
                elif attractorStatesDataSize == 3:
                    for g in range(attractorStatesDataSize):
                        if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                            centralAttractor = np.array(
                                [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][7]])
                            centralAttractorRow = g
                            continue
                    # print(centralAttractor)
                    l = [calculateDistance(attractorStatesData.iloc[i][7], attractorStatesData.iloc[i][8], centralAttractor[0],
                                           centralAttractor[1]) for i in range(attractorStatesDataSize) if i != centralAttractorRow]
                    # print(l)
                    MinimumTransitionDistance = min(l)
                elif attractorStatesDataSize == 4:
                    # print('Number Attractors =' + str(attractorStatesDataSize))
                    centralAttractorList = []
                    centralAttractorRowList = []
                    for g in range(attractorStatesDataSize):
                        if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                            centralAttractorList.append(
                                [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                            centralAttractorRowList.append(g)
                            continue
                    # print(centralAttractorList)
                    # print(centralAttractorRowList)
                    minDistances = []
                    for i in range(len(centralAttractorList)):
                        # print(centralAttractorList[i])
                        # print(centralAttractorRowList[i])
                        l = [calculateDistance(attractorStatesData.iloc[j][7], attractorStatesData.iloc[j][8], centralAttractorList[i][0],
                                               centralAttractorList[i][1]) for j in range(attractorStatesDataSize) if j not in centralAttractorRowList]
                        # print(l)
                        minDistances.append(min(l))
                    # print(minDistances)
                    MinimumTransitionDistance = min(minDistances)
                else:
                    print("Number of Attractors = %.0f" % attractorStatesDataSize)
                    print("Execution finished due to unexpected number of attractor states.")
                    # messageBoxText = "Number of Attractors = %.0f" % attractorStatesDataSize
                    # messagebox.showerror("Error", "messageBoxText")
                    sys.exit()
                    # print('Minimum Transition Distance = ' + str(MinimumTransitionDistance))

                """
                Minimum Transition Distance DataFrame
                """
                # # populate dataframe
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]
    # # export to csv file without index col
    csvFileName = "data-files/min-transition-dist-extremes-n%.0f.csv" % n
    export_Dataframe3 = attractorDistanceDataframe.to_csv(
        csvFileName, index=False, header=True)

end = timer()
totalTime = end - start
print('Accumilated Time = ' + str(totalTime))
