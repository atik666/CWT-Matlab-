import numpy as np
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing mat data file
from scipy.io import loadmat
file = 108 # File name
data = loadmat(r'D:\OneDrive - ump.edu.my\Atik_Home\Data Files\Bearing Data Center\12K Drive End Bearing Fault Data\Inner Race\0.007\%d.mat' %file)

# Coverting the data file to 1-D
dataDE = np.ravel(data["X%d_DE_time" %file]) # DE channel
dataFE = np.ravel(data["X%d_FE_time" %file]) # FE channel

# Importing the LMD function
from PyLMD import LMD
lmd = LMD(max_num_pf = 1) # Specify number of PFs you want

def lmdFun(data):
    L = 200 # Number of samples
    ensem = 100 # Number of ensembles
    k = 0  
    PFs = []
    noise = []
    allPFs = [[0 for x in range(ensem)] for y in range(L)] # Initiating nested list of PFs
    allNoise = [[0 for x in range(ensem)] for y in range(L)] # Initiating nested list of noise
    
    # for loop for LMD
    for i in range(L): 
        for j in range(ensem):  
            y = data[k:k+600] # Take portion of dataset
            stdy = np.std(y) # Std of data
            if stdy < 0.01:
                stdy = 1       
            y = y / stdy
            k=k+600
           
            Nstd = (0.2 - 0.1)*np.random.randn(1,1) + 0.1 # Range of random std
            
            x = np.random.randn(len(y))
            x = x - np.mean(x) # Genrating 0 mean and 1 std
            x = x - np.std(x)
            
            wn = x * Nstd # White noise
            y1 = y + wn # Signal +_white noise
            PF = lmd.lmd((y1[0]))[0] # PFs of signal plus white noise
            nPF = lmd.lmd((wn[0]))[0] # PFs of white noise
            allPFs[i][j] = (PF[0]) # list of all ensemble PFs
            allNoise[i][j] = (nPF[0]) # list of all ensemble noise PFs
    
    sumPFs = np.vstack([sum(allPFs[i])*stdy/ensem for i in range(len(allPFs))]) # Ensemble PFs
    sumNoise = np.vstack([sum(allNoise[i])/ensem for i in range(len(allNoise))]) # Ensemble noise
    
    FPFs = sumPFs - sumNoise # Final PFs
    return FPFs # Final value from NEELMD

dePF = lmdFun(dataDE)
fePF = lmdFun(dataFE)

writer = pd.ExcelWriter('D:\OneDrive - ump.edu.my\Atik_Home\Writing\WCNN\Code\dataLMD\%d.xlsx' %file, engine='xlsxwriter')
pd.DataFrame(dePF).to_excel(writer, sheet_name='DE', header= False, index = False)
pd.DataFrame(fePF).to_excel(writer, sheet_name='FE', header= False, index = False)
writer.save()
