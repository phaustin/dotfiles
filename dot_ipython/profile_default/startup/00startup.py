import os, site
#from pathlib import Path
# home=os.environ['HOME']
# pythonlibs = Path(home).joinpath('./repos/pythonlibs')
# site.addsitedir(str(pythonlibs))
from pyutils.show_figure import show_plot as s
from IPython.core.display import display
from IPython.display import Image
import matplotlib
from matplotlib import pyplot as plt
from importlib import reload
import numpy as np
import scipy as sp
plt.style.use('ggplot')
print("ran {}".format(__file__))
