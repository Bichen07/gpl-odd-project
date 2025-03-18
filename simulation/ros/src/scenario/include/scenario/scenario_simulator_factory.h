#ifndef _SCENARIO_SIMULATOR_FACTORY_H_
#define _SCENARIO_SIMULATOR_FACTORY_H_

#include <memory>
#include <map>
#include <utils_factory.h>
#include <scenario_simulator.h>

namespace scenario {

template<typename TypeId>
class SimulatorFactory final
{

public:

    SimulatorFactory();
    SimulatorFactory(const SimulatorFactory &) = delete;
    SimulatorFactory &operator=(const SimulatorFactory &) = delete;
    virtual ~SimulatorFactory();

    Simulator *CreateRawPtr(const TypeId &id);

    void Register(const TypeId &id, boost::function<Simulator *()> make);
    void Register(const std::map<TypeId, boost::function<Simulator *()>> &registerMap);

protected:

private:

    using RawPtrFactory_t = utils::Factory<Simulator *, TypeId, boost::function<Simulator *()>>;

    RawPtrFactory_t mRawPtrFactory;
};

template<typename TypeId>
SimulatorFactory<TypeId>::SimulatorFactory()
    : mRawPtrFactory{}
{
}

template<typename TypeId>
SimulatorFactory<TypeId>::~SimulatorFactory()
{
}

template<typename TypeId>
Simulator *SimulatorFactory<TypeId>::CreateRawPtr(const TypeId &id)
{
    return mRawPtrFactory.create(id);
}

template<typename TypeId>
void SimulatorFactory<TypeId>::Register(const TypeId &id, boost::function<Simulator *()> make)
{
    mRawPtrFactory.register_factory(id, make);
}

template<typename TypeId>
void SimulatorFactory<TypeId>::Register(const std::map<TypeId, boost::function<Simulator *()>> &registerMap)
{
    for (auto registerPair{registerMap.cbegin()};
         registerPair != registerMap.cend();
         ++registerPair)
    {
        mRawPtrFactory.register_factory(registerPair->first, registerPair->second);
    }
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_SIMULATOR_FACTORY_H_
