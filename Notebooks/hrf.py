import numpy as np
from scipy.special import loggamma
      

def gamma_pdf(x, k, theta):
    return np.exp((k -1) * np.log(x) + k * np.log(theta) - theta * x - loggamma(k))
    
    
def sample_hrf(timepoints, onset, duration=0, hrf_parameters=[6, 16, 1, 1, 6, 0, 32]):
    k1 = hrf_parameters[0] / hrf_parameters[2]
    theta1 = 1 / hrf_parameters[2]
    k2 = hrf_parameters[1] / hrf_parameters[3]
    theta2 = 1 / hrf_parameters[3]
    peak_ratio = hrf_parameters[4]
    
    hrf = np.zeros(timepoints.size)
    if duration == 0:
        indices = timepoints > onset
        hrf[indices] = gamma_pdf(timepoints[indices] - onset, k1, theta1) - gamma_pdf(timepoints[indices] - onset, k2, theta2) / peak_ratio
        return hrf / (1 - 1 / peak_ratio)
    else:
        #to be implemented like: https://github.com/TimVanMourik/OpenFmriAnalysis/blob/master/Core/private/tvm_sampleHrf.m
        return np.zeros(timepoints.size)
