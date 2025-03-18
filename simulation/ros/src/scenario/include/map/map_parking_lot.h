#ifndef _MAP_PARKING_LOT_H_
#define _MAP_PARKING_LOT_H_

#include <map_parking_space.h>

namespace map {

struct ParkingLot final
{
    int32_t id;
    std::vector<ParkingSpace> parkingSpaces;

    ParkingLot()
        : id{0}
        , parkingSpaces{}
    {
    }
    ParkingLot(
        const int32_t inputId,
        const std::vector<ParkingSpace> &inputParkingSpaces)
        : id{inputId}
        , parkingSpaces{inputParkingSpaces}
    {
    }
    ParkingLot(const ParkingLot &other) = default;
    ParkingLot &operator=(const ParkingLot &other) = default;
    ~ParkingLot() = default;
};

} // namespace map {

#endif // #ifndef _MAP_PARKING_LOT_H_
