#include <utils_invalid_key_exception.h>

namespace utils {

// public func.

InvalidKeyException::InvalidKeyException(const std::string &key)
    : std::exception()
    , mIdentification(std::string("invalid key: ") + key)
{
}

const char *InvalidKeyException::what() const noexcept
{
    return mIdentification.c_str();
}

// protected func.

// private func.

} // namespace utils {
