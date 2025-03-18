#include <logger_txt_writer.h>
#include <stdexcept>
#include <ros/console.h>

namespace logger {

// public func.

TxtWriter::TxtWriter()
    : mOutputFileStream{}
{
}

TxtWriter::~TxtWriter()
{
    if (mOutputFileStream.is_open())
    {
        mOutputFileStream.flush();
        mOutputFileStream.close();
    }
}

void TxtWriter::Configure(
    const std::string &fileName,
    const int32_t precisionDigits)
{
    mOutputFileStream.open(fileName, std::ofstream::out);
    if (!mOutputFileStream.good())
    {
        ROS_ERROR_STREAM("file stream is not good, file name: " << fileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mOutputFileStream << std::setprecision(precisionDigits) << std::fixed;
}

void TxtWriter::Append(const math::Vector3d_t &vector3d)
{
    mOutputFileStream << vector3d.transpose() << std::endl;
}

void TxtWriter::Append(
    const std::string &tag,
    const math::Vector3d_t &vector3d)
{
    mOutputFileStream << tag << ": " << vector3d.transpose() << std::endl;
}

void TxtWriter::Append(const math::real_t value)
{
    mOutputFileStream << value << std::endl;
}

void TxtWriter::Append(const std::string &text)
{
    mOutputFileStream << text << std::endl;
}

// protected func.

// private func.

} // namespace logger {
