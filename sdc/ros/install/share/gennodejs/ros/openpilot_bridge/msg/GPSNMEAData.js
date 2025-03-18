// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class GPSNMEAData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.timestamp = null;
      this.nmea = null;
      this.localWallTime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0;
      }
      if (initObj.hasOwnProperty('nmea')) {
        this.nmea = initObj.nmea
      }
      else {
        this.nmea = [];
      }
      if (initObj.hasOwnProperty('localWallTime')) {
        this.localWallTime = initObj.localWallTime
      }
      else {
        this.localWallTime = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GPSNMEAData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.int32(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [nmea]
    bufferOffset = _arraySerializer.string(obj.nmea, buffer, bufferOffset, null);
    // Serialize message field [localWallTime]
    bufferOffset = _serializer.int64(obj.localWallTime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GPSNMEAData
    let len;
    let data = new GPSNMEAData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nmea]
    data.nmea = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [localWallTime]
    data.localWallTime = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.nmea.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/GPSNMEAData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '473a7724942a495946b6258948b21149';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int32 timestamp
    string[] nmea
    int64 localWallTime
    
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
    const resolved = new GPSNMEAData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0
    }

    if (msg.nmea !== undefined) {
      resolved.nmea = msg.nmea;
    }
    else {
      resolved.nmea = []
    }

    if (msg.localWallTime !== undefined) {
      resolved.localWallTime = msg.localWallTime;
    }
    else {
      resolved.localWallTime = 0
    }

    return resolved;
    }
};

module.exports = GPSNMEAData;
