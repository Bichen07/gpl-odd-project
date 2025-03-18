#ifndef __SIMULATION_CONSTANTS_H__
#define __SIMULATION_CONSTANTS_H__

// simulation constants
static const float DEFAULT_SAMPLING_TIME = 0.01f;
static const b2Vec2 GRAVITY(0.0f, 0.0f);
static const int POSITION_ITERATIONS = 2;
static const int VELOCITY_ITERATIONS = 6;
static const int16 EGO_GROUP_INDEX = 1;
static const int16 AGENT_GROUP_INDEX = 2;

static const int LAYER_VERTICES = 5;
static const int OBJECT_LAYER = 2;
static const int RECTANGLE_VERTICES = 4;
static const float CAR_OBJECT_HEIGHT = 2.0f;
static const float HALF = 0.5f;

// ego handler constants
static const float GAUSSIAN_DEVIATION = 1.0f;
static const float GAUSSIAN_MEAN = 0.0f;
static const float KPH_RATIO = 3.6f;
static const float KPH_TO_MS = 1.0f / 3.6f;
static const float ORIENTATION_NOISE = 0.001f;
static const float POSITION_NOISE = 0.05f;

#endif