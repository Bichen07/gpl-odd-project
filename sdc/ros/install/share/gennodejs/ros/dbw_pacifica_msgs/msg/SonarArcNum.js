// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SonarArcNum {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.status = null;
    }
    else {
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SonarArcNum
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SonarArcNum
    let len;
    let data = new SonarArcNum(null);
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/SonarArcNum';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '06cc406551462e830a15f0d81395d2f4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 status
    
    # Unitless - based on bars on display
    uint8 NO_DISTANCE = 0
    uint8 ARC1 = 1
    uint8 ARC2 = 2
    uint8 ARC3 = 3
    uint8 ARC4 = 4
    uint8 ARC5 = 5
    uint8 ARC6 = 6
    uint8 ARC7 = 7
    uint8 ARC8 = 8
    uint8 NO_ARC = 15
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SonarArcNum(null);
    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    return resolved;
    }
};

// Constants for message
SonarArcNum.Constants = {
  NO_DISTANCE: 0,
  ARC1: 1,
  ARC2: 2,
  ARC3: 3,
  ARC4: 4,
  ARC5: 5,
  ARC6: 6,
  ARC7: 7,
  ARC8: 8,
  NO_ARC: 15,
}

module.exports = SonarArcNum;
