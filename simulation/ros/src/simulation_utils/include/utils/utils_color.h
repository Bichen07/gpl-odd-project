#ifndef _utils_color_h_
#define _UTILS_COLOR_H_

#include <std_msgs/ColorRGBA.h>

namespace utils {

std_msgs::ColorRGBA ComputeComplementaryColor(const std_msgs::ColorRGBA &inputColor);

} // namespace utils {

#endif // #ifndef _utils_color_h_
