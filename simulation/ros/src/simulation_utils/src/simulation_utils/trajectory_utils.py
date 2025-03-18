import numpy as np

def has_intersect(traj1, traj2):
	assert type(traj1) is np.ndarray, type(traj1)
	assert type(traj2) is np.ndarray, type(traj2)
	for i in range(traj1.shape[0]-1):
		x1, y1 = traj1[i]
		x2, y2 = traj1[i+1]
		for j in range(traj2.shape[0]-1):
			x3, y3 = traj2[j]
			x4, y4 = traj2[j+1]
			if ((x3-x1) * (y4-y1) - (x4-x1) * (y3-y1)) * ((x3-x2) * (y4-y2) - (x4-x2) * (y3-y2)) <= 0 and \
					((x1-x3) * (y2-y3) - (x2-x3) * (y1-y3)) * ((x1-x4) * (y2-y4) - (x2-x4) * (y1-y4)) <= 0:
				return True
	return False