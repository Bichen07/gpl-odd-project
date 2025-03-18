#include "utils_empty_container_exception.h"

namespace utils {

// public func.

EmptyContainerException::EmptyContainerException(const std::string &key)
    : std::exception()
    , mIdentification(std::string("empty container: ") + key)
{
}

const char *EmptyContainerException::what() const noexcept
{
    return mIdentification.c_str();
}

// protected func.

// private func.

} // namespace utils {
