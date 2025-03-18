import xml.etree.ElementTree as ET
import numpy as np
import rospkg
import copy

rospack = rospkg.RosPack()
save_file_path = "/".join((
    rospack.get_path("sumo_cosimulation"), 
    "data", 
    "III_itri_v7", 
    "flows.xml"))
load_file_path = save_file_path + ".origin"
print("File path: {}".format(load_file_path))

tree = ET.parse(load_file_path)


settings = {
    "1_veh_to_n": 16,
}

attrib_settings = {
    "maxSpeed":{
        "cat": "general",
        "type": "rand",
        "config":{
            "car": [12., 28.],
            "motorcycle": [12., 28.],
            "bicycle": [7, 9]
        }
    },
    "carFollowModel": { 
        "cat": "CarFollowModel",
        "type": "string",
        "config":{
            "all": [
                "Krauss" , 
                "ACC" , 
                "CACC",
                "PWagner2009", 
                "IDM", "IDMM", 
                "Wiedemann", 
                "W99"
                # "smartSk"
                # Known not working @ #7e9e46 "SmartSK", 
            ]}
        },
    "minGap": { 
        "cat": "CarFollowModel",
        "type": "rand",
        "config":{
            "car": (2.8, 3.5),
            "motorcycle": (1.6, 2.1),
            "bicycle": (1.0, 3.5)}
        },
    "latAlignment": {
        "cat": "SublaneModel",
        "type": "string",
        "config":{
            "all": [
                "left", "right", "center", "nice", "arbitrary"
            ]}
        },
    "minGapLat": {
        "cat": "SublaneModel",
        "type": "rand",
        "config":{
            "car": (0.7, 1.0),
            "motorcycle": (0.2, 0.5),
            "bicycle": (0.15, 0.5)}
        },
    "lcSpeedGain":{
        "cat": "LaneChangeModel",
        "type": "rand",
        "config":{
            "all": (1., 50.)}
        },
    "lcKeepRight":{
        "cat": "LaneChangeModel",
        "type": "rand",
        "config":{
            "all": (1., 50.)}
        },
    "lcOvertakeRight":{
        "cat": "LaneChangeModel",
        "type": "rand",
        "config":{
            "all": (0., 0.1)}
        },
    "lcOpposite":{
        "cat": "LaneChangeModel",
        "type": "rand",
        "config":{
            "all": (1., 50.)}
        }
}

def modify(vType, vClass, probability):
    probability = abs(np.random.normal(probability, probability/5.))
    for key, value in attrib_settings.items():
        assign_type = value["type"]
        options = value["config"].get("all") or value["config"].get(vClass)
        assert options, "No options for key {} and vClass {}"\
            "".format(key, vClass)
        if assign_type == "string":
            altered_value = np.random.choice(options)
        elif assign_type == "rand":
            lower, upper = options[0], options[1]
            altered_value = np.random.rand() * (upper - lower) + lower
            altered_value = "{:.2f}".format(altered_value)
        else:
            assert False, "Unrecognized assign_type {}".format(assign_type)
        vType.attrib[key] = altered_value

    vType.attrib["probability"] = "{:.5f}".format(probability)
    vType.attrib["length"] = "{:.5f}".format(
        abs(np.random.normal(float(vType.attrib["length"]), 
                             float(vType.attrib["length"])/20.)))
    vType.attrib["width"] = "{:.5f}".format(
        abs(np.random.normal(float(vType.attrib["width"]), 
                             float(vType.attrib["width"])/20.)))
    vType.attrib["height"] = "{:.5f}".format(
        abs(np.random.normal(float(vType.attrib["height"]), 
                             float(vType.attrib["height"])/20.)))


vTypeDistributions = tree.findall("vTypeDistribution")
for vTypeDist in vTypeDistributions:
    vClass = vTypeDist.attrib["id"].replace("TypeDistribution", "")
    for vType in vTypeDist.findall(".//vType"):
        probability = float(vType.attrib["probability"])    \
            / settings["1_veh_to_n"]
        if "pacifica" not in vType.attrib["id"]:
            modify(vType, vClass, probability)
        for n_vtype in range(settings["1_veh_to_n"]-1):
            new_vtype = copy.deepcopy(vType)
            new_vtype.attrib["id"] += "-{}".format(n_vtype+1)
            modify(new_vtype, vClass, probability)
            vTypeDist.append(new_vtype)

# ET.dump(tree)
tree.write(save_file_path)

        

