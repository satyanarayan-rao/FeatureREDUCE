import sys
from collections import defaultdict
import gzip
import re
import pickle

out_dict = open(sys.argv[1], "wb")
o_d = defaultdict(lambda : False)
for line in sys.stdin:
    o_d[line.strip()] = True
pickle.dump(dict(o_d), out_dict)
out_dict.close() 

