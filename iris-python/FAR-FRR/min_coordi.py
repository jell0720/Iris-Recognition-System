from numpy import*
"""
Do Tieu Thien
24/9/2017
"""
def min_coordi(vector):
    M = amin(vector)
    for i in range(shape(vector)[0]):
            if vector[0,i] == M:
                break

    return([M,i+1])