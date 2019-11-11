#  script calculates the minimum work needed to transition between extreme attractor basin.

# import modules and functinons
import os
import numpy as np
from scipy import integrate
import pandas as pd
import time

import matplotlib.pyplot as plt
import pylab as py


# change the current working directory to .py file location
os.chdir(os.path.dirname(os.path.abspath(__file__)))


def H(X, t=0):  # defining ODEs with x1 = X[0], x2 = X[1]
    x1Dot = lambdaValue*a*X[0]**n/(thetaA**n+X[0]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[1]**n)-k*X[0]
    x2Dot = lambdaValue*a*X[1]**n/(thetaA**n+X[1]**n) + lambdaValue * \
        b*thetaB**n/(thetaB**n+X[0]**n)-k*X[1]
    return [x1Dot, x2Dot]


def lambdaFunction(energy):  # defining lambda
    return (1+np.exp(8-16*energy))**(-1)


def calculateDistance(x1, y1, x2, y2):  # defining distance calc between two points
    dist = (x2 - x1)**2 + (y2 - y1)**2
    return dist


# linspace for time
t = np.linspace(0, 30, 1000)

# fixed parameters
k = 1
n = 4
thetaA = 0.5
thetaB = 0.5
epsilon = 0.005


# create a directory for script outputs, after first checking if it already exists
# change 'dataDirectoryLocation' to correct location
dataDirectoryLocation = 'U:/PhD/energy_decisions_manuscript/updated-files'
os.chdir(dataDirectoryLocation)
dataDirectoryName = './data-files'
directoryNames = [dataDirectoryName]
for dirName in range(len(directoryNames)):
    if not os.path.exists(directoryNames[dirName]):
        os.makedirs(directoryNames[dirName])

# import data
data = pd.read_csv("data-files/sigmoid-n%.0f-unique-steady-states.csv" % n)

# create empty dataframe for minmum basin transition distance
attractorDistanceDataframe = pd.DataFrame(
    index=[], columns=['a', 'b', 'k', 'n', 'thetaA', 'thetaB',
                       'Energy', 'MinimumTransitionDistance'])

# loop through a, b and A*
aSteps = np.array([0, 0.5, 1, 1.5, 2, 3])
for aStep in range(len(aSteps)):
    a = aSteps[aStep]
    print('\na = ' + str(a))

    bSteps = np.linspace(0, 3, 13)
    for bStep in range(len(bSteps)):
        b = bSteps[bStep]
        print('b = ' + str(b))

        energySteps = np.linspace(0, 1, 11)
        for step in range(len(energySteps)):
            energy = round(energySteps[step], 4)
            lambdaValue = lambdaFunction(energy)
            print(energy)

            # sub-dataframe for current parameter set & stable attractors only
            attractorStatesData = data.loc[(data['n'] == n) & (data['a'] == a) & (data['b'] == b) &
                                           (data['Energy'] == energy) & (data['Stability'] == 'Stable')]
            # print(attractorStatesData)

            # size of sub-dataframe
            attractorStatesDataSize = len(attractorStatesData.index)

            # 1 ATTRACTOR
            if attractorStatesDataSize == 1:
                MinimumTransitionDistance = 'NaN'
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]

            # 2 ATTRACTORS
            elif attractorStatesDataSize == 2:
                # label attractors
                for g in range(attractorStatesDataSize):
                    # print([attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                    if (attractorStatesData.iloc[g][7] > attractorStatesData.iloc[g][8]):
                        attractor0 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                    else:
                        attractor1 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                # print('Extreme Attractor 0 = ' + str(attractor0))
                # print('Extreme Attractor 1 = ' + str(attractor1))

                # create new dataframe
                dataframe1 = pd.DataFrame(
                    index=[], columns=['IC1', 'IC2', 'SteadyStateX1', 'SteadyStateX2', 'AttractorLabel'])

                # loop through a mesh of initial conditions
                for x0 in np.linspace(0, 6, 121):
                    for y0 in np.linspace(0, 6, 121):
                        X0 = np.array([x0, y0])

                        # solve ODEs
                        X, infodict = integrate.odeint(H, X0, t, full_output=True)
                        x, y = X.T

                        # final point --> attractor point
                        result = [x[999], y[999]]

                        # label end point with attractor label
                        roundedResult = [round(result[0], 3), round(result[1], 3)]
                        # print([round(x0, 3), round(y0, 3), roundedResult[0], roundedResult[1]])
                        if ((attractor0[0]-epsilon) < result[0] < (attractor0[0]+epsilon)) and ((attractor0[1]-epsilon) < result[1] < (attractor0[1]+epsilon)):
                            attractorLabel = 0
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor1[0]-epsilon) < result[0] < (attractor1[0]+epsilon)) and ((attractor1[1]-epsilon) < result[1] < (attractor1[1]+epsilon)):
                            attractorLabel = 1
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        else:
                            attractorLabel = 2

                        # print('Attractor state = ' + str(attractorLabel))

                # print(dataframe1)

                # loop through to calculate sub-dataframes
                minDistances2 = []
                for m in range(attractorStatesDataSize):
                    currentAttractor = globals()['attractor' + str(m)]

                    # sub-dataframe of ics going to other attractors
                    subDataFrame = dataframe1.loc[(dataframe1['AttractorLabel'] != m)]

                    # print('\n\n' + str(currentAttractor))
                    # print(m)
                    # print(subDataFrame)

                    # create dataframe
                    dataframe2 = pd.DataFrame(
                        index=[], columns=['BasinLabelStart', 'BasinLabelEnd', 'Distance'])

                    # iterate through rows of sub-dataframe
                    for index, row in subDataFrame.iterrows():
                        # calc distance from current attractor to ics
                        distToOtherBasin = calculateDistance(currentAttractor[0], currentAttractor[1],
                                                             row['IC1'], row['IC2'])
                        # populate dataframe2
                        dataframe2.loc[len(dataframe2)] = [
                            m, row['AttractorLabel'], distToOtherBasin]

                    # print(dataframe2)

                    MinimumTransitionDistance = dataframe2['Distance'].min()
                    MinimumTransitionDistanceRow = dataframe2['Distance'].idxmin()
                    # print(MinimumTransitionDistance)
                    # print(MinimumTransitionDistanceRow)
                    startBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 0]
                    endBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 1]
                    # print([startBasin, endBasin])
                    minDistances2.append(MinimumTransitionDistance)

                # find minimum
                MinimumTransitionDistance = min(minDistances2)

                # populate minimum transition distance dataframe
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]

            # 3 ATTRACTORS
            elif attractorStatesDataSize == 3:
                # label attractors
                for g in range(attractorStatesDataSize):
                    if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                        attractor1 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                    elif (attractorStatesData.iloc[g][7] > attractorStatesData.iloc[g][8]):
                        attractor0 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                    else:
                        attractor2 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                # print('\n\n')
                # print('Central Attractor = ' + str(attractor1))  # attractorLabel 1
                # print('Extreme Attractor 0 = ' + str(attractor0))  # attractorLabel 0
                # print('Extreme Attractor 1 = ' + str(attractor2))  # attractorLabel 2

                # create new dataframe
                dataframe1 = pd.DataFrame(
                    index=[], columns=['IC1', 'IC2', 'SteadyStateX1', 'SteadyStateX2', 'AttractorLabel'])

                # loop through a mesh of initial conditions
                for x0 in np.linspace(0, 6, 121):
                    for y0 in np.linspace(0, 6, 121):
                        X0 = np.array([x0, y0])

                        # solve ODEs
                        X, infodict = integrate.odeint(H, X0, t, full_output=True)
                        x, y = X.T

                        # final point --> attractor point
                        result = [x[999], y[999]]

                        # label end point with attractor label
                        roundedResult = [round(result[0], 3), round(result[1], 3)]
                        # print([round(x0, 3), round(y0, 3), roundedResult[0], roundedResult[1]])

                        # give label to attractor calculated from ics
                        if ((attractor0[0]-epsilon) < result[0] < (attractor0[0]+epsilon)) and ((attractor0[1]-epsilon) < result[1] < (attractor0[1]+epsilon)):
                            attractorLabel = 0
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor1[0]-epsilon) < result[0] < (attractor1[0]+epsilon)) and ((attractor1[1]-epsilon) < result[1] < (attractor1[1]+epsilon)):
                            attractorLabel = 1
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor2[0]-epsilon) < result[0] < (attractor2[0]+epsilon)) and ((attractor2[1]-epsilon) < result[1] < (attractor2[1]+epsilon)):
                            attractorLabel = 2
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        else:
                            attractorLabel = 3

                        # print('Attractor state = ' + str(attractorLabel))

                # print(dataframe1)

                # create new dataframe
                dataframe3 = pd.DataFrame(
                    index=[], columns=['StartBasin', 'EndBasin', 'MinDistance'])

                # loop through to calculate sub-dataframes
                for m in range(attractorStatesDataSize):
                    currentAttractor = globals()['attractor' + str(m)]

                    # sub-dataframe of ics going to other attractors
                    subDataFrame = dataframe1.loc[(dataframe1['AttractorLabel'] != m)]

                    # oldLoopList = list(range(attractorStatesDataSize))
                    newLoopList = [i for i in list(range(attractorStatesDataSize)) if i != m]
                    # print([m, newLoopList])

                    for p in newLoopList:
                        # create dataframe
                        dataframe2 = pd.DataFrame(
                            index=[], columns=['BasinLabelStart', 'BasinLabelEnd', 'Distance'])

                        # print([m, p])

                        # sub-dataframe
                        subsubDataFrame = subDataFrame.loc[(subDataFrame['AttractorLabel'] != p)]

                        # print(subsubDataFrame)

                        # iterate through rows of sub-dataframe
                        for index, row in subsubDataFrame.iterrows():
                            # calc distance from current attractor to basin != m and p
                            distToOtherBasin = calculateDistance(currentAttractor[0], currentAttractor[1],
                                                                 row['IC1'], row['IC2'])
                            # populate dataframe2
                            dataframe2.loc[len(dataframe2)] = [
                                m, row['AttractorLabel'], distToOtherBasin]

                        # print(dataframe2)

                        # find minimum distance
                        MinimumTransitionDistance = dataframe2['Distance'].min()
                        MinimumTransitionDistanceRow = dataframe2['Distance'].idxmin()

                        startBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 0]
                        endBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 1]

                        # populate dataframe2
                        dataframe3.loc[len(dataframe3)] = [startBasin,
                                                           endBasin, MinimumTransitionDistance]
                # print(dataframe3)

                # calculate transition routes & distances
                distance0to1Row = dataframe3.loc[(dataframe3['StartBasin'] == 0) & (
                    dataframe3['EndBasin'] == 1)]
                distance0to1 = distance0to1Row.iloc[0, 2]
                distance0to2Row = dataframe3.loc[(dataframe3['StartBasin'] == 0) & (
                    dataframe3['EndBasin'] == 2)]
                distance0to2 = distance0to2Row.iloc[0, 2]
                distance1to2Row = dataframe3.loc[(dataframe3['StartBasin'] == 1) & (
                    dataframe3['EndBasin'] == 2)]
                distance1to2 = distance1to2Row.iloc[0, 2]
                distance1to0Row = dataframe3.loc[(dataframe3['StartBasin'] == 1) & (
                    dataframe3['EndBasin'] == 0)]
                distance1to0 = distance1to0Row.iloc[0, 2]
                distance2to0Row = dataframe3.loc[(dataframe3['StartBasin'] == 2) & (
                    dataframe3['EndBasin'] == 0)]
                distance2to0 = distance2to0Row.iloc[0, 2]
                distance2to1Row = dataframe3.loc[(dataframe3['StartBasin'] == 2) & (
                    dataframe3['EndBasin'] == 1)]
                distance2to1 = distance2to1Row.iloc[0, 2]

                distance0to1to2 = distance0to1 + distance1to2
                distance2to1to0 = distance2to1 + distance1to0

                distancesToBasins = [distance0to1to2, distance2to1to0, distance0to2, distance2to0]

                # find minimum
                MinimumTransitionDistance = min(distancesToBasins)

                # populate minimum transition distance dataframe
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]
            # 4 ATTRACTORS
            else:
                # label attractors
                centralAttractorList = []
                centralAttractorRowList = []
                for g in range(attractorStatesDataSize):
                    if (attractorStatesData.iloc[g][7] == attractorStatesData.iloc[g][8]):
                        centralAttractorList.append(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                        centralAttractorRowList.append(g)
                    elif (attractorStatesData.iloc[g][7] > attractorStatesData.iloc[g][8]):
                        attractor0 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                    else:
                        attractor3 = np.array(
                            [attractorStatesData.iloc[g][7], attractorStatesData.iloc[g][8]])
                for i in range(len(centralAttractorList)):
                    globals()['attractor' + str(i+1)] = [centralAttractorList[i]
                                                         [0], centralAttractorList[i][1]]
                # print(centralAttractorList)
                # print('Attractor 0 (extreme) = ' + str(attractor0))  # zero / non-zero attractor
                # print('Attractor 1 (central) = ' + str(attractor1))  # non-zero attractor
                # print('Attractor 2 (central) = ' + str(attractor2))
                # print('Attractor 3 (extreme) = ' + str(attractor3))

                # create new dataframe
                dataframe1 = pd.DataFrame(
                    index=[], columns=['IC1', 'IC2', 'SteadyStateX1', 'SteadyStateX2', 'AttractorLabel'])

                # loop through a mesh of initial conditions
                for x0 in np.linspace(0, 6, 121):
                    for y0 in np.linspace(0, 6, 121):
                        X0 = np.array([x0, y0])

                        # solve ODEs
                        X, infodict = integrate.odeint(H, X0, t, full_output=True)
                        x, y = X.T

                        # final point --> attractor point
                        result = [x[999], y[999]]

                        # label end point with attractor label
                        roundedResult = [round(result[0], 3), round(result[1], 3)]
                        # print([round(x0, 3), round(y0, 3), roundedResult[0], roundedResult[1]])

                        # give label to attractor calculated from ics
                        if ((attractor0[0]-epsilon) < result[0] < (attractor0[0]+epsilon)) and ((attractor0[1]-epsilon) < result[1] < (attractor0[1]+epsilon)):
                            attractorLabel = 0
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor1[0]-epsilon) < result[0] < (attractor1[0]+epsilon)) and ((attractor1[1]-epsilon) < result[1] < (attractor1[1]+epsilon)):
                            attractorLabel = 1
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor2[0]-epsilon) < result[0] < (attractor2[0]+epsilon)) and ((attractor2[1]-epsilon) < result[1] < (attractor2[1]+epsilon)):
                            attractorLabel = 2
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        elif ((attractor3[0]-epsilon) < result[0] < (attractor3[0]+epsilon)) and ((attractor3[1]-epsilon) < result[1] < (attractor3[1]+epsilon)):
                            attractorLabel = 3
                            dataframe1.loc[len(dataframe1)] = [x0, y0, roundedResult[0], roundedResult[1],
                                                               attractorLabel]
                        else:
                            attractorLabel = 4

                        # print('Attractor state = ' + str(attractorLabel))
                # print(dataframe1)

                # create new dataframe
                dataframe3 = pd.DataFrame(
                    index=[], columns=['StartBasin', 'EndBasin', 'MinDistance'])

                # loop through to calculate sub-dataframes
                for m in range(attractorStatesDataSize):  # np.array([1, 2]):
                    currentAttractor = globals()['attractor' + str(m)]

                    # sub-dataframe of ics going to other attractors
                    subDataFrame = dataframe1.loc[(dataframe1['AttractorLabel'] != m)]

                    # create dataframe
                    dataframe2 = pd.DataFrame(
                        index=[], columns=['BasinLabelStart', 'BasinLabelEnd', 'Distance'])

                    # # oldLoopList = list(range(attractorStatesDataSize))
                    newLoopList = [i for i in list(range(attractorStatesDataSize)) if i != m]
                    # print([m, newLoopList])

                    for p in newLoopList:
                        # create dataframe
                        dataframe2 = pd.DataFrame(
                            index=[], columns=['BasinLabelStart', 'BasinLabelEnd', 'Distance'])

                        # print([m, p])

                        # sub-dataframe
                        subsubDataFrame = subDataFrame.loc[(subDataFrame['AttractorLabel'] == p)]

                        # print(subsubDataFrame)

                        # iterate through rows of sub-dataframe
                        for index, row in subsubDataFrame.iterrows():
                            # calc distance from current attractor m to basin p
                            distToOtherBasin = calculateDistance(currentAttractor[0], currentAttractor[1],
                                                                 row['IC1'], row['IC2'])
                            # populate dataframe2
                            dataframe2.loc[len(dataframe2)] = [
                                m, row['AttractorLabel'], distToOtherBasin]

                        # print(dataframe2)

                        MinimumTransitionDistance = dataframe2['Distance'].min()
                        MinimumTransitionDistanceRow = dataframe2['Distance'].idxmin()

                        startBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 0]
                        endBasin = dataframe2.iloc[MinimumTransitionDistanceRow, 1]

                        # populate dataframe2
                        dataframe3.loc[len(dataframe3)] = [startBasin,
                                                           endBasin, MinimumTransitionDistance]

                # print(dataframe3)

                # calculate transition routes & distances
                distance0to3Row = dataframe3.loc[(dataframe3['StartBasin'] == 0) & (
                    dataframe3['EndBasin'] == 3)]
                distance0to3 = distance0to3Row.iloc[0, 2]
                distance3to0Row = dataframe3.loc[(dataframe3['StartBasin'] == 3) & (
                    dataframe3['EndBasin'] == 0)]
                distance3to0 = distance3to0Row.iloc[0, 2]

                distance0to1Row = dataframe3.loc[(dataframe3['StartBasin'] == 0) & (
                    dataframe3['EndBasin'] == 1)]
                distance0to1 = distance0to1Row.iloc[0, 2]
                distance0to2Row = dataframe3.loc[(dataframe3['StartBasin'] == 0) & (
                    dataframe3['EndBasin'] == 2)]
                distance0to2 = distance0to2Row.iloc[0, 2]

                distance1to0Row = dataframe3.loc[(dataframe3['StartBasin'] == 1) & (
                    dataframe3['EndBasin'] == 0)]
                distance1to0 = distance1to0Row.iloc[0, 2]
                distance2to0Row = dataframe3.loc[(dataframe3['StartBasin'] == 2) & (
                    dataframe3['EndBasin'] == 0)]
                distance2to0 = distance2to0Row.iloc[0, 2]

                distance1to3Row = dataframe3.loc[(dataframe3['StartBasin'] == 1) & (
                    dataframe3['EndBasin'] == 3)]
                distance1to3 = distance1to3Row.iloc[0, 2]
                distance2to3Row = dataframe3.loc[(dataframe3['StartBasin'] == 2) & (
                    dataframe3['EndBasin'] == 3)]
                distance2to3 = distance2to3Row.iloc[0, 2]

                distance3to1Row = dataframe3.loc[(dataframe3['StartBasin'] == 3) & (
                    dataframe3['EndBasin'] == 1)]
                distance3to1 = distance3to1Row.iloc[0, 2]
                distance3to2Row = dataframe3.loc[(dataframe3['StartBasin'] == 3) & (
                    dataframe3['EndBasin'] == 2)]
                distance3to2 = distance3to2Row.iloc[0, 2]

                distance0to1to3 = distance0to1 + distance1to3
                distance3to1to0 = distance3to1 + distance1to0

                distance0to2to3 = distance0to2 + distance2to3
                distance3to2to0 = distance3to2 + distance2to0

                distancesToBasins = [distance0to1to3, distance3to1to0,
                                     distance0to2to3, distance3to2to0,
                                     distance0to3, distance3to0]

                # print(distancesToBasins)

                # find minimum
                MinimumTransitionDistance = min(distancesToBasins)

                # populate minimum transition distance dataframe
                attractorDistanceDataframe.loc[len(attractorDistanceDataframe)] = [a, b, k, n, thetaA, thetaB,
                                                                                   energy, MinimumTransitionDistance]

print(attractorDistanceDataframe)

# export dataframes to csv files (without index col)
csvFileName = "data-files/sigmoid-n%.0f-extreme-basin-transition-dist-NEW.csv" % n
export_Dataframe = attractorDistanceDataframe.to_csv(csvFileName, index=False, header=True)
