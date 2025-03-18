from bs4 import BeautifulSoup
import json
import argparse

parser = argparse.ArgumentParser(description='modify xosc by json file')

# Add arguments
parser.add_argument('--input', help='Path to the input json file')
parser.add_argument(
    '--output', '-o', help='Path to the output modified xosc file')
parser.add_argument('--template', help='Path to the xosc template file')

# Parse the command-line arguments
args = parser.parse_args()

# Access the values of the arguments
input_file: str = args.input
output_file: str = args.output
template_file: str = args.template

with open(template_file, "r", encoding="utf-8") as file:
    xml_content = file.read()

with open(input_file) as file:
    root = json.load(file)

# Create a BeautifulSoup object from the existing XML content
soup = BeautifulSoup(xml_content, "xml")

parameter_declarations = soup.find_all("ParameterDeclaration")
for parameter_declaration in parameter_declarations:
    name = parameter_declaration["name"]
    if name in root["parameters"]:
        parameter_declaration["value"] = root["parameters"][name]

if "ego_init_position" in root:
    ego = soup.find("Private", {"entityRef": "Ego"})
    original_position = ego.find("Position")

    new_position = soup.new_tag('Position')

    position_tag_name = list(root["ego_init_position"].keys())[0]
    position_tag = soup.new_tag(position_tag_name)
    for attribute, value in root["ego_init_position"][position_tag_name].items():
        position_tag[attribute] = value
    new_position.append(position_tag)

    original_position.replace_with(new_position)


with open(output_file, "w") as file:
    file.write(str(soup.prettify()))
