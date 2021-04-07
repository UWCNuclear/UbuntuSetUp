# Create your views here.
import requests
import re
import os
import numpy as np
import glob
import pandas as pd
import time
from matplotlib import pyplot as plt

from bs4 import BeautifulSoup
from tqdm import tqdm
from time import gmtime, strftime

# =============================================================================

N=100
x = np.random.rand(N)
y = np.random.rand(N)
hit = (x*x + y*y < 1.0) 
plt.scatter(x[np.logical_not(hit)], y[np.logical_not(hit)], color="orange", marker=".")
plt.scatter(x[hit], y[hit], color="blue", marker=".")
plt.axis("equal")
hit = 1.0*hit
pi_est = 4*hit.sum()/N
pi_err = 4*np.std(hit)/np.sqrt(N)
print(f"pi_est = {pi_est} +/- {pi_err} [hits: {hit.sum()}/{N}]")
