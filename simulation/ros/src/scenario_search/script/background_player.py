import ctypes

se = ctypes.CDLL("/project/mmsl_simulation/src/esmini/bin/libesminiLib.so")
se.SE_Init(
    b"/project/mmsl_simulation/src/scenario/data/hct_logistic/hct_0_background.xosc",
    1,
    1,
    0,
    0,
    2,
)

for i in range(500):
    se.SE_Step()
