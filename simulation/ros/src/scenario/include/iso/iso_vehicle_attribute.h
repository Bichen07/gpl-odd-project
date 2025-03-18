#ifndef _ISO_VEHICLE_ATTRIBUTE_H_
#define _ISO_VEHICLE_ATTRIBUTE_H_

#include <math_type.h>

namespace iso {

struct VehicleAttribute final
{
    math::Vector3d_t size;

    VehicleAttribute()
        : size{}
    {
    }
    explicit VehicleAttribute(const math::Vector3d_t &inputSize)
        : size{inputSize}
    {
    }
    VehicleAttribute(const VehicleAttribute &other) = default;
    VehicleAttribute &operator=(const VehicleAttribute &other) = default;
    ~VehicleAttribute() = default;
};

} // namespace iso {

#endif // #ifndef _ISO_VEHICLE_ATTRIBUTE_H_
