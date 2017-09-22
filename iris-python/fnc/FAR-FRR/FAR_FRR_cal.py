from numpy import*
"""
Do Tieu Thien
"""

def FAR_cal(DI_all,label_map,thres):
    accept_map = DI_all < thres
    FAR_map = accept_map*(~label_map)
    # Calculate FAR rate
    FAR_rate = sum(FAR_map)
    FAR_rate = FAR_rate/160000
    return(FAR_rate)

def FRR_cal(DI_all,label_map, thres):
    reject_map = DI_all > thres
    FRR_map = reject_map*label_map
    # Calculate FRR rate
    FRR_rate = sum(FRR_map)
    FRR_rate = FRR_rate/160000
    return(FRR_rate)