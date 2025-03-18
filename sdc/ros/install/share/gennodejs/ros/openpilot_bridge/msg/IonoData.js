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

class IonoData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.healthValid = null;
      this.ionoAlpha = null;
      this.tow = null;
      this.gpsWeek = null;
      this.ionoBeta = null;
      this.svHealth = null;
      this.ionoCoeffsValid = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('healthValid')) {
        this.healthValid = initObj.healthValid
      }
      else {
        this.healthValid = false;
      }
      if (initObj.hasOwnProperty('ionoAlpha')) {
        this.ionoAlpha = initObj.ionoAlpha
      }
      else {
        this.ionoAlpha = [];
      }
      if (initObj.hasOwnProperty('tow')) {
        this.tow = initObj.tow
      }
      else {
        this.tow = 0.0;
      }
      if (initObj.hasOwnProperty('gpsWeek')) {
        this.gpsWeek = initObj.gpsWeek
      }
      else {
        this.gpsWeek = 0.0;
      }
      if (initObj.hasOwnProperty('ionoBeta')) {
        this.ionoBeta = initObj.ionoBeta
      }
      else {
        this.ionoBeta = [];
      }
      if (initObj.hasOwnProperty('svHealth')) {
        this.svHealth = initObj.svHealth
      }
      else {
        this.svHealth = 0;
      }
      if (initObj.hasOwnProperty('ionoCoeffsValid')) {
        this.ionoCoeffsValid = initObj.ionoCoeffsValid
      }
      else {
        this.ionoCoeffsValid = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IonoData
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [healthValid]
    bufferOffset = _serializer.bool(obj.healthValid, buffer, bufferOffset);
    // Serialize message field [ionoAlpha]
    bufferOffset = _arraySerializer.float32(obj.ionoAlpha, buffer, bufferOffset, null);
    // Serialize message field [tow]
    bufferOffset = _serializer.float32(obj.tow, buffer, bufferOffset);
    // Serialize message field [gpsWeek]
    bufferOffset = _serializer.float32(obj.gpsWeek, buffer, bufferOffset);
    // Serialize message field [ionoBeta]
    bufferOffset = _arraySerializer.float32(obj.ionoBeta, buffer, bufferOffset, null);
    // Serialize message field [svHealth]
    bufferOffset = _serializer.int64(obj.svHealth, buffer, bufferOffset);
    // Serialize message field [ionoCoeffsValid]
    bufferOffset = _serializer.bool(obj.ionoCoeffsValid, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IonoData
    let len;
    let data = new IonoData(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [healthValid]
    data.healthValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ionoAlpha]
    data.ionoAlpha = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [tow]
    data.tow = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gpsWeek]
    data.gpsWeek = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ionoBeta]
    data.ionoBeta = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [svHealth]
    data.svHealth = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [ionoCoeffsValid]
    data.ionoCoeffsValid = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.ionoAlpha.length;
    length += 4 * object.ionoBeta.length;
    return length + 26;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/IonoData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f905caa2eac71ee3a1208f47a49eafc0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool healthValid
    float32[] ionoAlpha
    float32 tow
    float32 gpsWeek
    float32[] ionoBeta
    int64 svHealth
    bool ionoCoeffsValid
    
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
    const resolved = new IonoData(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.healthValid !== undefined) {
      resolved.healthValid = msg.healthValid;
    }
    else {
      resolved.healthValid = false
    }

    if (msg.ionoAlpha !== undefined) {
      resolved.ionoAlpha = msg.ionoAlpha;
    }
    else {
      resolved.ionoAlpha = []
    }

    if (msg.tow !== undefined) {
      resolved.tow = msg.tow;
    }
    else {
      resolved.tow = 0.0
    }

    if (msg.gpsWeek !== undefined) {
      resolved.gpsWeek = msg.gpsWeek;
    }
    else {
      resolved.gpsWeek = 0.0
    }

    if (msg.ionoBeta !== undefined) {
      resolved.ionoBeta = msg.ionoBeta;
    }
    else {
      resolved.ionoBeta = []
    }

    if (msg.svHealth !== undefined) {
      resolved.svHealth = msg.svHealth;
    }
    else {
      resolved.svHealth = 0
    }

    if (msg.ionoCoeffsValid !== undefined) {
      resolved.ionoCoeffsValid = msg.ionoCoeffsValid;
    }
    else {
      resolved.ionoCoeffsValid = false
    }

    return resolved;
    }
};

module.exports = IonoData;
