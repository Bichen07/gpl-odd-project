// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let NavgRoad = require('./NavgRoad.js');

//-----------------------------------------------------------

class NavgRoadArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.navgroads = null;
    }
    else {
      if (initObj.hasOwnProperty('navgroads')) {
        this.navgroads = initObj.navgroads
      }
      else {
        this.navgroads = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavgRoadArray
    // Serialize message field [navgroads]
    // Serialize the length for message field [navgroads]
    bufferOffset = _serializer.uint32(obj.navgroads.length, buffer, bufferOffset);
    obj.navgroads.forEach((val) => {
      bufferOffset = NavgRoad.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavgRoadArray
    let len;
    let data = new NavgRoadArray(null);
    // Deserialize message field [navgroads]
    // Deserialize array length for message field [navgroads]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.navgroads = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.navgroads[i] = NavgRoad.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.navgroads.forEach((val) => {
      length += NavgRoad.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/NavgRoadArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f4863e0e051c2896d5fc07e0c9811ff2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    NavgRoad[] navgroads
    ================================================================================
    MSG: route_mission_handler/NavgRoad
    int32 ITRI_AREA=5
    int32 EXPRESS_WAY=8
    int32 EXIT_GATEWAY=20
    int32 ENTRY_GATEWAY=21
    
    int32 id
    int32 positiveLaneNum
    int32 negativeLaneNum
    bool twoWay
    int32[] positiveLaneIds
    int32[] negativeLaneIds
    int32 mode
    int32 r_class
    int32 routing
    float32 n_as
    float32 n_kph
    float32 p_as
    float32 p_kph
    float32 length
    ItriPoint[] points
    ConnectedNavgRoad[] heads
    ConnectedNavgRoad[] tails
    int32 type
    
    ================================================================================
    MSG: route_mission_handler/ItriPoint
    int32 id
    int32 belongId
    int32 pointId
    geometry_msgs/Pose pose
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: route_mission_handler/ConnectedNavgRoad
    int32 id
    int32 pointId
    float32 length
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NavgRoadArray(null);
    if (msg.navgroads !== undefined) {
      resolved.navgroads = new Array(msg.navgroads.length);
      for (let i = 0; i < resolved.navgroads.length; ++i) {
        resolved.navgroads[i] = NavgRoad.Resolve(msg.navgroads[i]);
      }
    }
    else {
      resolved.navgroads = []
    }

    return resolved;
    }
};

module.exports = NavgRoadArray;
