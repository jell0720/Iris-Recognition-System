from numpy import*
"""
Do Tieu Thien
"""

def FAR_cal(DI_all,label_map,thres):
    accept_map = DI_all < thres
    label_map = label_map.astype(bool)
    FAR_map = accept_map*(~label_map)
    # Calculate FAR rate
    FAR_rate = sum(FAR_map)
    FAR_rate = FAR_rate/160000
    return(FAR_rate)