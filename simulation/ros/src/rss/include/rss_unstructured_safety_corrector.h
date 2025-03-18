#ifndef _RSS_UNSTRUCTURED_SAFETY_CORRECTOR_H_
#define _RSS_UNSTRUCTURED_SAFETY_CORRECTOR_H_

#include <rss_check_result.h>

namespace rss {

class UnstructuredSafetyCorrector final
{

public:

    UnstructuredSafetyCorrector();
    UnstructuredSafetyCorrector(const UnstructuredSafetyCorrector &) = delete;
    UnstructuredSafetyCorrector &operator=(const UnstructuredSafetyCorrector &) = delete;
    virtual ~UnstructuredSafetyCorrector() = default;

    bool Execute(CheckResult &checkResult);

protected:

private:

};

} // namespace rss {

#endif // #ifndef _RSS_UNSTRUCTURED_SAFETY_CORRECTOR_H_
