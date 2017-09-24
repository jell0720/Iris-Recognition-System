from numpy import*
"""
Do Tieu Thien
"""

def FRR_cal(DI_all,label_map, thres):
    reject_map = DI_all > thres
    label_map = label_map.astype(bool)
    FRR_map = reject_map*label_map
    # Calculate FRR rate
    FRR_rate = sum(FRR_map)
    FRR_rate = FRR_rate/160000
    return(FRR_rate)