#ifndef _UTILS_INVALID_KEY_EXCEPTION_H_
#define _UTILS_INVALID_KEY_EXCEPTION_H_

#include <string>
#include <exception>

namespace utils {

class InvalidKeyException : public std::exception
{

public:

    InvalidKeyException(const std::string &key);
    virtual ~InvalidKeyException() = default;

    virtual const char* what() const noexcept override;

protected:

private:

    std::string mIdentification;
};

} // namespace utils {

#endif // #ifndef _UTILS_INVALID_KEY_EXCEPTION_H_
