#ifndef _UTILS_FACTORY_H_
#define _UTILS_FACTORY_H_

#include <type_traits>
#include <utility>
#include "boost/functional/factory.hpp"
#include "boost/container/flat_map.hpp"
#include "boost/function.hpp"
#include "boost/bind.hpp"

namespace utils {

template<class AbstractClass,
    class IdType = size_t,
    class MakeType = boost::function< typename std::remove_pointer<AbstractClass>::type*()>
    >
class Factory
{
    using abstract_type = typename std::remove_pointer<AbstractClass>::type;
    boost::container::flat_map<IdType, MakeType> factory_map;

public:

    void register_factory(IdType type_id, const MakeType& make)
    {
        factory_map.insert(std::make_pair(type_id,make));
    }

    template<class ...args>
    abstract_type* create(IdType id)const
    {
        auto it = factory_map.find(id);
        if (it != factory_map.end())
        {
            return it->second();
        }

        return nullptr;
    }

    template<class ...args>
    abstract_type* create(IdType id, args&&... a)const
    {
        auto it = factory_map.find(id);
        if (it != factory_map.end())
        {
            return it->second(std::forward<args>(a)...);
        }

        return nullptr;
    }
};

} // namespace utils {

#endif // #ifndef _UTILS_FACTORY_H_
