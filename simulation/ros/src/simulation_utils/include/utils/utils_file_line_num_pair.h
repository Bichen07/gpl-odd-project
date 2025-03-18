#ifndef _UTILS_FILE_LINE_NUM_PAIR_H_
#define _UTILS_FILE_LINE_NUM_PAIR_H_

#include <string>
#include <limits>

namespace utils {

#define FileLineNumPairInstance() \
    FileLineNumPair(__FILE__, __LINE__)

struct FileLineNumPair
{
    std::string file;
    uint32_t lineNum;

    FileLineNumPair()
        : file{}
        , lineNum{std::numeric_limits<uint32_t>::max()}
    {
    }
    FileLineNumPair(
        const std::string &inputFile,
        const uint32_t inputLineNum)
        : file{inputFile}
        , lineNum{inputLineNum}
    {
    }
    FileLineNumPair(const FileLineNumPair &other) = default;
    FileLineNumPair &operator=(const FileLineNumPair &other) = default;
    ~FileLineNumPair() = default;
};

bool operator==(const FileLineNumPair &left, const FileLineNumPair &right);
bool IsEmpty(const FileLineNumPair &fileLineNumPair);
std::string OutputMessage(const FileLineNumPair &fileLineNumPair);
void AppendFileLineNumMessage(
    const FileLineNumPair &fileLineNumPair,
    std::string &appendedMessage,
    const FileLineNumPair &defaultFileLineNumPair);

} // namespace utils {

#endif // #ifndef _UTILS_FILE_NAME_LINE_NUM_PAIR_H_
