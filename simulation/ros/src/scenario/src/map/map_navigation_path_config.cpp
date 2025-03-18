#include <map_navigation_path_config.h>

namespace map {

bool operator<(const NavigationPathConfig &lhs, const NavigationPathConfig &rhs)
{
    return std::string(lhs.map + lhs.route) < std::string(rhs.map + rhs.route);
}

} // namespace map {
