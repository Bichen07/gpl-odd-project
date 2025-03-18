#ifndef __SIM_ODE_23_H__
#define __SIM_ODE_23_H__

#include <iostream>
#include <jsoncpp/json/json.h>
#include <string>
#include <vector>

class ODE23
{
public:
    ODE23(const Json::Value & modelParam, const float stepSize);
    float OneStep(const float input);
    void ResetState();

private:
    float mStepSize;
    std::vector<float> mState;
    std::vector<float> mNumerator;
    std::vector<float> mDenominator;
};

#endif // __SIM_ODE_23_H__
