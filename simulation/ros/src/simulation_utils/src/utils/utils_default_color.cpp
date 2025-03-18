#include <utils_default_color.h>

namespace utils {

std_msgs::ColorRGBA White(const float alpha)
{
    static std_msgs::ColorRGBA whileColor;
    whileColor.r = 1.0f;
    whileColor.g = 1.0f;
    whileColor.b = 1.0f;
    whileColor.a = alpha;
        
    return whileColor;
}

std_msgs::ColorRGBA Black(const float alpha)
{
    static std_msgs::ColorRGBA blackColor;
    blackColor.r = 0.0f;
    blackColor.g = 0.0f;
    blackColor.b = 0.0f;
    blackColor.a = alpha;

    return blackColor;
}

std_msgs::ColorRGBA Gray(const float alpha)
{
    static std_msgs::ColorRGBA grayColor;
    grayColor.r = 0.5f;
    grayColor.g = 0.5f;
    grayColor.b = 0.5f;
    grayColor.a = 0.5f;

    return grayColor;
}

std_msgs::ColorRGBA Red(const float alpha)
{
    static std_msgs::ColorRGBA redColor;
    redColor.r = 1.0f;
    redColor.g = 0.0f;
    redColor.b = 0.0f;
    redColor.a = alpha;

    return redColor;
}

std_msgs::ColorRGBA Green(const float alpha)
{
    static std_msgs::ColorRGBA greenColor;
    greenColor.r = 0.0f;
    greenColor.g = 1.0f;
    greenColor.b = 0.0f;
    greenColor.a = alpha;

    return greenColor;
}

std_msgs::ColorRGBA Blue(const float alpha)
{
    static std_msgs::ColorRGBA blueColor;
    blueColor.r = 0.0f;
    blueColor.g = 0.0f;
    blueColor.b = 1.0f;
    blueColor.a = alpha;

    return blueColor;
}

std_msgs::ColorRGBA Cyan(const float alpha)
{
    static std_msgs::ColorRGBA cyanColor;
    cyanColor.r = 0.0f;
    cyanColor.g = 1.0f;
    cyanColor.b = 1.0f;
    cyanColor.a = alpha;

    return cyanColor;
}

std_msgs::ColorRGBA Magenta(const float alpha)
{
    static std_msgs::ColorRGBA magentaColor;
    magentaColor.r = 1.0f;
    magentaColor.g = 0.0f;
    magentaColor.b = 1.0f;
    magentaColor.a = alpha;

    return magentaColor;
}

std_msgs::ColorRGBA Yellow(const float alpha)
{
    static std_msgs::ColorRGBA yellowColor;
    yellowColor.r = 1.0f;
    yellowColor.g = 1.0f;
    yellowColor.b = 0.0f;
    yellowColor.a = alpha;

    return yellowColor;
}

std_msgs::ColorRGBA Purple(const float alpha)
{
    static std_msgs::ColorRGBA purpleColor;
    purpleColor.r = 0.5f;
    purpleColor.g = 0.0f;
    purpleColor.b = 0.5f;
    purpleColor.a = alpha;

    return purpleColor;
}

std_msgs::ColorRGBA Tomato(const float alpha)
{
    static std_msgs::ColorRGBA tomatoColor;
    tomatoColor.r = 1.0f;
    tomatoColor.g = 0.38672f;
    tomatoColor.b = 0.27734f;
    tomatoColor.a = alpha;

    return tomatoColor;
}

std_msgs::ColorRGBA Lime(const float alpha)
{
    static std_msgs::ColorRGBA limeColor;
    limeColor.r = 0.74609f;
    limeColor.g = 1.0f;
    limeColor.b = 0.0f;
    limeColor.a = alpha;

    return limeColor;
}

std_msgs::ColorRGBA Brown(const float alpha)
{
    static std_msgs::ColorRGBA brownColor;
    brownColor.r = 0.58593f;
    brownColor.g = 0.29297f;
    brownColor.b = 0.0f;
    brownColor.a = alpha;

    return brownColor;
}

std_msgs::ColorRGBA Teal(const float alpha)
{
    static std_msgs::ColorRGBA tealColor;
    tealColor.r = 0.0f;
    tealColor.g = 0.5f;
    tealColor.b = 0.5f;
    tealColor.a = alpha;

    return tealColor;
}

std_msgs::ColorRGBA OrangeRed(const float alpha)
{
    static std_msgs::ColorRGBA orangeRedColor;
    orangeRedColor.r = 1.0f;
    orangeRedColor.g = 0.271f;
    orangeRedColor.b = 0.0f;
    orangeRedColor.a = alpha;

    return orangeRedColor;
}

std_msgs::ColorRGBA DarkOrange(const float alpha)
{
    static std_msgs::ColorRGBA darkOrangeColor;
    darkOrangeColor.r = 1.0f;
    darkOrangeColor.g = 0.549f;
    darkOrangeColor.b = 0.0f;
    darkOrangeColor.a = alpha;

    return darkOrangeColor;
}

std_msgs::ColorRGBA DarkRed(const float alpha)
{
    static std_msgs::ColorRGBA darkRedColor;
    darkRedColor.r = 0.545f;
    darkRedColor.g = 0.0f;
    darkRedColor.b = 0.0f;
    darkRedColor.a = alpha;

    return darkRedColor;
}

std_msgs::ColorRGBA BlueViolet(const float alpha)
{
    static std_msgs::ColorRGBA blueViolet;
    blueViolet.r = 0.541f;
    blueViolet.g = 0.169f;
    blueViolet.b = 0.886f;
    blueViolet.a = alpha;

    return blueViolet;
}

} // namespace utils {
