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

# for jacobian
from sympy import Matrix
from sympy.abc import rho, phi

"""
Take the filename of your script, convert it to an absolute path, then extract the directory
of that path, then change the current working directory to that directory
"""
os.chdir(os.path.dirname(os.path.abspath(__file__)))


def H(X):  # ODEs
    # x1 = X[0], x2 = X[1]
    x1Dot = lambdaValue*a*X[0]**n/(thetaA**n+X[0]**n) + lambdaValue * \
            b*thetaB**n/(thetaB**n+X[1]**n)-k*X[0]
    x2Dot = lambdaValue*a*X[1]**n/(thetaA**n+X[1]**n) + lambdaValue * \
            b*thetaB**n/(thetaB**n+X[0]**n)-k*X[1]
    return [x1Dot, x2Dot]


def lambdaFunction(energy):
    return (1+np.exp(8-16*energy))**(-1)

"""
fixed parameters
"""
k = 1
n = 4
thetaA = 0.5
thetaB = 0.5


"""
bifurcation diagrams with a=1, b=0.5, energy = [0.48, 0.54]
"""
start = timer()
# # create empty dataframe
uniqueSSDataframe_b_zoom = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'SteadyStateX1', 'SteadyStateX2', 'Stability'])

numStableSSDataframe_b_zoom = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'NumberSteadyStates', 'NumberStableSteadyStates'])

a = 1
b = 0.5
energyLowerBound = 0.48
energyUpperBound = 0.54
stepSize = 0.0005
numberSteps = round(((energyUpperBound-energyLowerBound)/stepSize)+1, 3)
print(numberSteps)

energySteps = np.linspace(energyLowerBound, energyUpperBound, numberSteps) # np.linspace(0, 1, 201)  #
for step in range(len(energySteps)):
    energy = round(energySteps[step], 5)
    lambdaValue = lambdaFunction(energy)
    print('Energy Step: ' + str(energy))
    # print(lambdaValue)
#     # print(H([1, 1]))

    """
    Calculating jacobian
    """
    symODEs = Matrix([lambdaValue*a*rho**n/(thetaA**n+rho**n) + lambdaValue * b*thetaB**n/(thetaB**n+phi**n)-k*rho, lambdaValue*a*phi**n/(thetaA**n+phi**n) + lambdaValue *
                      b*thetaB**n/(thetaB**n+rho**n)-k*phi])
    symVariables = Matrix([rho, phi])
    symJac = symODEs.jacobian(symVariables)

    """
    Create empty lists for unique steady states
    """
    uniqueSteadyStatesList = []
    uniqueSteadyStatesCount = []

    icX1 = np.linspace(0, 4.0, 21)
    icX2 = np.linspace(0, 4.0, 21)
    for s in icX1:
        for v in icX2:
            X0 = np.array([s, v])
            sol = scipy.optimize.root(H, X0, method='lm', options={'xtol': 1e-16, 'ftol': 1e-12})
            z = sol.x

            solSubODEs = H([z[0], z[1]])
            # print(H([z[0], z[1]]))

            # Test that steady states z[0] & z[1] >= 0 !!!
            if (z[0] >= 0) and (z[1] >= 0) and (abs(solSubODEs[0]) <= 1e-8) and (abs(solSubODEs[1]) <= 1e-8):
                substitutedJac = symJac.subs([(rho, z[0]), (phi, z[1])])
                substitutedJac2 = np.array(substitutedJac).astype(np.float64)
                eigenvalues = np.linalg.eigvals(substitutedJac2)

                if all([eigenvalues[0] < 0, eigenvalues[1] < 0]):
                    stability = 'Stable'
                else:
                    stability = 'Unstable'

                steadyState1 = round(z[0], 3)
                steadyState2 = round(z[1], 3)
                steadyState = [steadyState1, steadyState2, stability]
                if steadyState in uniqueSteadyStatesList:
                    uniqueSteadyStatesCount[uniqueSteadyStatesList.index(
                        steadyState)] += 1
                else:
                    uniqueSteadyStatesList.append(steadyState)
                    uniqueSteadyStatesCount.append(1)

    stableMatches = [uniqueSteadyStatesList[row] for row in range(len(uniqueSteadyStatesList))
                     if uniqueSteadyStatesList[row][2] == 'Stable']

    numStableMatches = len(stableMatches)
    # print(numStableMatches)

    # # Unique steady states dataframe
    # # populate dataframe 'uniqueSSDataframe'
    for z in range(len(uniqueSteadyStatesList)):
        # print([uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1]])
        uniqueSSDataframe_b_zoom.loc[len(uniqueSSDataframe_b_zoom)] = [a, b, k, n, thetaA, thetaB, energy,
                                                         uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1], uniqueSteadyStatesList[z][2]]
    # # export to csv file without index col
    csvFileName = "data-files/unique-steady-states-bif-b-zoom.csv"
    export_Dataframe = uniqueSSDataframe_b_zoom.to_csv(csvFileName, index=False, header=True)


    # # Number of STABLE steady states dataframe
    # # populate dataframe 'numSSDataframe'
    numStableSSDataframe_b_zoom.loc[len(numStableSSDataframe_b_zoom)] = [a, b, k, n, thetaA, thetaB,
                                                           energy, len(uniqueSteadyStatesList), numStableMatches]
    # # export to csv file without index col
    csvFileName3 = "data-files/number-stable-ss-bif-b-zoom.csv"
    export_Dataframe3 = numStableSSDataframe_b_zoom.to_csv(
        csvFileName3, index=False, header=True)

end = timer()

print(end - start)

# -------------------------------------------------------
# -------------------------------------------------------

"""
bifurcation diagrams with a=3, b=1, energy = [0.40, 0.46]
"""
start = timer()
# # create empty dataframe
uniqueSSDataframe_a_zoom = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'SteadyStateX1', 'SteadyStateX2', 'Stability'])

numStableSSDataframe_a_zoom = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'NumberSteadyStates', 'NumberStableSteadyStates'])

a = 3
b = 1
energyLowerBound = 0.4
energyUpperBound = 0.46
stepSize = 0.0005
numberSteps = round(((energyUpperBound-energyLowerBound)/stepSize)+1, 3)
print(numberSteps)

energySteps = np.linspace(energyLowerBound, energyUpperBound, numberSteps) # np.linspace(0, 1, 201)  #
for step in range(len(energySteps)):
    energy = round(energySteps[step], 5)
    lambdaValue = lambdaFunction(energy)
    print('Energy Step: ' + str(energy))

    """
    Calculating jacobian
    """
    symODEs = Matrix([lambdaValue*a*rho**n/(thetaA**n+rho**n) + lambdaValue * b*thetaB**n/(thetaB**n+phi**n)-k*rho, lambdaValue*a*phi**n/(thetaA**n+phi**n) + lambdaValue *
                      b*thetaB**n/(thetaB**n+rho**n)-k*phi])
    symVariables = Matrix([rho, phi])
    symJac = symODEs.jacobian(symVariables)

    """
    Create empty lists for unique steady states
    """
    uniqueSteadyStatesList = []
    uniqueSteadyStatesCount = []

    icX1 = np.linspace(0, 4.0, 21)
    icX2 = np.linspace(0, 4.0, 21)
    for s in icX1:
        for v in icX2:
            X0 = np.array([s, v])
            sol = scipy.optimize.root(H, X0, method='lm', options={'xtol': 1e-16, 'ftol': 1e-12})
            z = sol.x
            solSubODEs = H([z[0], z[1]])

            # Test that steady states z[0] & z[1] >= 0 !!!
            if (z[0] >= 0) and (z[1] >= 0) and (abs(solSubODEs[0]) <= 1e-8) and (abs(solSubODEs[1]) <= 1e-8):
                substitutedJac = symJac.subs([(rho, z[0]), (phi, z[1])])
                substitutedJac2 = np.array(substitutedJac).astype(np.float64)
                eigenvalues = np.linalg.eigvals(substitutedJac2)

                if all([eigenvalues[0] < 0, eigenvalues[1] < 0]):
                    stability = 'Stable'
                else:
                    stability = 'Unstable'

                steadyState1 = round(z[0], 3)
                steadyState2 = round(z[1], 3)
                steadyState = [steadyState1, steadyState2, stability]
                if steadyState in uniqueSteadyStatesList:
                    uniqueSteadyStatesCount[uniqueSteadyStatesList.index(
                        steadyState)] += 1
                else:
                    uniqueSteadyStatesList.append(steadyState)
                    uniqueSteadyStatesCount.append(1)

    stableMatches = [uniqueSteadyStatesList[row] for row in range(len(uniqueSteadyStatesList))
                     if uniqueSteadyStatesList[row][2] == 'Stable']

    numStableMatches = len(stableMatches)
    # print(numStableMatches)

    # # Unique steady states dataframe
    # # populate dataframe 'uniqueSSDataframe'
    for z in range(len(uniqueSteadyStatesList)):
        # print([uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1]])
        uniqueSSDataframe_a_zoom.loc[len(uniqueSSDataframe_a_zoom)] = [a, b, k, n, thetaA, thetaB, energy,
                                                         uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1], uniqueSteadyStatesList[z][2]]
    # # export to csv file without index col
    csvFileName = "data-files/unique-steady-states-bif-a-zoom.csv"
    export_Dataframe = uniqueSSDataframe_a_zoom.to_csv(csvFileName, index=False, header=True)


    # # Number of STABLE steady states dataframe
    # # populate dataframe 'numSSDataframe'
    numStableSSDataframe_a_zoom.loc[len(numStableSSDataframe_a_zoom)] = [a, b, k, n, thetaA, thetaB,
                                                           energy, len(uniqueSteadyStatesList), numStableMatches]
    # # export to csv file without index col
    csvFileName3 = "data-files/number-stable-ss-bif-a-zoom.csv"
    export_Dataframe3 = numStableSSDataframe_a_zoom.to_csv(
        csvFileName3, index=False, header=True)

end = timer()

print(end - start)