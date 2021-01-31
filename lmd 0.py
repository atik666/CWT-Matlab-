import numpy as np
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing mat data file
from scipy.io import loadmat
file = 108
data = loadmat(r'D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.007\%d.mat' %file)

# Coverting the data file to 1-D
dataDE = np.ravel(data["X%d_DE_time" %file])
dataFE = np.ravel(data["X%d_FE_time" %file])

# Importing the LMD function
from PyLMD import LMD
lmd = LMD(max_num_pf = 4)

def applyLMD(data):
    L = 10 # Number of samples
    k = 0  
    u = []  # List initialization
    
    # for loop for LMD
    for i in range(L):
        E = data[k:k+599]
        PFs = lmd.lmd(E)[0]  # Take the first return of LMD function
        u.append(PFs[0])  # Storing in list u
        k=k+600
    return u
        
# Taking the first n elements from arrays in a list
def Extract(lst): 
    return [item[0,:] for item in lst]  # taking the first 5 PFs.

u = applyLMD(dataDE)
# First 5 PFs
u = Extract(u)

import statistics as st
import numpy
w, h = len(u[0][:,0]), len(u) # Width and length of the PFs


