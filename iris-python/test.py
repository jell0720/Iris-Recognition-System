import numpy as np

a = np.array([[1,2,3], [1,2,3], [1,2,3]])
a = np.reshape(a, [9])
a = np.delete(a, 5)
print(a)