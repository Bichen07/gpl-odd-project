#ifndef _MAP_PARKING_SPACE_MANAGER_H_
#define _MAP_PARKING_SPACE_MANAGER_H_

#include <string>
#include <map>
#include <map_parking_lot.h>

namespace map {

class ParkingSpaceManager final
{
    static constexpr const char *DefaultParsingTag()
    {return "parking_space";}

public:

    ParkingSpaceManager();
    ParkingSpaceManager(const ParkingSpaceManager &) = delete;
    ParkingSpaceManager &operator=(const ParkingSpaceManager &) = delete;
    virtual ~ParkingSpaceManager();

    const std::map<int32_t, ParkingLot> &GetParkingLotMap() const;
    const ParkingLot QueryParkingLot(const int32_t parkingLotId) const;

    void Configure(
        const std::string &parkingSpaceFileName,
        const std::string &parsingTag = DefaultParsingTag());

protected:

private:

    std::map<int32_t, ParkingLot> mParkingLotMap;
};

} // namespace map {

#endif // #ifndef _MAP_PARKING_SPACE_MANAGER_H_
