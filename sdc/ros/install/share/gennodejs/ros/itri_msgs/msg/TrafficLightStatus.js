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

class TrafficLightStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficLightStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficLightStatus
    let len;
    let data = new TrafficLightStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/TrafficLightStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e50a875585f97d23b2d45a1f01d9e6d9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint8 RED = 1
    uint8 GREEN = 2
    uint8 YELLOW = 3
    uint8 STRAIGHT = 4
    uint8 RED_LEFT = 5
    uint8 RED_RIGHT = 6
    uint8 RED_LEFT_RIGHT = 7
    uint8 STRAIGHT_LEFT = 8
    uint8 STRAIGHT_RIGHT = 9
    uint8 STRAIGHT_LEFT_RIGHT = 10
    uint8 LEFT = 11
    uint8 RIGHT = 12
    uint8 LEFT_RIGHT = 13
    uint8 FLASH_RED = 14
    uint8 FLASH_YELLOW = 15
    
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
    const resolved = new TrafficLightStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    return resolved;
    }
};

// Constants for message
TrafficLightStatus.Constants = {
  RED: 1,
  GREEN: 2,
  YELLOW: 3,
  STRAIGHT: 4,
  RED_LEFT: 5,
  RED_RIGHT: 6,
  RED_LEFT_RIGHT: 7,
  STRAIGHT_LEFT: 8,
  STRAIGHT_RIGHT: 9,
  STRAIGHT_LEFT_RIGHT: 10,
  LEFT: 11,
  RIGHT: 12,
  LEFT_RIGHT: 13,
  FLASH_RED: 14,
  FLASH_YELLOW: 15,
}

module.exports = TrafficLightStatus;
