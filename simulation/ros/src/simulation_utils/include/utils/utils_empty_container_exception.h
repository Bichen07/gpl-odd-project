#ifndef _UTILS_EMPTY_CONTAINER_EXCEPTION_H_
#define _UTILS_EMPTY_CONTAINER_EXCEPTION_H_

#include <string>
#include <exception>

namespace utils {

class EmptyContainerException : public std::exception
{

public:

    EmptyContainerException(const std::string &key);
    virtual ~EmptyContainerException() = default;

    virtual const char *what() const noexcept override;

protected:

private:

    std::string mIdentification;
};

} // namespace utils {

#endif // #ifndef _UTILS_CONTAINER_EMPTY_EXCEPTION_H_
