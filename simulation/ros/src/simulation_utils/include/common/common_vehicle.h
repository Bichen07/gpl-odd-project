#ifndef _COMMON_VEHICLE_H_
#define _COMMON_VEHICLE_H_

#include <sim_vehicle.h>
#include <Box2D.h>
#include <cstring>
#include <vector>

namespace common {

class CommonVehicle : public Vehicle
{

public:

    CommonVehicle(
        const std::string & id, b2Vec2 & position, float orientation, 
        b2Vec3 & size, b2World & world, bool isEgo, uint64_t uniqueId);
    CommonVehicle(
        const std::string & id, b2Vec2 & position, float orientation, 
        b2Vec3 & size, b2World & world, bool isEgo);
    CommonVehicle(const CommonVehicle &) = delete;
    CommonVehicle &operator=(const CommonVehicle &) = delete;

protected:

private:
};

} // namespace common {

#endif // #ifndef _COMMON_VEHICLE_H_
