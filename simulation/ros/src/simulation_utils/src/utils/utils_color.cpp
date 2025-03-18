#include <utils_color.h>

namespace utils {

std_msgs::ColorRGBA ComputeComplementaryColor(const std_msgs::ColorRGBA &inputColor)
{
    std_msgs::ColorRGBA outputColor;
    outputColor.r = 1.0f - inputColor.r;
    outputColor.g = 1.0f - inputColor.g;
    outputColor.b = 1.0f - inputColor.b;
    outputColor.a = inputColor.a;

    return outputColor;
}

} // namespace utils {
