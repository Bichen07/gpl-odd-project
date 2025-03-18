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

class CarFw {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.ecu = null;
      this.subAddress = null;
      this.fwVersion = null;
      this.address = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('ecu')) {
        this.ecu = initObj.ecu
      }
      else {
        this.ecu = 0;
      }
      if (initObj.hasOwnProperty('subAddress')) {
        this.subAddress = initObj.subAddress
      }
      else {
        this.subAddress = 0;
      }
      if (initObj.hasOwnProperty('fwVersion')) {
        this.fwVersion = initObj.fwVersion
      }
      else {
        this.fwVersion = [];
      }
      if (initObj.hasOwnProperty('address')) {
        this.address = initObj.address
      }
      else {
        this.address = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CarFw
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [ecu]
    bufferOffset = _serializer.uint32(obj.ecu, buffer, bufferOffset);
    // Serialize message field [subAddress]
    bufferOffset = _serializer.int64(obj.subAddress, buffer, bufferOffset);
    // Serialize message field [fwVersion]
    bufferOffset = _arraySerializer.string(obj.fwVersion, buffer, bufferOffset, null);
    // Serialize message field [address]
    bufferOffset = _serializer.int64(obj.address, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CarFw
    let len;
    let data = new CarFw(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [ecu]
    data.ecu = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [subAddress]
    data.subAddress = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [fwVersion]
    data.fwVersion = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [address]
    data.address = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.fwVersion.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/CarFw';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '032226e9b604d6d0ae12c42eae70f306';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint32 ecu # enum const: Ecu
    int64 subAddress
    string[] fwVersion
    int64 address
    
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
    const resolved = new CarFw(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.ecu !== undefined) {
      resolved.ecu = msg.ecu;
    }
    else {
      resolved.ecu = 0
    }

    if (msg.subAddress !== undefined) {
      resolved.subAddress = msg.subAddress;
    }
    else {
      resolved.subAddress = 0
    }

    if (msg.fwVersion !== undefined) {
      resolved.fwVersion = msg.fwVersion;
    }
    else {
      resolved.fwVersion = []
    }

    if (msg.address !== undefined) {
      resolved.address = msg.address;
    }
    else {
      resolved.address = 0
    }

    return resolved;
    }
};

module.exports = CarFw;
