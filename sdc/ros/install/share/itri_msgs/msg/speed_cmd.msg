Header header

uint8 OPEN_LOOP = 0
uint8 CLOSE_LOOP = 1

uint8 NON_DEFINE = 0
uint8 ACCELERATION = 1
uint8 CONSTANT_SPEED = 2
uint8 DEACCELERATION = 3

uint8 type
float32 kph
float32 acceleration
uint8 velocityCmdState
