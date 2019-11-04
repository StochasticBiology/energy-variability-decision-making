# code to calculate number of stable steady states of non-linear ODEs with linear lambda.
import os
import scipy.optimize
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import pandas as pd
from sympy import Matrix
from sympy.abc import rho, phi

# change the current working directory to .py file location
os.chdir(os.path.dirname(os.path.abspath(__file__)))


# fixed parameters
k = 1
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
    return (1*energy)


# create a directory for script outputs, after first checking if it already exists
dataDirectory = './data-files'
directoryNames = [dataDirectory]
for dirName in range(len(directoryNames)):
    if not os.path.exists(directoryNames[dirName]):
        os.makedirs(directoryNames[dirName])


# create empty dataframe
numStableSSDataframe = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB', 'Energy',
                       'NumberSteadyStates', 'NumberStableSteadyStates'])

# loop through a, b, A*
aSteps = np.array([0, 0.5, 1, 1.5, 2, 3])
for aStep in range(len(aSteps)):
    a = aSteps[aStep]
    print('\n\na = ' + str(a))

    bSteps = np.linspace(0, 3, 13)
    for bStep in range(len(bSteps)):
        b = bSteps[bStep]
        print('b = ' + str(b))

        energySteps = np.linspace(0, 1, 11)
        for step in range(len(energySteps)):
            energy = round(energySteps[step], 4)
            lambdaValue = lambdaFunction(energy)

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

            # calculate number of unique stable steady states
            stableMatches = [uniqueSteadyStatesList[row]
                             for row in range(len(uniqueSteadyStatesList)) if uniqueSteadyStatesList[row][2] == 'Stable']
            numStableMatches = len(stableMatches)

            # populate number of stable steady states dataframe
            numStableSSDataframe.loc[len(numStableSSDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                   energy, len(uniqueSteadyStatesList), numStableMatches]
# export dataframe to csv files (without index col)
csvFileName2 = "data-files/linear-number-stable.csv"
export_Dataframe2 = numStableSSDataframe.to_csv(csvFileName2, index=False, header=True)
