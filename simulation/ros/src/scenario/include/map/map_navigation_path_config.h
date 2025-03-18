#ifndef _MAP_NAVIGATION_PATH_CONFIG_H_
#define _MAP_NAVIGATION_PATH_CONFIG_H_

#include <string>
#include <iostream>

namespace map {

struct NavigationPathConfig final
{
    std::string map;
    std::string route;

    NavigationPathConfig()
        : map{}
        , route{}
    {
    }
    explicit NavigationPathConfig(
        const std::string &inputMap,
        const std::string &inputRoute)
        : map{inputMap}
        , route{inputRoute}
    {
    }

    NavigationPathConfig(const NavigationPathConfig &) = default;
    NavigationPathConfig &operator=(const NavigationPathConfig &) = default;
    ~NavigationPathConfig() = default;
};

bool operator<(const NavigationPathConfig &lhs, const NavigationPathConfig &rhs);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const NavigationPathConfig &config)
{
    ostream << "[NavigationPathConfig]" << '\n' <<
        "map: " << config.map << '\n' <<
        "route: " << config.route;
    return ostream;
}

} // namespace map {

#endif // #ifndef _MAP_NAVIGATION_PATH_CONFIG_H_
