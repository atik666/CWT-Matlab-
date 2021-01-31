import numpy as np
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Data aquisition settings
Fs= 12000
rpm=1797
speed=rpm/60
data_cycle=3*Fs/speed

# Importing mat data file
from scipy.io import loadmat
data = loadmat('base.mat')


# Coverting the data file to 1-D
baseDE = np.ravel(data["X097_DE_time"])
baseFE = np.ravel(data["X097_FE_time"])

sample_duration=len(baseDE)/Fs

# Importing the LMD function
from PyLMD import LMD
lmd = LMD()

L = 90 # Number of samples
k=1  
u = []  # List initialization
v = []

# for loop for LMD
for i in range(L):
    E = baseDE[k:k+math.floor(data_cycle)]
    PFs_DE = lmd.lmd(E)[0]  # Take the first return of LMD function
    u.append(PFs_DE)  # Storing in list u
    F = baseFE[k:k+math.floor(data_cycle)]
    PFs_FE = lmd.lmd(F)[0]
    v.append(PFs_FE) # Storing in list v for channel 2
    k=k+math.floor(data_cycle)

# Inner race data    
irdata = loadmat('IR007_0.mat')
irDE = np.ravel(irdata["X105_DE_time"])
irFE = np.ravel(irdata["X105_FE_time"])

k=1  

# for loop for LMD
for i in range(L):
    E = irDE[k:k+math.floor(data_cycle)]
    irPFs_DE = lmd.lmd(E)[0]  # Take the first return of LMD function
    u.append(irPFs_DE)  # Storing in list u
    F = irFE[k:k+math.floor(data_cycle)]
    irPFs_FE = lmd.lmd(F)[0]
    v.append(irPFs_FE)
    k=k+math.floor(data_cycle)

#Outer race data    
ordata = loadmat('OR007@6_0.mat')
orDE = np.ravel(ordata["X130_DE_time"])
orFE = np.ravel(ordata["X130_FE_time"])

k=1  

# for loop for LMD
for i in range(L):
    E = orDE[k:k+math.floor(data_cycle)]
    orPFs_DE = lmd.lmd(E)[0]  # Take the first return of LMD function
    u.append(orPFs_DE)  # Storing in list u
    F = orFE[k:k+math.floor(data_cycle)]
    orPFs_FE = lmd.lmd(F)[0]
    v.append(orPFs_FE)
    k=k+math.floor(data_cycle)  

# Ball fault data
bldata = loadmat('B007_0.mat')
blDE = np.ravel(bldata["X118_DE_time"])
blFE = np.ravel(bldata["X118_FE_time"])

k=1  

# for loop for LMD
for i in range(L):
    E = blDE[k:k+math.floor(data_cycle)]
    blPFs_DE = lmd.lmd(E)[0]  # Take the first return of LMD function
    u.append(blPFs_DE)  # Storing in list u
    F = blFE[k:k+math.floor(data_cycle)]
    blPFs_FE = lmd.lmd(F)[0]
    v.append(blPFs_FE)
    k=k+math.floor(data_cycle)
    
# Taking the first n elements from arrays in a list
def Extract(lst): 
    return [item[0:5,:] for item in lst]  # taking the first 5 PFs.

# First 5 PFs
u = Extract(u)
v = Extract(v)

import statistics as st
import numpy
w, h = len(u[0][:,0]), len(u) # Width and length of the PFs

# Function for statistical feature extraction from PFs
def Matrix(x,u): # Input x = statistical function, u = PFs from a channel
    w, h = len(u[0][:,0]), len(u)
    Matrix = [[0 for x in range(w)] for y in range(h)] 
    import numpy as np
    for i in range(h):
        for j in range(w):
            Matrix[i][j]=x(u[i][j])
    
    Matrix = np.array(Matrix)
    return Matrix  # returns a statistical feature matrix

# Alternative function for statistical feature extraction from PFs 
# def Matrix(x,u):
#     Matrix_i=[]
#     Matrix_j=[]
#     for i in range(len(u)):
#         Matrix_j.clear()
#         for j in range(len(u[0][:,0])):
#             Matrix_j.append(x(u[i][j]))
#         Matrix_i.append(Matrix_j)
    
#     return Matrix_i
                
from scipy.stats import norm, kurtosis, skew, entropy

# Statistical feature extraction
med1 = Matrix(st.median,u)
mean1 = Matrix(st.mean,u)
std1 = Matrix(st.stdev,u)
var1 = Matrix(st.variance,u)
kurt1 = Matrix(kurtosis,u)
skew1 = Matrix(skew,u)
#ent1 = Matrix(entropy,u)

med2 = Matrix(st.median,v)
mean2 = Matrix(st.mean,v)
std2 = Matrix(st.stdev,v)
var2 = Matrix(st.variance,v)
kurt2 = Matrix(kurtosis,v)
skew2 = Matrix(skew,v)
#ent2 = Matrix(entropy,v)

# Creating class label
c1 = np.zeros(90)+1
c2 = np.zeros(90)+2
c3 = np.zeros(90)+3
c4 = np.zeros(90)+4
# Adding class label in an 1-D array
lbl = np.concatenate((c1, c2, c3, c4))

# Adding all the statistical features horizontally
feat = np.concatenate((med1, mean1, std1, var1, kurt1, skew1, med2, mean2, std2, var2, kurt2, skew2),axis=1)
    