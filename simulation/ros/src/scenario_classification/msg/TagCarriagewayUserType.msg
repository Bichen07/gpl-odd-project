# ref: 車輛安全檢測項目之車種代號及其適用規定

uint8 PRIMARY_UNKNOWN=0
uint8 PRIMARY_L=1     # 2 or 3 wheels Vehicles
uint8 PRIMARY_M=2     # >= 4 wheels, carrying passengers
uint8 PRIMARY_N=3     # >= 4 wheels, carrying cargos
uint8 PRIMARY_O=4     # Trailer, Semi-Trailer
uint8 PRIMARY_G=5     # More Specific M and N vehicle.  Not used in the code for now.
uint8 PRIMARY_VRU=6   # vulnerable road user
uint8 primary_category

uint8 SECONDARY_UNKNOWN=0
uint8 SECONDARY_L1=1     # 2 wheels, <= 50 c.c., <= 5hp, <= 50kph
uint8 SECONDARY_L2=2     # 3 wheels, <= 50 c.c., <= 5hp, <= 50kph
uint8 SECONDARY_L3=3     # 2 wheels, > 50 c.c., > 5hp, > 50kph
uint8 SECONDARY_L5=4     # 3 wheels, > 50 c.c., > 5hp, > 50kph
uint8 SECONDARY_M1=5     # <= 9 seats
uint8 SECONDARY_M2=6     # > 9 seats, <= 5t
uint8 SECONDARY_M3=7     # > 9 seats, > 5t
uint8 SECONDARY_N1=8     # <= 3.5t
uint8 SECONDARY_N2=9     # > 3.5t, <= 12t
uint8 SECONDARY_N3=10    # > 12t
uint8 SECONDARY_O1=11    # <= 0.75t
uint8 SECONDARY_O2=12    # > 0.75t, <= 3.5t
uint8 SECONDARY_O3=13    # > 3.5t, <= 10t
uint8 SECONDARY_O4=14    # > 10t
uint8 SECONDARY_M1G=15   # 
uint8 SECONDARY_N1G=16   # 
uint8 SECONDARY_M2G=17   # 
uint8 SECONDARY_N2G=18   # 
uint8 SECONDARY_M3G=19   # 
uint8 SECONDARY_N3G=20   # 
uint8 SECONDARY_Pedestrian=21
uint8 SECONDARY_Cyclist=22
uint8 SECONDARY_Other=23
uint8 secondary_category