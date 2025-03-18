#include <json/json.h>
#include <utils_xosc.h>
#include <string>
#include <sstream>
#include <fstream>
#include <iostream>
#include <boost/uuid/uuid.hpp>             // uuid class
#include <boost/uuid/uuid_generators.hpp>  // generators
#include <boost/uuid/uuid_io.hpp>          // streaming operators etc.
#include <regex>

namespace utils
{
    void parseCommandLine(const std::string &commandLine, int &argc, char **&argv)
    {
        std::istringstream       iss(commandLine);
        std::vector<std::string> args;

        // Tokenize the input string
        std::string token;
        while (iss >> token)
        {
            args.push_back(token);
        }

        // Set argc
        argc = static_cast<int>(args.size());

        // Allocate memory for argv
        argv = new char *[argc];

        // Copy each argument to allocated memory
        for (int i = 0; i < argc; ++i)
        {
            argv[i] = new char[args[i].size() + 1];  // +1 for the null terminator
            std::strcpy(argv[i], args[i].c_str());
        }
    }

    std::string getFilenameWithoutExtension(const std::string &filePath)
    {
        size_t lastSlash = filePath.find_last_of("/\\");
        size_t lastDot   = filePath.find_last_of(".");

        if (lastSlash != std::string::npos && lastDot != std::string::npos && lastDot > lastSlash)
        {
            return filePath.substr(lastSlash + 1, lastDot - lastSlash - 1);
        }

        // If no path separator or dot is found, or the dot is before the last path separator, return the original string
        return filePath;
    }

    std::string removeSubstring(const std::string &originalString, const std::string &substringToRemove)
    {
        // Find the position of the substring
        size_t pos = originalString.find(substringToRemove);

        // Check if the substring is found
        if (pos != std::string::npos)
        {
            // Create a new string by concatenating the parts before and after the
            // substring
            return originalString.substr(0, pos) + originalString.substr(pos + substringToRemove.length());
        }
        else
        {
            // If substring not found, return the original string
            return originalString;
        }
    }

    std::string generateXoscFromTemplate(std::string templateFilepath, Json::Value root)
    {
        static boost::uuids::random_generator generator;

        Json::StreamWriterBuilder writer;
        std::string               jsonString = Json::writeString(writer, root);

        boost::uuids::uuid uuid = generator();
        std::ostringstream uuidOss;
        uuidOss << uuid;
        std::string   inputJsonFilePath = "/tmp/xosc_parameters_" + uuidOss.str() + ".json";
        std::ofstream inputJsonFile(inputJsonFilePath);
        if (inputJsonFile.is_open())
        {
            inputJsonFile << jsonString;
            inputJsonFile.close();
            std::cout << "JSON written to file successfully.\n";
        }
        else
        {
            std::cerr << "Unable to open the file for writing.\n";
        }

        std::string searchString      = "_TEMPLATE";
        std::string replacementString = "_" + uuidOss.str();
        std::regex  pattern(searchString);
        std::string outputFilepath = std::regex_replace(templateFilepath, pattern, replacementString);

        std::string command;
        command += "python3 "
                   "/project/mmsl_simulation/src/scenario/scripts/xosc_modifier.py ";
        command += "--input " + inputJsonFilePath + " ";
        command += "--template " + templateFilepath + " ";
        command += "--output " + (outputFilepath.empty() ? templateFilepath : outputFilepath);
        std::cout << command;
        int result = system(command.c_str());

        if (result != 0)
        {
            throw std::runtime_error("Failed to modify xosc file");
        }

        std::remove(inputJsonFilePath.c_str());

        return outputFilepath;
    }

}  // namespace utils
