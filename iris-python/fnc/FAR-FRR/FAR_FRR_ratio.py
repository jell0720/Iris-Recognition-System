from numpy import*
from FAR_FRR_cal import*
from min_coordi import min_coordi
"""
Do Tieu Thien
19/9/2017
-------------
Input:  DI_all	: Distances of sample images [20,20,400].
        step_num: Step for increment of threshold.
Output:
"""

def FAR_FRR_ratio(DI_all,step_num,label_map):
    # A set of thresholds
    max_dis = amax(DI_all)
    thres = linspace(0,max_dis,step_num+2)
    # Prepare
    FAR_rate = zeros((1,step_num))
    FRR_rate = zeros((1,step_num))
    # Examine each threshold
    for i in range(step_num):
        FAR_rate[i] = FAR_cal(DI_all, label_map, thres[i+1])
        # Calculate FRR
        FRR_rate[i] = FRR_cal(DI_all, label_map, thres[i+1])

    # Find for the minimum
    [FAR_rate, thres_FAR] = min_coordi(FAR_rate)
    [FRR_rate, thres_FRR] = min_coordi(FRR_rate)