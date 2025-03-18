// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Route_info {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.road_w = null;
      this.road_r = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('road_w')) {
        this.road_w = initObj.road_w
      }
      else {
        this.road_w = [];
      }
      if (initObj.hasOwnProperty('road_r')) {
        this.road_r = initObj.road_r
      }
      else {
        this.road_r = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Route_info
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [road_w]
    bufferOffset = _arraySerializer.float64(obj.road_w, buffer, bufferOffset, null);
    // Serialize message field [road_r]
    bufferOffset = _arraySerializer.float64(obj.road_r, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Route_info
    let len;
    let data = new Route_info(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [road_w]
    data.road_w = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [road_r]
    data.road_r = _arrayDeserializer.float64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 8 * object.road_w.length;
    length += 8 * object.road_r.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/Route_info';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f3f43d9100d2d837ee1ce84b99daa0aa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float64[] road_w
    float64[] road_r
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Route_info(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.road_w !== undefined) {
      resolved.road_w = msg.road_w;
    }
    else {
      resolved.road_w = []
    }

    if (msg.road_r !== undefined) {
      resolved.road_r = msg.road_r;
    }
    else {
      resolved.road_r = []
    }

    return resolved;
    }
};

module.exports = Route_info;
