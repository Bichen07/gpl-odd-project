#ifndef _LOGGER_JSON_WRITER_H_
#define _LOGGER_JSON_WRITER_H_

#include <jsoncpp/json/json.h>
#include <math_type.h>
#include <math_frenet_coord.h>

namespace logger {

class JsonWriter final
{

public:

    JsonWriter();
    JsonWriter(const JsonWriter &) = delete;
    JsonWriter &operator=(const JsonWriter &) = delete;
    virtual ~JsonWriter();

    void ConfigureFileName(const std::string &fileName);

    void Append(
        const std::string &id,
        const int32_t intValue);
    void Append(
        const std::string &id,
        const double doubleValue);

    void Append(
        const std::string &id,
        const math::Vector3d_t &vector3d);
    void Append(
        const std::string &id,
        const std::vector<math::Vector3d_t> &vector3ds);
    void Append(
        const std::string &id,
        const math::FrenetCoord &frenetCoord);
    void Append(
        const std::string &id,
        const std::vector<math::FrenetCoord> &frenetCoords);
    void Write();

protected:

private:

    Json::Value GenerateVector3dValue(const math::Vector3d_t &vector3d) const;
    Json::Value GenerateFrenetCoordValue(const math::FrenetCoord &frenetCoord) const;

    Json::Value mOutputJsonValue;
    std::string mFileName;
};

} // namespace logger {

#endif // #ifndef _LOGGER_JSON_WRITER_H_
