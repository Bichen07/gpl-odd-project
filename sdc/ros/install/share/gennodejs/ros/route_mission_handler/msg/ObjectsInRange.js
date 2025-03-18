// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Lanes = require('./Lanes.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ObjectsInRange {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.changed = null;
      this.range = null;
      this.lanes = null;
      this.objects = null;
    }
    else {
      if (initObj.hasOwnProperty('changed')) {
        this.changed = initObj.changed
      }
      else {
        this.changed = false;
      }
      if (initObj.hasOwnProperty('range')) {
        this.range = initObj.range
      }
      else {
        this.range = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('lanes')) {
        this.lanes = initObj.lanes
      }
      else {
        this.lanes = [];
      }
      if (initObj.hasOwnProperty('objects')) {
        this.objects = initObj.objects
      }
      else {
        this.objects = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObjectsInRange
    // Serialize message field [changed]
    bufferOffset = _serializer.bool(obj.changed, buffer, bufferOffset);
    // Serialize message field [range]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.range, buffer, bufferOffset);
    // Serialize message field [lanes]
    // Serialize the length for message field [lanes]
    bufferOffset = _serializer.uint32(obj.lanes.length, buffer, bufferOffset);
    obj.lanes.forEach((val) => {
      bufferOffset = Lanes.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [objects]
    // Serialize the length for message field [objects]
    bufferOffset = _serializer.uint32(obj.objects.length, buffer, bufferOffset);
    obj.objects.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Polygon.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObjectsInRange
    let len;
    let data = new ObjectsInRange(null);
    // Deserialize message field [changed]
    data.changed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [range]
    data.range = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [lanes]
    // Deserialize array length for message field [lanes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lanes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lanes[i] = Lanes.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [objects]
    // Deserialize array length for message field [objects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.objects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.objects[i] = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.Polygon.getMessageSize(object.range);
    object.lanes.forEach((val) => {
      length += Lanes.getMessageSize(val);
    });
    object.objects.forEach((val) => {
      length += geometry_msgs.msg.Polygon.getMessageSize(val);
    });
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/ObjectsInRange';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '23414e3f925d00431df85f0ca877074c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool changed
    geometry_msgs/Polygon range
    route_mission_handler/Lanes[] lanes
    geometry_msgs/Polygon[] objects
    
    ================================================================================
    MSG: geometry_msgs/Polygon
    #A specification of a polygon where the first and last points are assumed to be connected
    Point32[] points
    
    ================================================================================
    MSG: geometry_msgs/Point32
    # This contains the position of a point in free space(with 32 bits of precision).
    # It is recommeded to use Point wherever possible instead of Point32.  
    # 
    # This recommendation is to promote interoperability.  
    #
    # This message is designed to take up less space when sending
    # lots of points at once, as in the case of a PointCloud.  
    
    float32 x
    float32 y
    float32 z
    ================================================================================
    MSG: route_mission_handler/Lanes
    int32 type
    int32 NORMAL=0
    int32 SPLIT_LEFT=1
    int32 SPLIT_RIGHT=2
    int32 MERGE_TO_RIGHT=3
    int32 MERGE_TO_LEFT=4
    int32 TOBE_MERGED=5
    int32 SPLIT_STRAIGHT=6
    
    int32 id
    bool isTurn
    bool direction
    int32 laneno
    int32[] nexts
    int32[] roadLineIds
    Waypoints[] points
    int32 max_speed_limit
    int32 roadType
    
    ================================================================================
    MSG: route_mission_handler/Waypoints
    int32 laneId
    int32 pointId
    float32 roadWidth
    float32 distToRightLine
    float32 distToLeftLine
    float32 right_road_bound
    float32 left_road_bound
    float32 curve
    float32 slope
    float32 bank_angle
    geometry_msgs/Pose pose
    int32[] markerIds
    int32[] markerTypes
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ObjectsInRange(null);
    if (msg.changed !== undefined) {
      resolved.changed = msg.changed;
    }
    else {
      resolved.changed = false
    }

    if (msg.range !== undefined) {
      resolved.range = geometry_msgs.msg.Polygon.Resolve(msg.range)
    }
    else {
      resolved.range = new geometry_msgs.msg.Polygon()
    }

    if (msg.lanes !== undefined) {
      resolved.lanes = new Array(msg.lanes.length);
      for (let i = 0; i < resolved.lanes.length; ++i) {
        resolved.lanes[i] = Lanes.Resolve(msg.lanes[i]);
      }
    }
    else {
      resolved.lanes = []
    }

    if (msg.objects !== undefined) {
      resolved.objects = new Array(msg.objects.length);
      for (let i = 0; i < resolved.objects.length; ++i) {
        resolved.objects[i] = geometry_msgs.msg.Polygon.Resolve(msg.objects[i]);
      }
    }
    else {
      resolved.objects = []
    }

    return resolved;
    }
};

module.exports = ObjectsInRange;
