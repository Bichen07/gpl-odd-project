#ifndef _MAP_BUS_STATION_MANAGER_H_
#define _MAP_BUS_STATION_MANAGER_H_

#include <map_bus_station.h>

namespace map {

class BusStationManager final
{

public:

    BusStationManager();
    BusStationManager(const BusStationManager &) = delete;
    BusStationManager &operator=(const BusStationManager &) = delete;
    virtual ~BusStationManager();

    const std::map<int32_t, BusStation> &GetBusStationMap() const;
    const bool QueryBusStation(
        const int32_t id,
        BusStation *outputBusStation) const;

    void Configure(const std::string &busStationFileName);

protected:

private:

    std::map<int32_t, BusStation> mBusStationMap;
};

} // namespace map {

#endif // #ifndef _MAP_BUS_STATION_MANAGER_H_
