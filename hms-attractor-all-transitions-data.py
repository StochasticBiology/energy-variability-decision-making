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

data = pd.read_csv("data-files/unique-steady-states-n4.csv")
# print(data.head())

nSteps = np.array([4])  # linspace(1, 4, 4)
for nStep in range(len(nSteps)):
    n = nSteps[nStep]
    print('\nn = ' + str(n))

    aSteps = np.array([0, 0.5, 1, 1.5, 2, 3])  # np.array([3])  #
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

                attractorStatesData = data.loc[(data['n'] == n) & (data['a'] == a) &
                                               (data['b'] == b) & (data['Energy'] == energy) & (data['Stability'] == 'Stable')]
                # print(attractorStatesData)

                attractorStatesDataSize = len(attractorStatesData.index)

                if attractorStatesDataSize == 1:
                    MinimumTransitionDistance = 'NaN'
                elif attractorStatesDataSize >= 2:
                    minDistances = []
                    for g in range(attractorStatesDataSize):
                        l = [calculateDistance(attractorStatesData.iloc[i][7], attractorStatesData.iloc[i][8], attractorStatesData.iloc[g][7],
                                               attractorStatesData.iloc[g][8]) for i in range(attractorStatesDataSize) if i != g]
                        # print(l)
                        minDistances.append(min(l))
                    # print(minDistances)
                    MinimumTransitionDistance = min(minDistances)
                print('Minimum Transition Distance = ' + str(MinimumTransitionDistance))

                """
                Minimum Transition Distance DataFrame
                """
                # # populate dataframe
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]
    # # export to csv file without index col
    csvFileName = "data-files/min-transition-dist-all-n%.0f.csv" % n
    export_Dataframe3 = attractorDistanceDataframe.to_csv(
        csvFileName, index=False, header=True)

end = timer()
totalTime = end - start
print('Accumilated Time = ' + str(totalTime))
