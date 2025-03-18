#include <utils_file_line_num_pair.h>

namespace utils {

bool operator==(const FileLineNumPair &left, const FileLineNumPair &right)
{
    return left.file == right.file && left.lineNum == right.lineNum;
}

bool IsEmpty(const FileLineNumPair &fileLineNumPair)
{
    return fileLineNumPair == utils::FileLineNumPair();
}

std::string OutputMessage(const FileLineNumPair &fileLineNumPair)
{
    return " at " + fileLineNumPair.file + ": " + std::to_string(fileLineNumPair.lineNum);
}

void AppendFileLineNumMessage(
    const FileLineNumPair &fileLineNumPair,
    std::string &appendedMessage,
    const FileLineNumPair &defaultFileLineNumPair)
{
    if (utils::IsEmpty(fileLineNumPair))
    {
        appendedMessage += utils::OutputMessage(defaultFileLineNumPair);
    }
    else
    {
        appendedMessage += utils::OutputMessage(fileLineNumPair);
    }
}

} // namespace utils {
