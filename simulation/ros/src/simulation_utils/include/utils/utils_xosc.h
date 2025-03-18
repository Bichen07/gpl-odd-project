#ifndef _UTILS_XOSC_H_
#define _UTILS_XOSC_H_

#include <json/json.h>

namespace utils
{
    void        parseCommandLine(const std::string &commandLine, int &argc, char **&argv);
    std::string generateXoscFromTemplate(std::string templateFilepath, Json::Value root);
    std::string getFilenameWithoutExtension(const std::string &filePath);
}  // namespace utils

#endif  // #ifndef _UTILS_XOSC_H_
