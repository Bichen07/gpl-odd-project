#ifndef _MATH_DEF_H_
#define _MATH_DEF_H_

#include <cstdint>
#define STRINGIFY(a) (#a)

typedef char char_t;
typedef float float32_t;
typedef double float64_t;
typedef bool bool_t;

#ifndef TRUE
const bool_t TRUE = 1;
#endif // #ifndef TRUE

#ifndef FALSE
const bool_t FALSE = 0;
#endif // #ifndef FALSE

namespace {
static constexpr char_t NEWLINE = '\n';
}

#endif // #define _MATH_DEF_H_
