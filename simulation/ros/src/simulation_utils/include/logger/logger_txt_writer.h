#ifndef _LOGGER_TXT_WRITER_H_
#define _LOGGER_TXT_WRITER_H_

#include <fstream>
#include <string>
#include <math_type.h>

namespace logger {

class TxtWriter final
{

public:

    static constexpr int32_t DefaultPrecisionDigits()
    {return 6;}

    TxtWriter();
    TxtWriter(const TxtWriter &) = delete;
    TxtWriter &operator=(const TxtWriter &) = delete;
    virtual ~TxtWriter();

    void Configure(
        const std::string &fileName,
        const int32_t precisionDigits = DefaultPrecisionDigits());

    void Append(const math::Vector3d_t &vector3d);
    void Append(
        const std::string &tag,
        const math::Vector3d_t &vector3d);
    void Append(const math::real_t value);
    void Append(const std::string &text);

protected:

private:

    std::ofstream mOutputFileStream;
};

} // namespace logger {

#endif // #ifndef _LOGGER_TXT_WRITER_H_
