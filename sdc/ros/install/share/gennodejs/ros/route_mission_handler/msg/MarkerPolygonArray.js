// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let MarkerPolygon = require('./MarkerPolygon.js');

//-----------------------------------------------------------

class MarkerPolygonArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.markers = null;
    }
    else {
      if (initObj.hasOwnProperty('markers')) {
        this.markers = initObj.markers
      }
      else {
        this.markers = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MarkerPolygonArray
    // Serialize message field [markers]
    // Serialize the length for message field [markers]
    bufferOffset = _serializer.uint32(obj.markers.length, buffer, bufferOffset);
    obj.markers.forEach((val) => {
      bufferOffset = MarkerPolygon.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MarkerPolygonArray
    let len;
    let data = new MarkerPolygonArray(null);
    // Deserialize message field [markers]
    // Deserialize array length for message field [markers]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.markers = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.markers[i] = MarkerPolygon.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.markers.forEach((val) => {
      length += MarkerPolygon.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/MarkerPolygonArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '19ddbcf9494b79bc31ba9be72cf01eee';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    MarkerPolygon[] markers
    ================================================================================
    MSG: route_mission_handler/MarkerPolygon
    int32 id
    int32 type
    int32 navgId
    Pair[] pairs
    geometry_msgs/Point center_point
    geometry_msgs/Point[] corner_points
    bool on
    string value
    
    ================================================================================
    MSG: route_mission_handler/Pair
    int32 laneId
    int32[] pointIds
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MarkerPolygonArray(null);
    if (msg.markers !== undefined) {
      resolved.markers = new Array(msg.markers.length);
      for (let i = 0; i < resolved.markers.length; ++i) {
        resolved.markers[i] = MarkerPolygon.Resolve(msg.markers[i]);
      }
    }
    else {
      resolved.markers = []
    }

    return resolved;
    }
};

module.exports = MarkerPolygonArray;
