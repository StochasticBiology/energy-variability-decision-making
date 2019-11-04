# code to calculate steady states of non-linear ODEs
import os
import numpy as np
from scipy.integrate import odeint
import scipy.optimize
import matplotlib.pyplot as plt
import pandas as pd
from sympy import Matrix
from sympy.abc import rho, phi

# change the current working directory to .py file location
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# fixed parameters
n = 4
thetaA = 0.5
thetaB = 0.5


def H(X):  # defining ODEs with x1 = X[0], x2 = X[1]
    x1Dot = lambdaValue*a*X[0]**n/(thetaA**n+X[0]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[1]**n)-k*X[0]
    x2Dot = lambdaValue*a*X[1]**n/(thetaA**n+X[1]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[0]**n)-k*X[1]
    return [x1Dot, x2Dot]


def lambdaFunction(energy):  # defining lambda
    return (1+np.exp(8-16*energy))**(-1)


# create a directory for script outputs, after first checking if it already exists
dataDirectory = './data-files'
directoryNames = [dataDirectory]
for dirName in range(len(directoryNames)):
    if not os.path.exists(directoryNames[dirName]):
        os.makedirs(directoryNames[dirName])

"""
Bifurcation diagrams varying a
"""
# create empty dataframe
uniqueSSDataframe_a = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'SteadyStateX1', 'SteadyStateX2', 'Stability'])

# loop through a & A*
b = 1
k = 1
aSteps = np.array([0, 1, 1.25, 1.75, 3])
for aStep in range(len(aSteps)):
    a = aSteps[aStep]
    print('\n\na = ' + str(a))
    energySteps = np.linspace(0, 1, 201)
    for step in range(len(energySteps)):
        energy = round(energySteps[step], 4)
        lambdaValue = lambdaFunction(energy)
        print('Energy Step: ' + str(energy))

        # calculate jacobian
        symODEs = Matrix([lambdaValue*a*rho**n/(thetaA**n+rho**n) + lambdaValue * b*thetaB**n/(thetaB**n+phi**n)-k*rho, lambdaValue*a*phi**n/(thetaA**n+phi**n) + lambdaValue *
                          b*thetaB**n/(thetaB**n+rho**n)-k*phi])
        symVariables = Matrix([rho, phi])
        symJac = symODEs.jacobian(symVariables)

        # create empty lists for unique steady states
        uniqueSteadyStatesList = []
        uniqueSteadyStatesCount = []

        # loop through mesh of initial conditions
        icX1 = np.linspace(0, 4.0, 17)
        icX2 = np.linspace(0, 4.0, 17)
        for s in icX1:
            for v in icX2:
                X0 = np.array([s, v])
                # calculate roots of ODEs
                sol = scipy.optimize.root(H, X0, method='lm', options={
                                          'xtol': 1e-16, 'ftol': 1e-12})
                z = sol.x

                # sub calculated root back into ODEs
                solSubODEs = H([z[0], z[1]])

                # test steady state (z[0], z[1]) >= 0
                if (z[0] >= 0) and (z[1] >= 0) and (abs(solSubODEs[0]) <= 1e-8) and (abs(solSubODEs[1]) <= 1e-8):

                    # calc eigenvalues & determine steady state stability
                    substitutedJac = symJac.subs([(rho, z[0]), (phi, z[1])])
                    substitutedJac2 = np.array(substitutedJac).astype(np.float64)
                    eigenvalues = np.linalg.eigvals(substitutedJac2)
                    if all([eigenvalues[0] < 0, eigenvalues[1] < 0]):
                        stability = 'Stable'
                    else:
                        stability = 'Unstable'

                    # find unique steady states
                    steadyState1 = round(z[0], 3)
                    steadyState2 = round(z[1], 3)
                    steadyState = [steadyState1, steadyState2, stability]
                    if steadyState in uniqueSteadyStatesList:
                        uniqueSteadyStatesCount[uniqueSteadyStatesList.index(
                            steadyState)] += 1
                    else:
                        uniqueSteadyStatesList.append(steadyState)
                        uniqueSteadyStatesCount.append(1)

        # populate dataframe with unique steady states
        for z in range(len(uniqueSteadyStatesList)):
            uniqueSSDataframe_a.loc[len(uniqueSSDataframe_a)] = [a, b, k, n, thetaA, thetaB, energy,
                                                                 uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1], uniqueSteadyStatesList[z][2]]
# export dataframe to csv file(no index col)
csvFileName = "data-files/bif-a-unique-steady-states.csv"
export_Dataframe = uniqueSSDataframe_a.to_csv(csvFileName, index=False, header=True)
# -------------------------------------------------------
# -------------------------------------------------------
"""
Bifurcation diagrams varying b
"""
# create empty dataframe
uniqueSSDataframe_b = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'SteadyStateX1', 'SteadyStateX2', 'Stability'])

# loop through b & A*
a = 1
k = 1
bSteps = np.array([0.25, 0.5, 0.75, 1.5])
for bStep in range(len(bSteps)):
    b = bSteps[bStep]
    print('\n\nb = ' + str(b))
    energySteps = np.linspace(0, 1, 201)
    for step in range(len(energySteps)):
        energy = round(energySteps[step], 4)
        lambdaValue = lambdaFunction(energy)
        print('Energy Step: ' + str(energy))

        # calculating jacobian
        symODEs = Matrix([lambdaValue*a*rho**n/(thetaA**n+rho**n) + lambdaValue * b*thetaB**n/(thetaB**n+phi**n)-k*rho, lambdaValue*a*phi**n/(thetaA**n+phi**n) + lambdaValue *
                          b*thetaB**n/(thetaB**n+rho**n)-k*phi])
        symVariables = Matrix([rho, phi])
        symJac = symODEs.jacobian(symVariables)

        # create empty lists for unique steady states
        uniqueSteadyStatesList = []
        uniqueSteadyStatesCount = []

        # loop through mesh of initial conditions
        icX1 = np.linspace(0, 4.0, 17)
        icX2 = np.linspace(0, 4.0, 17)
        for s in icX1:
            for v in icX2:
                X0 = np.array([s, v])
                # calculate roots of ODEs
                sol = scipy.optimize.root(H, X0, method='lm', options={
                                          'xtol': 1e-16, 'ftol': 1e-12})
                z = sol.x

                # sub calculated root back into ODEs
                solSubODEs = H([z[0], z[1]])

                # test steady state (z[0], z[1]) >= 0
                if (z[0] >= 0) and (z[1] >= 0) and (abs(solSubODEs[0]) <= 1e-8) and (abs(solSubODEs[1]) <= 1e-8):
                    # calc eigenvalues & determine steady state stability
                    substitutedJac = symJac.subs([(rho, z[0]), (phi, z[1])])
                    substitutedJac2 = np.array(substitutedJac).astype(np.float64)
                    eigenvalues = np.linalg.eigvals(substitutedJac2)
                    if all([eigenvalues[0] < 0, eigenvalues[1] < 0]):
                        stability = 'Stable'
                    else:
                        stability = 'Unstable'

                    # find unique steady states
                    steadyState1 = round(z[0], 3)
                    steadyState2 = round(z[1], 3)
                    steadyState = [steadyState1, steadyState2, stability]
                    if steadyState in uniqueSteadyStatesList:
                        uniqueSteadyStatesCount[uniqueSteadyStatesList.index(
                            steadyState)] += 1
                    else:
                        uniqueSteadyStatesList.append(steadyState)
                        uniqueSteadyStatesCount.append(1)

        # populate dataframe with unique steady states
        for z in range(len(uniqueSteadyStatesList)):
            uniqueSSDataframe_b.loc[len(uniqueSSDataframe_b)] = [a, b, k, n, thetaA, thetaB, energy,
                                                                 uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1], uniqueSteadyStatesList[z][2]]
# export dataframe to csv file (no index col)
csvFileName = "data-files/bif-b-unique-steady-states.csv"
export_Dataframe = uniqueSSDataframe_b.to_csv(csvFileName, index=False, header=True)
# -------------------------------------------------------
# -------------------------------------------------------
"""
Bifurcation diagrams varying k
"""
# create empty dataframe
uniqueSSDataframe_k = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'SteadyStateX1', 'SteadyStateX2', 'Stability'])

# loop through k & A*
a = 1
b = 1
kSteps = np.array([0.5, 1.25, 1.5, 3])
for kStep in range(len(kSteps)):
    k = kSteps[kStep]
    print('\n\nk = ' + str(k))

    energySteps = np.linspace(0, 1, 201)  # np.linspace(0, 1, 11) #
    for step in range(len(energySteps)):
        energy = round(energySteps[step], 4)
        lambdaValue = lambdaFunction(energy)
        print('Energy Step: ' + str(energy))

        # calculating jacobian
        symODEs = Matrix([lambdaValue*a*rho**n/(thetaA**n+rho**n) + lambdaValue * b*thetaB**n/(thetaB**n+phi**n)-k*rho, lambdaValue*a*phi**n/(thetaA**n+phi**n) + lambdaValue *
                          b*thetaB**n/(thetaB**n+rho**n)-k*phi])
        symVariables = Matrix([rho, phi])
        symJac = symODEs.jacobian(symVariables)

        # create empty lists for unique steady states
        uniqueSteadyStatesList = []
        uniqueSteadyStatesCount = []

        # loop through mesh of initial conditions
        icX1 = np.linspace(0, 4.0, 17)
        icX2 = np.linspace(0, 4.0, 17)
        for s in icX1:
            for v in icX2:
                X0 = np.array([s, v])
                # calculate roots of ODEs
                sol = scipy.optimize.root(H, X0, method='lm', options={
                                          'xtol': 1e-16, 'ftol': 1e-12})
                z = sol.x

                # sub calculated root back into ODEs
                solSubODEs = H([z[0], z[1]])

                # test steady state (z[0], z[1]) >= 0
                if (z[0] >= 0) and (z[1] >= 0) and (abs(solSubODEs[0]) <= 1e-8) and (abs(solSubODEs[1]) <= 1e-8):
                    # calc eigenvalues & determine steady state stability
                    substitutedJac = symJac.subs([(rho, z[0]), (phi, z[1])])
                    substitutedJac2 = np.array(substitutedJac).astype(np.float64)
                    eigenvalues = np.linalg.eigvals(substitutedJac2)
                    if all([eigenvalues[0] < 0, eigenvalues[1] < 0]):
                        stability = 'Stable'
                    else:
                        stability = 'Unstable'

                    # find unique steady states
                    steadyState1 = round(z[0], 3)
                    steadyState2 = round(z[1], 3)
                    steadyState = [steadyState1, steadyState2, stability]
                    if steadyState in uniqueSteadyStatesList:
                        uniqueSteadyStatesCount[uniqueSteadyStatesList.index(
                            steadyState)] += 1
                    else:
                        uniqueSteadyStatesList.append(steadyState)
                        uniqueSteadyStatesCount.append(1)

        # populate dataframe with unique steady states
        for z in range(len(uniqueSteadyStatesList)):
            uniqueSSDataframe_k.loc[len(uniqueSSDataframe_k)] = [a, b, k, n, thetaA, thetaB, energy,
                                                                 uniqueSteadyStatesList[z][0], uniqueSteadyStatesList[z][1], uniqueSteadyStatesList[z][2]]
# export dataframe to csv file (no index col)
csvFileName = "data-files/bif-k-unique-steady-states.csv"
export_Dataframe = uniqueSSDataframe_k.to_csv(csvFileName, index=False, header=True)
